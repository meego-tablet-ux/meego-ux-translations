
PROJECT = meego-ux-translations
VERSION = 1.2.12

TX_URL = https://meego.transifex.net/
TX_PRJ = projects/p/meego-ux/r/meego-1-2/

L10N_DIR = $(DESTDIR)/usr/share/qt4/translations/

LOCALES = ar \
	  ast \
	  bg_BG \
	  bn \
	  bn_IN \
	  bs \
	  ca \
	  ca@valencia \
	  cs \
	  da \
	  de \
	  el \
	  en_GB \
	  en_US \
	  eo \
	  es \
	  es_CR \
	  es_MX \
	  et \
	  eu \
	  fa \
	  fi \
	  fr \
	  gl \
	  gu \
	  he \
	  hi \
	  hi_IN \
	  hu \
	  id \
	  it \
	  ja \
	  km \
	  ko \
	  lo \
	  lt \
	  ml \
	  ms \
	  nb \
	  nl \
	  pa \
	  pl \
	  pt_BR \
	  pt \
	  ro \
	  ru \
	  sk \
	  sl \
	  sq \
	  sv \
	  ta \
	  th \
	  tl \
	  tr \
	  uk \
	  vi \
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
	localelist=`echo $(LOCALES) | sed 's/ /,/g'`; \
	tx pull -f -s -l $$localelist

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
