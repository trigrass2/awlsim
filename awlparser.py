#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# AWL parser
# Copyright 2012 Michael Buesch <m@bues.ch>
#
# Licensed under the terms of the GNU General Public License version 2.
#

import sys
import re

from util import *


class RawAwlInsn(object):
	def __init__(self, block):
		self.block = block
		self.lineNr = 0
		self.label = None
		self.name = None
		self.ops = []

	__labelRe = re.compile(r'^[_a-zA-Z][_0-9a-zA-Z]{0,3}$')

	@classmethod
	def isValidLabel(cls, labelString):
		# Checks if string is a valid label or
		# label reference (without colons).
		return bool(cls.__labelRe.match(labelString))

	def __repr__(self):
		ret = []
		if self.hasLabel():
			ret.append(self.getLabel() + ':\t')
		else:
			ret.append('\t')
		ret.append(self.getName())
		ret.extend(self.getOperators())
		return "\t".join(ret)

	def setLineNr(self, newLineNr):
		self.lineNr = newLineNr

	def getLineNr(self):
		return self.lineNr

	def setLabel(self, newLabel):
		self.label = newLabel

	def getLabel(self):
		return self.label

	def hasLabel(self):
		return bool(self.getLabel())

	def setName(self, newName):
		self.name = newName

	def getName(self):
		return self.name

	def setOperators(self, newOperators):
		self.ops = newOperators

	def getOperators(self):
		return self.ops

	def hasOperators(self):
		return bool(self.getOperators())

class RawAwlBlock(object):
	def __init__(self, tree, index):
		self.tree = tree
		self.index = index

	def hasLabel(self, string):
		return False

class RawAwlCodeBlock(RawAwlBlock):
	def __init__(self, tree, index):
		RawAwlBlock.__init__(self, tree, index)
		self.insns = []

	def hasLabel(self, string):
		if RawAwlInsn.isValidLabel(string):
			for insn in self.insns:
				if insn.getLabel() == string:
					return True
		return False

class RawAwlDB(RawAwlBlock):
	class Field(object):
		def __init__(self, name, value, type):
			self.name = name
			self.value = value
			self.type = type

	def __init__(self, tree, index):
		RawAwlBlock.__init__(self, tree, index)
		self.fields = []
		self.fb = None

	def getByName(self, name):
		for field in self.fields:
			if field.name == name:
				return field
		return None

class RawAwlOB(RawAwlCodeBlock):
	def __init__(self, tree, index):
		RawAwlCodeBlock.__init__(self, tree, index)

class RawAwlFB(RawAwlCodeBlock):
	def __init__(self, tree, index):
		RawAwlCodeBlock.__init__(self, tree, index)

class RawAwlFC(RawAwlCodeBlock):
	def __init__(self, tree, index):
		RawAwlCodeBlock.__init__(self, tree, index)

class AwlParseTree(object):
	def __init__(self):
		self.dbs = {}
		self.fbs = {}
		self.fcs = {}
		self.obs = {}

		self.curBlock = None

