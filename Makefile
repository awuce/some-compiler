all:
	make dir
	printf "\n\n\n"
	make lex
	printf "\n\n\n"
	make lex_test
	printf "\n\n\n"
	make clear

lex:
	flex -o build/lexer.yy.c src/lexer_scanner.l
	g++ -c build/lexer.yy.c -o build/lexer.yy.o -g3 -O0
	g++ -o bin/lexer build/lexer.yy.o
	./bin/lexer f.js
	
lex_test:
	flex -o build/lexer_tests.yy.c src/lexer_scanner_tests.l
	g++ -o build/lexer_tests.yy.o -c build/lexer_tests.yy.c -g3 -O0
	g++ -o bin/lexer_tests build/lexer_tests.yy.o
	./bin/lexer_tests ../f.js

dir:
	mkdir build
	mkdir bin

clear:
	rm build/*
	rmdir build
	rm bin/*
	rmdir bin
