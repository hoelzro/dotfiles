ifeq ($(DRY_RUN),1)
RUNNER=@echo
else
RUNNER=
endif

INSTALL_DIR=$(HOME)
INSTALLER=install -m644
GITHOOKS=applypatch-msg commit-msg post-checkout post-update pre-applypatch pre-commit pre-push pre-push pre-rebase prepare-commit-msg update

install: install_dotfiles install_repos

install_dotfiles:
	@if [[ "${DRY_RUN}" -eq 1 ]]; then echo "Dry run; not actually installing things!"; fi
	$(RUNNER) $(INSTALLER) ackrc $(INSTALL_DIR)/.ackrc
	$(RUNNER) $(INSTALLER) dataprinter $(INSTALL_DIR)/.dataprinter
	$(RUNNER) $(INSTALLER) gitconfig $(INSTALL_DIR)/.gitconfig
	$(RUNNER) $(INSTALLER) gitattributes $(INSTALL_DIR)/.gitattributes
	$(RUNNER) $(INSTALLER) inputrc $(INSTALL_DIR)/.inputrc
	$(RUNNER) $(INSTALLER) luarc $(INSTALL_DIR)/.luarc
	$(RUNNER) $(INSTALLER) perlcriticrc $(INSTALL_DIR)/.perlcriticrc
	$(RUNNER) mkdir -p $(INSTALL_DIR)/.re.pl
	$(RUNNER) $(INSTALLER) repl.rc $(INSTALL_DIR)/.re.pl/repl.rc
	$(RUNNER) perl install-tmux-conf.pl tmux.conf $(INSTALL_DIR)/.tmux.conf
	$(RUNNER) $(INSTALLER) Xdefaults $(INSTALL_DIR)/.Xdefaults
	$(RUNNER) mkdir -p $(INSTALL_DIR)/.config/pms
	$(RUNNER) $(INSTALLER) pmus-rc $(INSTALL_DIR)/.config/pms/rc
	$(RUNNER) mkdir -p $(INSTALL_DIR)/.luarocks
	$(RUNNER) $(INSTALLER) luarocks.lua $(INSTALL_DIR)/.luarocks/config.lua
	$(RUNNER) $(INSTALLER) hgrc $(INSTALL_DIR)/.hgrc
	$(RUNNER) mkdir -p $(INSTALL_DIR)/.git/templates
	$(RUNNER) if [[ -e /usr/share/git-core/templates ]]; then \
	    rsync -ar /usr/share/git-core/templates/ $(INSTALL_DIR)/.git/templates/ ; \
	elif [[ -e /usr/local/share/git-core/templates ]]; then \
	    rsync -ar /usr/local/share/git-core/templates/ $(INSTALL_DIR)/.git/templates/ ; \
	fi
	$(RUNNER) rm -f $(INSTALL_DIR)/.git/templates/hooks/*.sample
	$(RUNNER) install -m755 git-global-hook $(INSTALL_DIR)/.git/hook-runner
	$(RUNNER) for hook in $(GITHOOKS); do \
	    $(RUNNER) ln -sf $(INSTALL_DIR)/.git/hook-runner $(INSTALL_DIR)/.git/templates/hooks/$$hook ; \
	done
	$(RUNNER) rsync -ar git-hooks/ $(INSTALL_DIR)/.git/hooks/
	$(RUNNER) mkdir -p $(INSTALL_DIR)/.urxvt/ext/
	$(RUNNER) $(INSTALLER) custom-url-matcher $(INSTALL_DIR)/.urxvt/ext/

install_repos:
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
	find "$$tmpdir" -name .git -mindepth 2 -print0 | xargs -0 rm -rf ; \
	( cd "$$tmpdir" ; tar czf - . ) > bundle.tar.gz ; \
	rm -rf "$$tmpdir"
