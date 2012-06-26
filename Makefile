ifeq ($(DRY_RUN),1)
RUNNER=@echo
else
RUNNER=
endif

INSTALL_DIR=$(HOME)

install:
	@if [[ "${DRY_RUN}" -eq 1 ]]; then echo "Dry run; not actually installing things!"; fi
	$(RUNNER) install -m644 dataprinter $(INSTALL_DIR)/.dataprinter
	$(RUNNER) install -m644 gitconfig $(INSTALL_DIR)/.gitconfig
	$(RUNNER) install -m644 inputrc $(INSTALL_DIR)/.inputrc
	$(RUNNER) install -m644 luarc $(INSTALL_DIR)/.luarc
	$(RUNNER) install -m644 perlcriticrc $(INSTALL_DIR)/.perlcriticrc
	$(RUNNER) mkdir -p $(INSTALL_DIR)/.re.pl
	$(RUNNER) install -m644 repl.rc $(INSTALL_DIR)/.re.pl/repl.rc
	$(RUNNER) install -m644 tmux.conf $(INSTALL_DIR)/.tmux.conf
	$(RUNNER) install -m644 Xdefaults $(INSTALL_DIR)/.Xdefaults
	$(RUNNER) mkdir -p $(INSTALL_DIR)/.config/pms
	$(RUNNER) install -m644 pmus-rc $(INSTALL_DIR)/.config/pms/rc
	$(RUNNER) mkdir -p $(INSTALL_DIR)/.git/templates
	$(RUNNER) if [[ -e /usr/share/git-core/templates ]]; then \
	    rsync -ar /usr/share/git-core/templates/ $(INSTALL_DIR)/.git/templates/ ; \
	elif [[ -e /usr/local/share/git-core/templates ]]; then \
	    rsync -ar /usr/local/share/git-core/templates/ $(INSTALL_DIR)/.git/templates/ ; \
	fi
	$(RUNNER) rsync -ar git-templates/ $(INSTALL_DIR)/.git/templates/
	$(RUNNER) cat repos | while read repo install_location ; do \
	    install_location=$${install_location/\~/$(INSTALL_DIR)} ; \
	    if [[ ! -e "$$install_location" ]] ; then \
		mkdir -p $$(dirname $$install_location) ; \
		git clone $$repo $$install_location ; \
		if [[ -e "$$install_location/Makefile" ]] ; then \
		    $(MAKE) -C $$install_location ; \
		fi ; \
	    fi ; \
	done

bundle:
	tmpdir=`mktemp -d -t bundle` ; \
	make install INSTALL_DIR="$$tmpdir" ; \
	find "$$tmpdir" -name .git -print0 | xargs -0 rm -rf ; \
	( cd "$$tmpdir" ; tar czf - . ) > bundle.tar.gz ; \
	rm -rf "$$tmpdir"
