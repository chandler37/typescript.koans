# 'brew install bash' installs into /usr/local/bin/bash; many people use the
# older MacOS-standard /bin/bash:
SHELL := $(shell which bash)

help:
	@echo "See ./README.md for instructions."

.PHONY: clean
clean:
	rm -fr node_modules venv

.PHONY: distclean
distclean: clean
	rm -f package-lock.json

.PHONY: installnodeenv
installnodeenv:
	@echo "brew comes from Homebrew, https://brew.sh"
	brew update
	brew install make python node@16
	pip3 install nodeenv

.PHONY: install
install: | venv/npm_installed.proof

venv/npm_installed.proof: | venv
	source venv/bin/activate && npm install
	touch $@

venv:
	nodeenv --node=16.13.0 venv

.PHONY: test
test: | venv/npm_installed.proof
	source venv/bin/activate && npm test

.PHONY: start
start: | venv/npm_installed.proof
	source venv/bin/activate && npm start
