
PROJECT = meego-ux-translations
VERSION = 1.2.10

TX_URL = https://meego.transifex.net/
TX_PRJ = projects/p/meego-ux/r/meego-1-2/

L10N_DIR = $(DESTDIR)/usr/share/qt4/translations/

LOCALES = ar \
	  ast \
	  cs \
	  de \
	  el \
	  en_GB \
	  en_US \
	  es \
	  eu \
	  fi \
	  fr \
	  it \
	  ja \
	  km \
	  ko \
	  nl \
	  pa \
	  pl \
	  pt_BR \
	  pt \
	  ru \
	  sl \
	  sv \
	  tr \
	  uk \
	  wa \
	  zh_CN \
	  zh_TW

TSS = $(wildcard translations/*/*.ts)
QMS = $(patsubst %.ts, %.qm, $(TSS))

all: $(QMS)

pull:
	if [ ! -d .tx ]; then \
		tx init --host $(TX_URL); \
		tx set --auto-remote $(TX_URL)$(TX_PRJ); \
	fi
	localelist=`echo $(LOCALES) | sed 's/ /,/g'`
	tx pull -f -s -l "$$localelist"

%.qm: %.ts Makefile
	lrelease $< -qm $@

install: $(QMS)
	mkdir -p $(L10N_DIR)
	for FILE in $(QMS) ; do \
		install -m0644 $$FILE $(L10N_DIR); \
	done

dist:
	git tag v$(VERSION)
	git archive --format=tar --prefix="$(PROJECT)-$(VERSION)/" v$(VERSION) | \
		gzip > $(PROJECT)-$(VERSION).tar.gz

clean:
	rm -f $(QMS)
