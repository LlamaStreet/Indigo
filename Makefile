DEFAULT:
	@mkdir build
	@idris2 src/Main.idr -o inigo --build-dir build