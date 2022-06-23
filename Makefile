
test:
	@DYLD_LIBRARY_PATH=./include  ruby test.rb

.PHONY: test