#!/usr/bin/make

prefix	:= $(HOME)/local/bin

sh_dir	:= $(shell pwd)
shells	:= $(notdir $(wildcard $(sh_dir)/*.sh))

links	:= $(addprefix $(prefix)/,$(shells:.sh=))

#_______________________________________________________________________________
.PHONY: all install show clean uninstall

all: install

install: $(links)

show:
	@ echo "prefix = $(prefix)"
	@ echo -n "shells = "
	@ echo " $(shells)" | sed "s: :\n\t:g"
	@ echo -n "links  = "
	@ echo " $(links)" | sed "s: :\n\t:g"

$(prefix)/%: $(sh_dir)/%.sh
	@ ln -sv $^ $@

clean:
	@ echo "=== Cleaning"
	@ rm -rfv *~ \#*\#

uninstall:
	@ for s in $(links); do \
	if [ -L $$s ]; then echo uninstall $$s; unlink $$s; fi; \
	done
