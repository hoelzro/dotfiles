ifeq ($(DRY_RUN),1)
RUNNER=@echo
else
RUNNER=
endif

install:
	@if [[ ${DRY_RUN} -eq 1 ]]; then echo "Dry run; not actually installing things!"; fi
	$(RUNNER) install -m644 dataprinter ~/.dataprinter
	$(RUNNER) install -m644 gitconfig ~/.gitconfig
	$(RUNNER) install -m644 inputrc ~/.inputrc
	$(RUNNER) install -m644 luarc ~/.luarc
	$(RUNNER) install -m644 perlcriticrc ~/.perlcriticrc
	$(RUNNER) mkdir -p ~/.re.pl
	$(RUNNER) install -m644 repl.rc ~/.re.pl/repl.rc
	$(RUNNER) install -m644 tmux.conf ~/.tmux.conf
	$(RUNNER) install -m644 Xdefaults ~/.Xdefaults
