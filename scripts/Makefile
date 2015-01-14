#
# Makefile template 
# Can split a single line into multiple line using \
#

# *.h files
HEADERS		= 

# *.c files
C_SRCS		= 

# *.o files
C_OBJS		= 

# Executable name
EXE		= 

#
# You should not need to change anything below this line
#
GCC		= gcc
CC		= g++
LINT	= lint

GCC_FLAGS	= -c -g -W -Wall -D__EXTENSIONS__
CXXFLAGS	= -std=c++11 -O2 
LINT_FLAGS1	= -c -err=warn
LINT_FLAGS2	= -u -err=warn
LD_FLAGS	= -g -W -Wall

#
# Standard rules
#

#
# Simply have our project target be a single default ${EXE} executable.
#

${EXE}:	${OBJS}
	${GCC} -o ${EXE} ${LD_FLAGS} ${OBJS}

${C_OBJS}:      ${HEADERS}

clean:
	rm -f *.o ${EXE} *.ln core a.out \
	@echo "Clean."

new:
	make clean
	make

