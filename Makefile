SOURCES:=$(shell \
	find . -not \( \
		\( \
			-name .git \
			-or -name build \
		\) -prune \
	\) \( \
		-name '*.ico' \
		-or -name '*.png' \
		-or -name '*.jpg' \
		-or -name '*.html' \
		-or -name '*.txt' \
	\) \
	-printf '%P\n' \
)
TARGETS:=$(SOURCES:%=build/%)
TARGETS+=build/sitemap.txt

all: $(TARGETS)

clean:
	rm -rf build/

.PHONY: all clean
.SUFFIXES:

build/%.html: %.html render.sh css/style.css
	@mkdir -p $(dir $@)
	./render.sh $< > $@
	@gzip -9k $@

build/sitemap.txt: $(SOURCES)
	@mkdir -p $(dir $@)
	@printf 'https://omiltem.net/%s\n' $^ | grep '\.html$$' | sed -e 's/\/index.html$$/\//' > $@
	@echo 'map > sitemap.txt'

build/%.txt: %.txt
	@mkdir -p $(dir $@)
	cp $< $@
	@gzip -9k $@

build/%: %
	@mkdir -p $(dir $@)
	cp $< $@
