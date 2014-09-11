#-----------------------------------------------#
#	Makefile for dos systems		#
#    using a Turbo C compiler			#
#-----------------------------------------------#
CC=tcc
CFLAGS=-v -w -ml

OBJS = \
	matrix1.obj \
	matrix2.obj \
	matrix3.obj \
	matrix4.obj \
	matrix5.obj \
	matrix6.obj \
	matrix7.obj \
	matrix8.obj \
	matrix9.obj

all: $(OBJS) 

matrix1.obj: matrix1.c
	$(CC) $(CFLAGS) -c matrix1.c

matrix2.obj: matrix2.c
	$(CC) $(CFLAGS) -c matrix2.c

matrix3.obj: matrix3.c
	$(CC) $(CFLAGS) -c matrix3.c

matrix4.obj: matrix4.c
	$(CC) $(CFLAGS) -c matrix4.c

matrix5.obj: matrix5.c
	$(CC) $(CFLAGS) -c matrix5.c

matrix6.obj: matrix6.c
	$(CC) $(CFLAGS) -c matrix6.c

matrix7.obj: matrix7.c
	$(CC) $(CFLAGS) -c matrix7.c

matrix8.obj: matrix8.c
	$(CC) $(CFLAGS) -c matrix8.c

matrix9.obj: matrix9.c
	$(CC) $(CFLAGS) -c matrix9.c

clean:
	del matrix1.obj
	del matrix2.obj
	del matrix3.obj
	del matrix4.obj
	del matrix5.obj
	del matrix6.obj
	del matrix7.obj
	del matrix8.obj
	del matrix9.obj
