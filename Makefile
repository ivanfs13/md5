# $Id: Makefile,v 1.7 2007/10/11 00:02:56 carregal Exp $

CONFIG= ./config

include $(CONFIG)

# Default prefix
export PREFIX = /usr/local

# Lua version
export LUA_SYS_VER = 5.1

COMPAT52_OBJS= src/compat-5.2.o

MD5_OBJS= src/md5.o src/md5lib.o
MD5_LUAS= src/md5.lua
MD5_LIBNAME = core.so

DES56_OBJS= src/des56.o src/ldes56.o
DES56_LIBNAME= des56.so

all: src/$(MD5_LIBNAME) src/$(DES56_LIBNAME)

src/$(MD5_LIBNAME) : $(MD5_OBJS) $(COMPAT52_OBJS)
	$(CC) $(CFLAGS) $(LIB_OPTION) -o src/$(MD5_LIBNAME) $(MD5_OBJS) $(COMPAT52_OBJS)

src/$(DES56_LIBNAME) : $(DES56_OBJS) $(COMPAT52_OBJS)
	$(CC) $(CFLAGS) $(LIB_OPTION) -o src/$(DES56_LIBNAME) $(DES56_OBJS) $(COMPAT52_OBJS)

install: src/$(MD5_LIBNAME) src/$(DES56_LIBNAME)
	cp src/$(DES56_LIBNAME) $(LUA_LIBDIR)
	mkdir -p $(LUA_LIBDIR)/md5
	cp src/$(MD5_LIBNAME) $(LUA_LIBDIR)/md5/
	mkdir -p $(LUA_DIR)
	cp $(MD5_LUAS) $(LUA_DIR)

clean:
	rm -f $(MD5_OBJS) src/$(MD5_LIBNAME) $(DES56_OBJS) src/$(DES56_LIBNAME) $(COMPAT52_OBJS)
