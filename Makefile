ifeq ($(DRY_RUN),1)
RUNNER=@echo
else
RUNNER=
endif

install:
	@if [[ "${DRY_RUN}" -eq 1 ]]; then echo "Dry run; not actually installing things!"; fi
	$(RUNNER) install -m644 dataprinter $(HOME)/.dataprinter
	$(RUNNER) install -m644 gitconfig $(HOME)/.gitconfig
	$(RUNNER) install -m644 inputrc $(HOME)/.inputrc
	$(RUNNER) install -m644 luarc $(HOME)/.luarc
	$(RUNNER) install -m644 perlcriticrc $(HOME)/.perlcriticrc
	$(RUNNER) mkdir -p $(HOME)/.re.pl
	$(RUNNER) install -m644 repl.rc $(HOME)/.re.pl/repl.rc
	$(RUNNER) install -m644 tmux.conf $(HOME)/.tmux.conf
	$(RUNNER) install -m644 Xdefaults $(HOME)/.Xdefaults
	$(RUNNER) mkdir -p $(HOME)/.config/pms
	$(RUNNER) install -m644 pmus-rc $(HOME)/.config/pms/rc
	$(RUNNER) mkdir -p $(HOME)/.git/templates
	$(RUNNER) if [[ -e /usr/share/git-core/templates ]]; then \
	    rsync -ar /usr/share/git-core/templates/ $(HOME)/.git/templates/ ; \
	elif [[ -e /usr/local/share/git-core/templates ]]; then \
	    rsync -ar /usr/local/share/git-core/templates/ $(HOME)/.git/templates/ ; \
	fi
	$(RUNNER) rsync -ar git-templates/ $(HOME)/.git/templates/
	$(RUNNER) cat repos | while read repo install_location ; do \
	    install_location=$${install_location/\~/$(HOME)} ; \
	    if [[ ! -e "$$install_location" ]] ; then \
		mkdir -p $$(dirname $$install_location) ; \
		git clone $$repo $$install_location ; \
		if [[ -e "$$install_location/Makefile" ]] ; then \
		    $(MAKE) -C $$install_location ; \
		fi ; \
	    fi ; \
	done
