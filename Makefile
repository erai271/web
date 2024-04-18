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
		-or -name '*.css' \
		-or -name '*.html' \
	\) \
	-printf '%P\n' \
)
TARGETS:=$(SOURCES:%=build/%)

all: $(TARGETS)

clean:
	rm -rf build/

.PHONY: all clean
.SUFFIXES:

build/%.html: %.html render.sh css/style.css
	@mkdir -p $(dir $@)
	./render.sh $< > $@

build/%: %
	@mkdir -p $(dir $@)
	cp $< $@