class AwlParser(object):
	STATE_GLOBAL		= 0
	STATE_IN_DB_HDR		= 1
	STATE_IN_DB_HDR_STRUCT	= 2
	STATE_IN_DB		= 3
	STATE_IN_FB_HDR		= 4
	STATE_IN_FB		= 5
	STATE_IN_FC_HDR		= 6
	STATE_IN_FC		= 7
	STATE_IN_OB_HDR		= 8
	STATE_IN_OB		= 9

	def __init__(self):
		self.reset()

	def reset(self):
		self.state = self.STATE_GLOBAL
		self.tree = AwlParseTree()

	def __setState(self, newState):
		self.state = newState

	def __inAnyHeader(self):
		if self.flatLayout:
			return False
		return self.state in (self.STATE_IN_DB_HDR,
				      self.STATE_IN_DB_HDR_STRUCT,
				      self.STATE_IN_FB_HDR,
				      self.STATE_IN_FC_HDR,
				      self.STATE_IN_OB_HDR)

	def __inAnyHeaderOrGlobal(self):
		if self.flatLayout:
			return False
		return self.__inAnyHeader() or\
		       self.state == self.STATE_GLOBAL

	def __parseLine(self, line):
		line = line.strip()
		if not line:
			return None
		tokens = []
		curToken = ""
		inQuote = False
		for i, c in enumerate(line):
			if c == '"':
				inQuote = not inQuote
			if c == ';' and not inQuote:
				# Semicolon ends statement.
				break
			if not inQuote and\
			   c == '/' and i + 1 < len(line) and\
			   line[i + 1] == '/':
				# This is a //comment. Stop parsing line.
				break
			if tokens and not inQuote:
				if (self.__inAnyHeaderOrGlobal() and\
				    c in ('=', ':')) or\
				   (c == ','):
					# Handle non-space token separators.
					curToken = curToken.strip()
					if curToken:
						tokens.append(curToken)
					tokens.append(c)
					curToken = ""
					continue
			if not c.isspace() or inQuote:
				curToken += c
			if (c.isspace() and not inQuote) or\
			   i == len(line) - 1:
				# Handle space token separator and end of line.
				curToken = curToken.strip()
				if curToken:
					tokens.append(curToken)
				curToken = ""
		if curToken:
			tokens.append(curToken)
		if inQuote:
			raise AwlParserError("Unterminated quote: " + line)
		if not tokens:
			return None

		if self.state == self.STATE_GLOBAL or\
		   self.flatLayout:
			return self.__parseTokens_global(line, tokens)
		if self.state == self.STATE_IN_DB_HDR:
			return self.__parseTokens_db_hdr(line, tokens)
		if self.state == self.STATE_IN_DB_HDR_STRUCT:
			return self.__parseTokens_db_hdr_struct(line, tokens)
		if self.state == self.STATE_IN_DB:
			return self.__parseTokens_db(line, tokens)
		if self.state == self.STATE_IN_FB_HDR:
			return self.__parseTokens_fb_hdr(line, tokens)
		if self.state == self.STATE_IN_FB:
			return self.__parseTokens_fb(line, tokens)
		if self.state == self.STATE_IN_FC_HDR:
			return self.__parseTokens_fc_hdr(line, tokens)
		if self.state == self.STATE_IN_FC:
			return self.__parseTokens_fc(line, tokens)
		if self.state == self.STATE_IN_OB_HDR:
			return self.__parseTokens_ob_hdr(line, tokens)
		if self.state == self.STATE_IN_OB:
			return self.__parseTokens_ob(line, tokens)
		assert(0)

	def __parseTokens_global(self, line, tokens):
		if self.flatLayout:
			if not self.tree.obs:
				self.tree.obs[1] = RawAwlOB(self.tree, 1)
			if not self.tree.curBlock:
				self.tree.curBlock = self.tree.obs[1]
			insn = self.__parseInstruction(line, tokens)
			self.tree.obs[1].insns.append(insn)
			return

		try:
			if tokens[0].upper() == "DATA_BLOCK":
				self.__setState(self.STATE_IN_DB_HDR)
				if tokens[1].upper() != "DB":
					raise AwlParserError("Invalid DB name")
				try:
					dbNumber = int(tokens[2], 10)
				except ValueError:
					raise AwlParserError("Invalid DB number")
				self.tree.curBlock = RawAwlDB(self.tree, dbNumber)
				self.tree.dbs[dbNumber] = self.tree.curBlock
				return
			if tokens[0].upper() == "FUNCTION_BLOCK":
				self.__setState(self.STATE_IN_FB_HDR)
				if tokens[1].upper() != "FB":
					raise AwlParserError("Invalid FB name")
				try:
					fbNumber = int(tokens[2], 10)
				except ValueError:
					raise AwlParserError("Invalid FB number")
				self.tree.curBlock = RawAwlFB(self.tree, fbNumber)
				self.tree.fbs[fbNumber] = self.tree.curBlock
				return
			if tokens[0].upper() == "FUNCTION":
				self.__setState(self.STATE_IN_FC_HDR)
				if tokens[1].upper() != "FC":
					raise AwlParserError("Invalid FC name")
				try:
					fcNumber = int(tokens[2], 10)
				except ValueError:
					raise AwlParserError("Invalid FC number")
				self.tree.curBlock = RawAwlFC(self.tree, fcNumber)
				self.tree.fcs[fcNumber] = self.tree.curBlock
				return
			if tokens[0].upper() == "ORGANIZATION_BLOCK":
				self.__setState(self.STATE_IN_OB_HDR)
				if tokens[1].upper() != "OB":
					raise AwlParserError("Invalid OB name")
				try:
					obNumber = int(tokens[2], 10)
				except ValueError:
					raise AwlParserError("Invalid OB number")
				self.tree.curBlock = RawAwlOB(self.tree, obNumber)
				self.tree.obs[obNumber] = self.tree.curBlock
				return
		except IndexError as e:
			raise AwlParserError("Missing token")
		except ValueError as e:
			raise AwlParserError("Invalid value")
		raise AwlParserError("Unknown statement")

	def __parseInstruction(self, line, tokens):
		insn = RawAwlInsn(self.tree.curBlock)
		insn.setLineNr(self.lineNr)
		if tokens[0].endswith(":"):
			# First token is a label
			if len(tokens) <= 1:
				raise AwlParserError("Invalid standalone "
					"label: " + line)
			label = tokens[0][0:-1]
			if not label or not RawAwlInsn.isValidLabel(label):
				raise AwlParserError("Invalid label: " + line)
			insn.setLabel(label)
			tokens = tokens[1:]
		if not tokens:
			raise AwlParserError("No instruction name: " + line)
		insn.setName(tokens[0])
		tokens = tokens[1:]
		if tokens:
			# Operators to insn are specified
			insn.setOperators(tokens)
		return insn

	def __parseTokens_db_hdr(self, line, tokens):
		if tokens[0].upper() == "BEGIN":
			self.__setState(self.STATE_IN_DB)
			return
		if tokens[0].upper() == "STRUCT":
			self.__setState(self.STATE_IN_DB_HDR_STRUCT)
			return
		if tokens[0].upper() in ("FB", "SFB"):
			try:
				if len(tokens) != 2:
					raise ValueError
				fbName = tokens[0].upper()
				fbNumber = int(tokens[1], 10)
			except ValueError:
				raise AwlParserError("Invalid FB/SFB binding")
			self.tree.curBlock.fb = (fbName, fbNumber)
			return
		pass#TODO

	def __parseTokens_db_hdr_struct(self, line, tokens):
		if tokens[0].upper() == "END_STRUCT":
			self.__setState(self.STATE_IN_DB_HDR)
			return
		if len(tokens) == 3 and tokens[1] == ":":
			name, type = tokens[0], tokens[2]
			field = RawAwlDB.Field(name, None, type)
			self.tree.curBlock.fields.append(field)
		else:
			raise AwlParserError("Unknown tokens: " + line)

	def __parseTokens_db(self, line, tokens):
		if tokens[0].upper() == "END_DATA_BLOCK":
			self.__setState(self.STATE_GLOBAL)
			return
		if len(tokens) == 3 and tokens[1] == ":=":
			name, value = tokens[0], tokens[2]
			db = self.tree.curBlock
			field = db.getByName(name)
			if field:
				field.value = value
			else:
				field = RawAwlDB.Field(name, value, None)
				db.fields.append(field)
		else:
			raise AwlParserError("Unknown tokens: " + line)

	def __parseTokens_fb_hdr(self, line, tokens):
		if tokens[0].upper() == "BEGIN":
			self.__setState(self.STATE_IN_FB)
			return
		pass#TODO

	def __parseTokens_fb(self, line, tokens):
		if tokens[0].upper() == "END_FUNCTION_BLOCK":
			self.__setState(self.STATE_GLOBAL)
			return
		if tokens[0].upper() == "NETWORK" or\
		   tokens[0].upper() == "TITLE":
			return # ignore
		insn = self.__parseInstruction(line, tokens)
		self.tree.curBlock.insns.append(insn)

	def __parseTokens_fc_hdr(self, line, tokens):
		if tokens[0].upper() == "BEGIN":
			self.__setState(self.STATE_IN_FC)
			return
		pass#TODO

	def __parseTokens_fc(self, line, tokens):
		if tokens[0].upper() == "END_FUNCTION":
			self.__setState(self.STATE_GLOBAL)
			return
		if tokens[0].upper() == "NETWORK" or\
		   tokens[0].upper() == "TITLE":
			return # ignore
		insn = self.__parseInstruction(line, tokens)
		self.tree.curBlock.insns.append(insn)

	def __parseTokens_ob_hdr(self, line, tokens):
		if tokens[0].upper() == "BEGIN":
			self.__setState(self.STATE_IN_OB)
			return
		pass#TODO

	def __parseTokens_ob(self, line, tokens):
		if tokens[0].upper() == "END_ORGANIZATION_BLOCK":
			self.__setState(self.STATE_GLOBAL)
			return
		if tokens[0].upper() == "NETWORK" or\
		   tokens[0].upper() == "TITLE":
			return # ignore
		insn = self.__parseInstruction(line, tokens)
		self.tree.curBlock.insns.append(insn)

	def parseFile(self, filename):
		self.parseData(awlFileRead(filename))

	def parseData(self, data):
		self.reset()
		self.lineNr = 0
		self.flatLayout = not re.match(r'.*^\s*ORGANIZATION_BLOCK\s+.*',
					       data, re.DOTALL | re.MULTILINE)
		for line in data.splitlines():
			self.lineNr += 1
			line = line.strip()
			if not line:
				continue
			ex = None
			try:
				self.__parseLine(line)
			except AwlParserError as e:
				ex = e
			if ex:
				raise AwlParserError("Parser ERROR at AWL line %d: %s\n%s" %\
					(self.lineNr, line, str(ex)))

	def getParseTree(self):
		return self.tree

if __name__ == "__main__":
	p = AwlParser()
	p.parseFile(sys.argv[1])
