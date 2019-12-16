enum Tokens {
	VAR = 0,
	LET,
	CONST,

	KW_IF,
	KW_ELSE,
	KW_FOR,
	KW_WHILE,
	KW_ECHO,
	KW_RETURN,
	KW_FUNCTION,

	ADD,
	MINUS,
	MUL,
	DIV,
	ASSIGN_ADD,
	ASSIGN_MINUS,
	NOT_EQUAL,
	EQUAL,
	ASSIGN,

	MORE,
	LESS,
	ASSIGN_MORE,
	ASSIGN_LESS,

	L_BRACKET,
	R_BRACKET,
	L_PARENT,
	R_PARENT,
	L_BRACE,
	R_BRACE,
	SEMI,
	COMMA,
	
	ID,
	NUMERIC,
	STRING,
	EOF_FILE,
	UNDEFINED
};
