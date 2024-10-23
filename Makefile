VERSION=`date +"%Y/%m/%d"` `LANG=en_GB`

all: \
	build\
	build/report.pdf

build:
	mkdir -p $@

%.markdown: %.md
	cp $^ $@

build/report.pdf: \
	metadata.yaml \
	title.md \
	README.md \
	
	pandoc \
		--standalone \
		--lua-filter table.lua \
		--read markdown+fancy_lists+definition_lists+link_attributes \
		--template https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/v1.2.4/eisvogel.tex\
		--metadata=date:"$(VERSION)" \
		--metadata=tables:"1" \
		--metadata=numbersections:"False" \
		-o $@ $^


images/%.pdf: images/%.svg
	rsvg-convert --format pdf $^ -o $@

clean:
	rm -Rf *.markdown build images/*.pdf *_files
