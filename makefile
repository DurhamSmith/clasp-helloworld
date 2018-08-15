# makefile
#

export TARGET_OS ?= $(shell uname)
export TARGET_OS := $(or $(filter $(TARGET_OS), Linux),\
                         $(filter $(TARGET_OS), Darwin),\
                         $(error Invalid TARGET_OS: $(TARGET_OS)))

include $(wildcard local.config)

# These are things that I'm hardcoding for now
# but should be set up better using waf
#
# CLASP_GC_FILENAME defines the interface to the GC
# the name depends on what extensions are in this
# version of clasp
export CLASP_GC_FILENAME='"clasp_gc_cando.cc"'
# GC sets the name of the GC
export GC=boehm


# ifeq ($(CC),)
# export CLANG = $(EXTERNALS_CLASP_DIR)/build/release/bin/clang++
# endif
export CLANG = /usr/bin/clang++-6.0


# In local.config export the following environment variables
# EXTERNALS_CLASP_DIR
# CLASP_HOME
# CLASP_RUNTIME  (boehm, mps, boehmdc)

include $(wildcard local.config)

# setup the clasp executable


# Location of clasp
export CLASP_HOME = /root/clasp_home/clasp

# The Clasp runtime you want to use (boehm, mps, boehmdc)
export CLASP_RUNTIME = boehm

export CLASP = $(CLASP_HOME)/build/$(CLASP_RUNTIME)/cclasp-$(CLASP_RUNTIME)

# These are things that I'm hardcoding for now
# but should be set up better using waf
#
# -DNDEBUG suppresses link_compatibility checking in clbind that always fails - must fix


export OPTIONS = -v -I$(CLASP_HOME)/include \
		-I$(CLASP_HOME)/extensions/cando/include \
		-I$(CLASP_HOME)/src/main \
		-I$(CLASP_HOME)/extensions/cando/src \
		-I$(CLASP_HOME)/include/clasp/main \
		-I$(CLASP_HOME)/build/$(CLASP_RUNTIME) \
		-I$(CLASP_HOME)/build/$(CLASP_RUNTIME)/generated \
		-I /usr/include/llvm-6.0/ \
		-c -emit-llvm \
		-std=c++11 \
		-Wno-macro-redefined \
		-Wno-deprecated-register \
		-Wno-inconsistent-missing-override





all:
	(cd hello-world; make $*)

test:
	(cd hello-world; make test)

#
# Run the demos after typing:    make shell
#    - this will set CLASP_DEMO_HOME and the demos will find the bitcode files
#
shell:
	echo Now CLASP_DEMO_HOME is set to $(CLASP_DEMO_HOME)
	bash


ir:
	clang++ -c -emit-llvm -std=c++11 -stdlib=libc++ -fvisibility=hidden -o hello-world-cxx.bc hello-world-cxx.cc
	llvm-dis helloWorld.bc


clean:
	(cd hello-world; rm -f *.bc *.so *.ll)
	(cd double-vector; rm -f *.bc *.so *.ll)
