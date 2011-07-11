# Let PDFTEX run two times to get the toc
# cat chapters/anwendung.tex  | aspell --lang=de_DE -t list >> error.txt

PDFTEX = /Volumes/TeXLive2009/bin/universal-darwin/pdflatex
BIBTEX = /Volumes/TeXLive2009/bin/universal-darwin/bibtex
MV = /bin/mv
DATE = $(shell date)
ASPELL = /usr/local/bin/aspell
CAT = /bin/cat
DOC = main
CHAP = ./chapters/
OBJECTS = ${DOC}.aux ${DOC}.bbl ${DOC}.blg ${DOC}.ilg ${DOC}.ind ${DOC}.log ${DOC}.out ${DOC}.toc ${DOC}.spell


build: bib
	${MV} ${DOC}.pdf ./nightlybuild/${DOC}-"${DATE}".pdf

bib: pdf
	${BIBTEX} ${DOC}
	${PDFTEX} ${DOC}.tex

pdf: ${DOC}.tex
	${PDFTEX} ${DOC}.tex
	${PDFTEX} ${DOC}.tex

.PHONY: clean
clean:
	rm ${CHAP}*.aux
	rm ${CHAP}*.spell
	rm ${OBJECTS}
	

.PHONY: aspell
aspell:
	${CAT} ${DOC}.tex | ${ASPELL} --lang=de_DE -t list | sort | uniq > ${DOC}.spell ; \
	for file in ${CHAP}*.tex ; do \
		${CAT} $$file | ${ASPELL} --lang=de_DE -t list | sort | uniq > $$file.spell ; \
	done