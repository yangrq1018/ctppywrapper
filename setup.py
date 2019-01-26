import os
import sys

'''
Note that when using setuptools, you should import it before Cython as setuptools may replace the Extension class in 
distutils. Otherwise, both might disagree about the class to use here.
'''

from setuptools import setup

from Cython.Build import cythonize, build_ext
from Cython.Distutils import Extension as Cython_Extension

from distutils.dir_util import copy_tree  # a better copy_tree than shutil #todo verify

import shutil  # high level file opearation

'''Define directories'''
base_dir = os.path.dirname(__file__)
project_dir = os.path.join(base_dir, 'ctpwrapper')  # where the package is located
ctp_dir = os.path.join(base_dir, 'ctp')
cython_headers = os.path.join(project_dir, "pxdheader")
headers = os.path.join(ctp_dir, "header")  # CTP headers
cpp_headers = os.path.join(project_dir, "cppheader")  # Extended CTP classes
lib_dir = None  # location of ctp shared objects
package_data = ["*.xml", "*.dtd"]
extra_link_args = None
extra_compile_args = None

if sys.platform == 'linux':
    lib_dir = os.path.join(ctp_dir, "linux")
    package_data.append("*.so")
    extra_compile_args = ["-Wall"]
    extra_link_args = ['-Wl,-rpath,$ORIGIN']  # instruct to look for CTP so in the same directory

package_data.append("error.dtd")
package_data.append("error.xml")
shutil.copy2(headers + '/error.dtd', project_dir + '/error.dtd')
shutil.copy2(headers + '/error.xml', project_dir + '/error.xml')

# the compiled python module will load those dynamic libraries at runtime
if sys.platform in ('linux', 'win32'):
    copy_tree(lib_dir, project_dir)

common_args = {
    'cython_include_dirs': [cython_headers],
    'include_dirs': [headers, cpp_headers],
    'library_dirs': [lib_dir],
    "language": "c++",
    "extra_compile_args": extra_compile_args,
    "extra_link_args": extra_link_args
}

# Cython extension modules (foreign language modules)
ext_modules = [
    Cython_Extension(name="ctpwrapper.MdApi",
                     sources=['ctpwrapper/MdApi.pyx'],  # relative to base dir # pxd will be automatically parsed
                     libraries=['thostmduserapi'],  # No lib
                     **common_args),
    Cython_Extension(name="ctpwrapper.TraderApi",
                     sources=['ctpwrapper/TraderApi.pyx'],
                     libraries=['thosttraderapi'],
                     **common_args)
]

# todo language level
'''
Language level

The str type is special in that it is the byte string in Python 2 and the Unicode string in Python 3 (for Cython code 
compiled with language level 2, i.e. the default). Meaning, it always corresponds exactly with the type that the Python
runtime itself calls str. Thus, in Python 2, both bytes and str represent the byte string type, whereas in Python 3,
both str and unicode represent the Python Unicode string type. The switch is made at C compile time, the Python version
that is used to run Cython is not relevant.

When compiling Cython code with language level 3, the str type is identified with exactly the Unicode string type at
Cython compile time, i.e. it does not identify with bytes when running in Python 2
 
https://cython.readthedocs.io/en/latest/src/tutorial/strings.html
'''

setup(
    name="ctpwrapper",
    description="CTP client v6.3.11",
    include_dirs=[headers, cpp_headers],
    packages=['ctpwrapper'],
    package_data={"": package_data},

    ext_modules=cythonize(ext_modules, compiler_directives={'language_level': 3, "binding": True}),

    cmdclass={"build_ext": build_ext}
)
