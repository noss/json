LIBDIR=`erl -eval 'io:format("~s~n", [code:lib_dir()])' -s init stop -noshell`
VERSION=0.2

.PHONY: all test cover clean 

all: 
	@mkdir -p ebin
	cp json.app.in ebin/json.app
	(cd src && erl -make)

test:
	@(cd test && erl -make )
	@erl -noshell -pa test \
      -eval 'init:stop(case eunit:test({dir, "test"},[]) of ok->0;_->1 end)' \
      -s init stop
	
cover: 
	@(cd test && erl -make )
	@erl -noshell \
         -eval 'file:set_cwd(test).' \
         -eval 'cover:compile_beam_directory().' \
         -eval 'json_test:test().' \
         -eval '[cover:analyse_to_file(M, [html]) || M <- cover:modules()].' \
         -s init stop

clean:
	rm -f *.dump
	rm -f ebin/*.beam
	rm -f ebin/*.app

	rm -f test/*.beam
	rm -f test/*.COVER.*
