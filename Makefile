.SUFFIXES:
.SUFFIXES: .ps .pdf .dvi .eps

# Base Files
TARGETS=dissertation.t
TEXFILES=$(wildcard *.tex)
BIBFILES=$(wildcard *.bib)


# Programs
PDFLATEX=$(shell which pdflatex)
DVIPS=$(shell which dvips)
PS2PDF=$(shell which ps2pdf)
BIBTEX=$(shell which bibtex)
GIT=$(shell which git)
PDFVIEWER=open

# Initialzie Variables

.PHONEY: default clean clean-tex clean-img distclean all

all: $(TARGETS:.t=.pdf)

revision.tex: revision.sh
	./revision.sh $@

default: all


%.pdf: $(TEXFILES) $(BIBFILES) revision.tex
	$(PDFLATEX) $(@:.pdf=.tex) || true
#	bibtex $(@:.pdf=.tex)
# Uncomment when using bibtex again.
	$(BIBTEX) $(@:.pdf=)
	$(PDFLATEX) $(@:.pdf=.tex) || true
	$(PDFLATEX) $(@:.pdf=.tex) || true
	$(PDFLATEX) $(@:.pdf=.tex)


clean:
	rm -f *.aux *.dvi *.log *~ *.out *.ps *.pdf *.bbl *.blg *.toc *.cb *.cb2 *.lox *.upa *.upb *.xwm
	rm -f arrows.code.tex revision.tex

distclean: clean

view: dissertation.pdf
	$(PDFVIEWER) dissertation.pdf &
