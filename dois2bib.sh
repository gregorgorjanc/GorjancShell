#!/bin/bash
curl -LH "Accept: application/x-bibtex" -w "\n" $(< $1) > dois.bib
