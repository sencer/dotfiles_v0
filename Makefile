all: $(filter-out Makefile, $(wildcard *)) 
	for i in $^; do \
		ln -s $(shell pwd)/$$i ${HOME}/.$$i; \
	done; \
	ln -s $(shell pwd)/bin ${HOME}/bin; \
	rm -f ${HOME}/.bin
