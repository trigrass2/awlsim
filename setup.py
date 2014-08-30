#!/usr/bin/env python3

from __future__ import print_function

import sys
import os
import platform
import errno
import re
import shutil
import hashlib
from distutils.core import setup
from distutils.extension import Extension
from awlsim.core.version import VERSION_MAJOR, VERSION_MINOR
try:
	import py2exe
except ImportError as e:
	py2exe = None


def makedirs(path, mode):
	try:
		os.makedirs(path, mode)
	except OSError as e:
		if e.errno == errno.EEXIST:
			return
		raise

def hashFile(path):
	if sys.version_info[0] < 3:
		ExpectedException = IOError
	else:
		ExpectedException = FileNotFoundError
	try:
		return hashlib.sha1(open(path, "rb").read()).hexdigest()
	except ExpectedException as e:
		return None

def __fileopIfChanged(fromFile, toFile, fileop):
	toFileHash = hashFile(toFile)
	if toFileHash is not None:
		fromFileHash = hashFile(fromFile)
		if toFileHash == fromFileHash:
			return False
	fileop(fromFile, toFile)
	return True

def copyIfChanged(fromFile, toFile):
	return __fileopIfChanged(fromFile, toFile, shutil.copy2)

def moveIfChanged(fromFile, toFile):
	return __fileopIfChanged(fromFile, toFile, os.rename)

def pyCythonPatch(toFile, fromFile):
	print("cython-patch: patching file '%s' to '%s'" %\
	      (fromFile, toFile))
	tmpFile = toFile + ".TMP"
	infd = open(fromFile, "r")
	outfd = open(tmpFile, "w")
	for line in infd.readlines():
		stripLine = line.strip()

		if not stripLine.endswith("#<no-cython-patch"):
			# Uncomment all lines containing <cython>
			if "<cython>" in stripLine:
				line = re.sub(r'#?<cython>\s*', "", line)
				if line.startswith("#"):
					line = line[1:]
				if not line.endswith("\n"):
					line += "\n"

			# Comment all lines containing <no-cython>
			if "<no-cython>" in stripLine:
				line = "#" + line

			# Patch the import statements
			line = re.sub(r'^from awlsim\.', "from awlsim_cython.", line)
			line = re.sub(r'^import awlsim\.', "import awlsim_cython.", line)

		outfd.write(line)
	infd.close()
	outfd.flush()
	outfd.close()
	if not moveIfChanged(tmpFile, toFile):
		print("(already up to date)")
		os.unlink(tmpFile)

class CythonBuildUnit(object):
	def __init__(self, baseName, fromPy, fromPxd, toDir, toPyx, toPxd):
		self.baseName = baseName
		self.fromPy = fromPy
		self.fromPxd = fromPxd
		self.toDir = toDir
		self.toPyx = toPyx
		self.toPxd = toPxd

cythonBuildUnits = []

def patchCythonModules():
	for unit in cythonBuildUnits:
		makedirs(unit.toDir, 0o755)
		if unit.baseName == "__init__":
			# Make a dummy-__init__
			if not os.path.isfile(unit.toPyx):
				fd = open(unit.toPyx, "w")
				fd.write("\n")
				fd.close()
		else:
			# Generate the .pyx
			pyCythonPatch(unit.toPyx, unit.fromPy)
		# Copy the .pxd, if any
		if os.path.isfile(unit.fromPxd):
			print("copying pxd file from '%s' to '%s'..." %\
			      (unit.fromPxd, unit.toPxd))
			if not copyIfChanged(unit.fromPxd, unit.toPxd):
				print("(already up to date)")

def registerCythonModules():
	global ext_modules
	global cythonBuildUnits

	modDir = os.path.join(os.curdir, "awlsim")
	# Make path to the cython patch-build-dir
	cythonBuildDir = os.path.join(os.curdir, "build", "awlsim_cython-patched.%s-%s-%d.%d" %\
		(platform.system().lower(),
		 platform.machine().lower(),
		 sys.version_info[0], sys.version_info[1])
	)

	if not os.path.exists(os.path.join(os.curdir, "setup.py")) or\
	   not os.path.exists(modDir) or\
	   not os.path.isdir(modDir):
		raise Exception("Wrong directory. "
			"Execute setup.py from within the awlsim directory.")

	# Walk the "awlsim" module
	for dirpath, dirnames, filenames in os.walk(modDir):
		subpath = os.path.relpath(dirpath, modDir)
		if subpath == os.curdir:
			subpath = ""

		if subpath.startswith("gui"):
			continue
		for filename in filenames:
			if filename.endswith(".py"):
				baseName = filename[:-3] # Strip .py

				fromPy = os.path.join(dirpath, baseName + ".py")
				fromPxd = os.path.join(dirpath, baseName + ".pxd")
				toDir = os.path.join(cythonBuildDir, subpath)
				toPyx = os.path.join(toDir, baseName + ".pyx")
				toPxd = os.path.join(toDir, baseName + ".pxd")

				# Remember the filenames for the build
				unit = CythonBuildUnit(baseName, fromPy, fromPxd, toDir, toPyx, toPxd)
				cythonBuildUnits.append(unit)

				# Construct the new cython module name
				modname = [ "awlsim_cython" ]
				if subpath:
					modname.extend(subpath.split(os.sep))
				modname.append(baseName)
				modname = ".".join(modname)

				# Create a distutils Extension for the module
				ext_modules.append(
					Extension(modname, [toPyx])
				)

