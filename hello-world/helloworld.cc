//
// Set up a clasp.h include file with all the good stuff
//
#define _TARGET_OS_LINUX 1
#define _ADDRESS_MODEL_64 1
#define CLASP_GC_FILENAME "clasp_gc_cando.cc"
#define GC_DECLARE_FORWARDS 1//get  clasp_gc_cando.cc working
#include CLASP_GC_FILENAME
#include <stdio.h>
#include <clasp/core/foundation.h>
#include <clasp/core/configure_clasp.h>
#include <clasp/core/core.h>
#include <clasp/core/corePackage.h>


// #include <clasp/core/scrape.h>

// #include <clasp/gctools/gctoolsPackage.h>
// #include <clasp/gctools/memoryManagement.h>


// #include <clasp/core/coretypes.h>
// #include <clasp/core/object.h>

#include <clasp/clbind/clbind.h>
//  #include <clasp/core/lambdaListHandler.h>


// // clasp.h brings in everything needed for interop
 #include <clasp/clasp.h>

void helloWorld()
{
    printf("Hello World\n");
    printf("This is C++ code being invoked from Clasp Common Lisp\n");
}

// double addThreeNumbers(double x, double y, double z)
// {
//     return x+y+z;
// }

// #if 0
// namespace translate {
//     template <>
//     struct from_object<float, std::true_type> {
// 	typedef float DeclareType;
// 	DeclareType _v;
// 	from_object(core::T_sp o) : _v(o.unsafe_single_float()) {};
//     };

//     template <>
//     struct to_object<float> {
// 	typedef float GivenType;
// 	static core::T_sp convert(GivenType v) {
// 	    return core::make_single_float(v);
// 	}
//     };
// };
// #endif
    
// float addThreeSingleFloats(float x, float y, float z)
// {
//     return x+y+z;
// }

// double addThreeNumbers_n_times(size_t n, double x, double y, double z)
// {
//     double result = 0.0;
//     for (size_t i(0); i<n; ++i ) {
// 	result += x+y+z;
//     }
//     return result;
// }

void startup()
{
    using namespace clbind;
    package("HW") [
		   def("hello-world",&helloWorld)
//		   , def("addThreeNumbers",&addThreeNumbers)
//		   , def("addThreeSingleFloats",&addThreeSingleFloats)
//		   , def("addThreeNumbers_n_times", &addThreeNumbers_n_times)
		   ];
}


// ------------------------------------------------------------
//
// Set this code up so that it can be loaded into Clasp
//

CLASP_REGISTER_STARTUP(startup);
