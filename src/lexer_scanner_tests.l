%option noyywrap
%option yylineno

%{
#include "../lib/tokens.h"
#include "../lib/minunit.h"
#include <iostream>
using namespace std;
int32_t yycolumno = 0;
int32_t yylines = 0;
%}


SPACEFEED	[ ]
LINEFEED	\n
TABFEED		\t
ID			[a-zA-Z_][a-zA-Z0-9_]*
NUMS		[-]?[1-9]*[0-9]+[.][0-9]*[1-9]+
NUMZ		[-]?[1-9]*[0-9]+


%%
"var"		{ std::cout<<"var "; yycolumno += yyleng; return VAR; }
"let"		{ std::cout<<"var "; yycolumno += yyleng; return LET; }
"const"		{ std::cout<<"var "; yycolumno += yyleng; return CONST; }

"if"		{ std::cout<<"id "; yycolumno += yyleng; return KW_IF; }
"else"		{ std::cout<<"id "; yycolumno += yyleng; return KW_ELSE; }
"for"		{ std::cout<<"id "; yycolumno += yyleng; return KW_FOR; }
"while"		{ std::cout<<"id "; yycolumno += yyleng; return KW_WHILE; }
"echo"		{ std::cout<<"id "; yycolumno += yyleng; return KW_ECHO; }
"return"	{ std::cout<<"return "; yycolumno += yyleng; return KW_RETURN; }
"function"	{ std::cout<<"id "; yycolumno += yyleng; return KW_FUNCTION; }
	
[/][*][^.]*[*][/]	{ yycolumno += yyleng; }
[/][/].*[\n]		{ yycolumno = 0; yylines++; }

"+"		{ std::cout<<"add "; 		yycolumno++; return ADD; }
"-"		{ std::cout<<"minus "; 		yycolumno++; return MINUS; }
"*"		{ std::cout<<"mul "; 		yycolumno++; return MUL; }
"/"		{ std::cout<<"div "; 		yycolumno++; return DIV; }
"+="	{ std::cout<<"assign_add ";		yycolumno += yyleng; return ASSIGN_ADD; }
"-="	{ std::cout<<"assign_minus ";	yycolumno += yyleng; return ASSIGN_MINUS; }
"!="	{ std::cout<<"not_equal ";		yycolumno += yyleng; return NOT_EQUAL; }
"=="	{ std::cout<<"equal ";			yycolumno += yyleng; return EQUAL; }

"="		{ std::cout<<"assing "; 	yycolumno++; return ASSIGN; }
">"		{ std::cout<<"more ";		yycolumno++; return MORE; }
"<"		{ std::cout<<"less "; 		yycolumno++; return LESS; }
">="	{ std::cout<<"assign_more ";	yycolumno += yyleng; return ASSIGN_MORE; }
"<="	{ std::cout<<"assign_less ";	yycolumno += yyleng; return ASSIGN_LESS; }

"["		{ std::cout<<"l_bracket "; 	yycolumno++; return L_BRACKET; }
"]"		{ std::cout<<"r_bracket "; 	yycolumno++; return R_BRACKET; }
"("		{ std::cout<<"l_parent "; 	yycolumno++; return L_PARENT; }
")"		{ std::cout<<"r_parent "; 	yycolumno++; return R_PARENT; }
"{"		{ std::cout<<"l_brace "; 	yycolumno++; return L_BRACE; }
"}"		{ std::cout<<"r_brace "; 	yycolumno++; return R_BRACE; }
";"		{ std::cout<<"semi "; 		yycolumno++; return SEMI; }
","		{ std::cout<<"comma "; 		yycolumno++; return COMMA; }


{ID}		{ std::cout<<"id "; 		yycolumno += yyleng; return ID; }
{NUMS}		{ std::cout<<"numeric "; 	yycolumno += yyleng; return NUMERIC; }
{NUMZ}		{ std::cout<<"numeric "; 	yycolumno += yyleng; return NUMERIC; }

[\"].*[\"] 	{ std::cout<<"string "; 	yycolumno += yyleng; return STRING; }
[\'].*[\'] 	{ std::cout<<"string "; 	yycolumno += yyleng; return STRING; }


{SPACEFEED}		{ yycolumno++; }
{TABFEED}		{ yycolumno += yyleng; }
{LINEFEED}		{ yycolumno = 0; yylines++; }
<<EOF>>			{ std::cout<<"eof "; return EOF_FILE; }
.				{ return UNDEFINED; }
%%

int test_w2() {
	yyin = fopen("f.js", "r");
    int rc = yylex();
	cout<<yytext<<endl;
    mu_assert(rc == KW_FUNCTION, "");
	rc = yylex();
	cout<<yytext<<endl;
	mu_assert(rc == L_PARENT, "");
    return 0;
}

int all_tests() {
    mu_run_test(test_w2);
    return 0;
}

RUN_TESTS()

