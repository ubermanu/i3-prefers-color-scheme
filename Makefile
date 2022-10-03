INSTALL = /bin/install -c
DESTDIR =
BINDIR = /bin

ifeq ($(PREFIX),)
	PREFIX := /usr/local
endif

install:
	$(INSTALL) -d $(DESTDIR)$(PREFIX)$(BINDIR)
	$(INSTALL) -m755 prefers-color-scheme.bash $(DESTDIR)$(PREFIX)$(BINDIR)/i3-prefers-color-scheme
