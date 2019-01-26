# TODO

1. Wrap Market Data (MdAPI) first

- Import C++ data type definitions to Cython, Cython needs to know more about those data types, apart from adding  
an "#include <.h>". 
    - Write scripts to generate huge amount of data type definitions, in cython definition files (.pxd) (done)
    
- Write a C++ class to wrap around Api/Spi C++ classes, in order to call appropriate python functions in a callback (done)
    This is a C++ to Python direction connection 
    - Wrap and implement Python instance callback logic for MdSpi class, in a c++ header file
    - Wrap around the API methods for MdApi class, in a pxd file, exposing it to Python  
        Note that in this step, we will need to "cdef extern from" the modified MdSpi declaration in last point. We'll
        also change the signature of registerSpi(CThostFtdcMdSpi*) to accept its subclass CMdSpi
    - the static factor method in CThostFtdcMdApi is exposed as a standalone function
    - CThostFtdcMdApi is renamed CMdApi in .pxd, for consistency with CMdSpi
    - After we're done, MdApi.pxd contains everything we need for the market data interface, including two C++ classes
    `CMdSpi` and `CMdApi`, that we are going to finally consolidate into one Python-accessible class to serve user

- Expose C++ Classes to Cython scripts (done)

- Wrap appropriate C++ classes as Cython classes (done)
- Generate Python ctypes class definition for all c++ structs in a .py file (working on this) (done)
    - A base class
    - One class (subtype of ctypes) for each struct
    - Give a modified `__init__` with proper parameters for each struct so it is more friendly to construct
- Wrap extension classes in the final User-accessible Classes (done)

- Compile Cython scripts to C file (done)
- Build .so library (done)
- Test