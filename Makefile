ifeq ($(DRY_RUN),1)
RUNNER=@echo
else
RUNNER=
endif

install:
	@if [[ "${DRY_RUN}" -eq 1 ]]; then echo "Dry run; not actually installing things!"; fi
	$(RUNNER) install -m644 dataprinter ~/.dataprinter
	$(RUNNER) install -m644 gitconfig ~/.gitconfig
	$(RUNNER) install -m644 inputrc ~/.inputrc
	$(RUNNER) install -m644 luarc ~/.luarc
	$(RUNNER) install -m644 perlcriticrc ~/.perlcriticrc
	$(RUNNER) mkdir -p ~/.re.pl
	$(RUNNER) install -m644 repl.rc ~/.re.pl/repl.rc
	$(RUNNER) install -m644 tmux.conf ~/.tmux.conf
	$(RUNNER) install -m644 Xdefaults ~/.Xdefaults
	$(RUNNER) mkdir -p ~/.config/pms
	$(RUNNER) install -m644 pmus-rc ~/.config/pms/rc
	$(RUNNER) mkdir -p ~/.git/templates
	$(RUNNER) if [[ -e /usr/share/git-core/templates ]]; then \
	    rsync -ar /usr/share/git-core/templates/ ~/.git/templates/ ; \
	elif [[ -e /usr/local/share/git-core/templates ]]; then \
	    rsync -ar /usr/local/share/git-core/templates/ ~/.git/templates/ ; \
	fi
	$(RUNNER) rsync -ar git-templates/ ~/.git/templates/
	$(RUNNER) cat repos | while read repo install_location ; do \
	    install_location=$${install_location/\~/$$HOME} ; \
	    if [[ -e "$$install_location" ]] ; then \
		( cd $$install_location ; git pull --rebase ) ; \
	    else \
		mkdir -p $$(dirname $$install_location) ; \
		git clone $$repo $$install_location ; \
	    fi ; \
	    if [[ -e "$$install_location/Makefile" ]] ; then \
		$(MAKE) -C $$install_location ; \
	    fi ; \
	done
