BUSTED_VERSION = 2.1.2-3

install:
	@echo "Installing tests dependencies..."
	luarocks --tree . init
	luarocks --tree ./lua_modules install busted $(BUSTED_VERSION)
	luarocks --tree ./lua_modules install plenary.nvim
	luarocks --tree ./.luarocks config --scope project lua_version 5.1

test:
	@echo "Running tests..."
	@nvim -u NONE \
		-c "lua package.path='lua_modules/share/lua/5.1/?.lua;lua_modules/share/lua/5.1/?/init.lua;'..package.path;package.cpath='lua_modules/lib/lua/5.1/?.so;'..package.cpath;local k,l,_=pcall(require,'luarocks.loader') _=k and l.add_context('busted','$(BUSTED_VERSION)')" \
		-l "lua_modules/lib/luarocks/rocks-5.1/busted/$(BUSTED_VERSION)/bin/busted" "$$@"

.PHONY: install test
