all: $(filter-out Makefile, $(wildcard *)) 
	for i in $^; do \
		ln -s $(shell pwd)/$$i ${HOME}/.$$i; \
	done; \
	ln -s $(shell pwd)/bin ${HOME}/bin; \
	ln -s ${HOME}/.pry_history ${HOME}/.irb_history; \
	rm -f ${HOME}/.bin
