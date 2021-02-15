
define build_dep
	(cd $(1) && idris2 --build Bootstrap.ipkg --build-dir ../build)
endef

DEFAULT:
	@mkdir -p build
	$(call build_dep,Toml)
	@idris2 Indigo/Main.idr -o indigo --build-dir build
	@./build/exec/indigo