def tryBuildCythonModules():
	try:
		if int(os.getenv("NOCYTHON", "0")):
			print("Skipping build of CYTHON modules due to "
			      "NOCYTHON environment variable setting.")
			return
	except ValueError:
		pass
	if os.name != "posix":
		print("WARNING: Not building CYTHON modules on '%s' platform." %\
		      os.name)
		return
	if "bdist_wininst" in sys.argv:
		print("WARNING: Omitting CYTHON modules while building "
		      "Windows installer.")
		return
	try:
		from Cython.Distutils import build_ext as Cython_build_ext
	except ImportError as e:
		print("WARNING: Could not build the CYTHON modules: "
		      "%s" % str(e))
		print("--> Is Cython installed?")
		return

	class MyCythonBuildExt(Cython_build_ext):
		def build_extensions(self):
			# First patch the files, the run the normal build
			patchCythonModules()
			Cython_build_ext.build_extensions(self)
	cmdclass["build_ext"] = MyCythonBuildExt
	registerCythonModules()

cmdclass = {}
ext_modules = []
extraScripts = []
extraKeywords = {}
# Try to build the Cython modules. This might fail.
tryBuildCythonModules()

# Workaround for mbcs codec bug in distutils
# http://bugs.python.org/issue10945
import codecs
try:
	codecs.lookup("mbcs")
except LookupError:
	codecs.register(lambda name: codecs.lookup("ascii") if name == "mbcs" else None)

# Add win postinstall script
try:
	idx = sys.argv.index("bdist_wininst")
	if idx > 0:
		sys.argv.insert(idx + 1, "--install-script")
		sys.argv.insert(idx + 2, "awlsim-wininst-postinstall.py")
		extraScripts.append("awlsim-wininst-postinstall.py")
except ValueError:
	pass

if py2exe:
	extraKeywords["console"] = [ "awlsim-cli",
				     "awlsim-gui",
				     "awlsim-server",
				     "awlsim-symtab",
				     "awlsim/coreserver/server.py", ]

setup(	name		= "awlsim",
	version		= "%d.%d" % (VERSION_MAJOR, VERSION_MINOR),
	description	= "S7 AWL/STL Soft-PLC",
	license		= "GNU General Public License v2 or later",
	author		= "Michael Buesch",
	author_email	= "m@bues.ch",
	url		= "http://bues.ch/cms/hacking/awlsim.html",
	packages	= [ "awlsim",
			    "awlsim/core",
			    "awlsim/core/instructions",
			    "awlsim/core/systemblocks",
			    "awlsim/coreserver",
			    "awlsim/gui",
			    "awlsimhw_debug",
			    "awlsimhw_dummy",
			    "awlsimhw_linuxcnc",
			    "awlsimhw_pyprofibus", ],
	scripts		= [ "awlsim-cli",
			    "awlsim-gui",
			    "awlsim-server",
			    "awlsim-symtab",
			    "awlsim-linuxcnc-hal",
			    "awlsim-win.bat", ] + extraScripts,
	cmdclass	= cmdclass,
	ext_modules	= ext_modules,
	keywords	= [ "AWL", "STL", "SPS", "PLC", "Step 7",
			    "Siemens", "emulator", "simulator",
			    "PROFIBUS", "LinuxCNC", ],
	classifiers	= [
		"Development Status :: 4 - Beta",
		"Environment :: Console",
		"Environment :: Win32 (MS Windows)",
		"Environment :: X11 Applications",
		"Intended Audience :: Developers",
		"Intended Audience :: Education",
		"Intended Audience :: Information Technology",
		"Intended Audience :: Manufacturing",
		"Intended Audience :: Science/Research",
		"License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
		"Operating System :: Microsoft :: Windows",
		"Operating System :: POSIX",
		"Operating System :: POSIX :: Linux",
		"Programming Language :: Cython",
		"Programming Language :: Python",
		"Programming Language :: Python :: 2.7",
		"Programming Language :: Python :: 3",
		"Programming Language :: Python :: Implementation :: CPython",
		"Programming Language :: Python :: Implementation :: PyPy",
		"Programming Language :: Python :: Implementation :: Jython",
		"Programming Language :: Python :: Implementation :: IronPython",
		"Topic :: Education",
		"Topic :: Home Automation",
		"Topic :: Scientific/Engineering",
		"Topic :: Software Development",
		"Topic :: Software Development :: Interpreters",
		"Topic :: Software Development :: Embedded Systems",
		"Topic :: Software Development :: Testing",
		"Topic :: System :: Emulators",
	],
	long_description = open("README.txt").read(),
	**extraKeywords
)
