%{
enum
{
	TK_EOF = 0,

	TK_REM,

	TK_PRINT,
	TK_INPUT,
	TK_ON,
	TK_GOTO,
	TK_GOSUB,
	TK_IF,
	TK_THEN,
	TK_DIM,
	TK_RETURN,
	TK_FOR,
	TK_TO,
	TK_STEP,
	TK_NEXT,
	TK_END,
	TK_STOP,
	TK_DEF,
	TK_FN,

	TK_INT,
	TK_LEFT,
	TK_MID,
	TK_RIGHT,
	TK_STR,
	TK_TAB,
	TK_LEN,
	TK_ABS,
	TK_SQR,
	TK_RND,
	TK_OR,
	TK_AND,
	TK_LINE_NUMBER,
	TK_NUMBER_INT,
	TK_NUMBER_FLOAT,
	TK_STRING,
	TK_VARIABLE,
	TK_STRING_VARIABLE,

	TK_OPEN_ROUND_BRACKET,
	TK_CLOSE_ROUND_BRACKET,
	TK_OPEN_SQUARE_BRACKET,
	TK_CLOSE_SQUARE_BRACKET,
	TK_PLUS,
	TK_MINUS,
	TK_MULTIPLY,
	TK_DIVIDE,
	TK_POWER,

	TK_EQUAL,
	TK_LESS_THAN,
	TK_LESS_THAN_OR_EQUAL,
	TK_GREATER_THAN,
	TK_GREATER_THAN_OR_EQUAL,
	TK_NOT_EQUAL,

	TK_COLON,
	TK_SEMICOLON,
	TK_COMMA,
	TK_ENDLINE,

	TK_UNKNOWN,
	TK_NUM_TOKENS
};

char *token_strings[TK_NUM_TOKENS] =
{
	"EOF",

	"REM",

	"PRINT",
	"INPUT",
	"ON",
	"GOTO",
	"GOSUB",
	"IF",
	"THEN",
	"DIM",
	"RETURN",
	"FOR",
	"TO",
	"STEP",
	"NEXT",
	"END",
	"STOP",
	"DEF",
	"FN",

	"INT",
	"LEFT",
	"MID",
	"RIGHT",
	"STR",
	"TAB",
	"LEN",
	"ABS",
	"SQR",
	"RND",
	"OR",
	"AND",
	"LINE_NUMBER",
	"NUMBER_INT",
	"NUMBER_FLOAT",
	"STRING",
	"VARIABLE",
	"STRING_VARIABLE",

	"OPEN_ROUND_BRACKET",
	"CLOSE_ROUND_BRACKET",
	"OPEN_SQUARE_BRACKET",
	"CLOSE_SQUARE_BRACKET",
	"PLUS",
	"MINUS",
	"MULTIPLY",
	"DIVIDE",
	"POWER",

	"EQUAL",
	"LESS_THAN",
	"LESS_THAN_OR_EQUAL",
	"GREATER_THAN",
	"GREATER_THAN_OR_EQUAL",
	"NOT_EQUAL",

	"COLON",
	"SEMICOLON",
	"COMMA",
	"ENDLINE",

	"UNKNOWN",

};

char *token_cpp_equivalents[TK_NUM_TOKENS] =
{
	NULL,     // TK_EOF

	"//",     // TK_REM

	"cout",   // TK_PRINT
	"cin",    // TK_INPUT
	NULL,     // TK_ON
	"goto",   // TK_GOTO
	NULL,     // TK_GOSUB
	"if",     // TK_IF
	"",       // TK_THEN
	"",       // TK_DIM
	"return", // TK_RETURN
	"for",    // TK_FOR
	"",       // TK_TO
	"",       // TK_STEP
	"",       // TK_NEXT
	"exit",   // TK_END
	"exit",   // TK_STOP
	NULL,     // TK_DEF
	NULL,     // TK_FN

	"(int)",   // TK_INT
	"b_LEFT",  // TK_LEFT
	"b_MID",   // TK_MID
	"b_RIGHT", // TK_RIGHT
	"b_STR",   // TK_STR
	"b_TAB",   // TK_TAB
	"b_LEN",   // TK_LEN
	"abs",     // TK_ABS
	"sqrt",    // TK_SQR
	"b_RND",   // TK_RND
	" || ",    // TK_OR
	" && ",    // TK_AND

	NULL, // TK_LINE_NUMBER
	NULL, // TK_NUMBER_INT
	NULL, // TK_NUMBER_FLOAT
	NULL, // TK_STRING
	NULL, // TK_VARIABLE
	NULL, // TK_STRING_VARIABLE

	"(",  // TK_OPEN_ROUND_BRACKET
	")",  // TK_CLOSE_ROUND_BRACKET
	"[",  // TK_OPEN_SQUARE_BRACKET
	"]",  // TK_CLOSE_SQUARE_BRACKET
	"+",  // TK_PLUS
	"-",  // TK_MINUS
	"*",  // TK_MULTIPLY
	"/",  // TK_DIVIDE
	NULL, // TK_POWER

	"=",  // TK_EQUAL
	"<",  // TK_LESS_THAN
	"<=", // TK_LESS_THAN_OR_EQUAL
	">",  // TK_GREATER_THAN
	">=", // TK_GREATER_THAN_OR_EQUAL
	"!=", // TK_NOT_EQUAL

	";",  // TK_COLON
	"",   // TK_SEMICOLON
	",",  // TK_COMMA
	"\n", // TK_ENDLINE

	NULL  // TK_UNKNOWN
};

int value_int;
double value_double;
char *value_string = NULL;
int value_string_max_length = 0;

char *variable_names = NULL;
int variable_names_length = 0;
int variable_names_max_length = 0;

char *string_variable_names = NULL;
int string_variable_names_length = 0;
int string_variable_names_max_length = 0;

void set_value_string(char *string)
{
	int len = strlen(string) + 1;
	if (len > value_string_max_length)
	{
		free(value_string);
		value_string = malloc(len);
		value_string_max_length = len;
	}

	strcpy(value_string, string);
}

void add_variable(char *name)
{
	int i = 0;

	for (i = 0; i < variable_names_length; i++)
	{
		if (variable_names[i] == name[0] && variable_names[i+1] == name[1])
			return;
	}

	if (variable_names_length+2 > variable_names_max_length)
	{
		if (!variable_names_max_length)
		{
			variable_names_max_length = 256;
			variable_names = malloc(256);
		}
		else
		{
			variable_names_max_length *= 2;
			variable_names = realloc(variable_names, variable_names_max_length);
		}
	}

	variable_names[variable_names_length++] = name[0];
	variable_names[variable_names_length++] = name[1];
}

void add_string_variable(char *name)
{
	char n2[2];
	int i = 0;

	n2[0] = name[0];
	n2[1] = name[1] == '$' ? 0 : name[1];

	for (i = 0; i < string_variable_names_length; i++)
	{
		if (string_variable_names[i] == name[0] && string_variable_names[i+1] == n2[1])
			return;
	}

	if (string_variable_names_length+2 > string_variable_names_max_length)
	{
		if (!string_variable_names_max_length)
		{
			string_variable_names_max_length = 256;
			string_variable_names = malloc(256);
		}
		else
		{
			string_variable_names_max_length *= 2;
			string_variable_names = realloc(string_variable_names, string_variable_names_max_length);
		}
	}

	string_variable_names[string_variable_names_length++] = n2[0];
	string_variable_names[string_variable_names_length++] = n2[1];
}


%}

%option noyywrap

WS [ \t\f\r\v]
NUM_INT		[0-9]+
NUM_FLOAT	([0-9]*\.?[0-9]+([eE][\-\+][0-9]+)?)
STRING  \"([^\\\"]|(\\.))*\"
FLOAT_VAR [a-zA-Z][a-z0-9A-Z]?
STRING_VAR {FLOAT_VAR}\$

%%
{WS}+	{ /* ignore */ }

REM.*	return TK_REM;

PRINT	return TK_PRINT;
INPUT	return TK_INPUT;
ON	return TK_ON;
GOTO	return TK_GOTO;
GOSUB	return TK_GOSUB;
IF	return TK_IF;
THEN	return TK_THEN;
DIM	return TK_DIM;
RETURN	return TK_RETURN;
FOR	return TK_FOR;
TO	return TK_TO;
STEP	return TK_STEP;
NEXT	return TK_NEXT;
END	return TK_END;
STOP	return TK_STOP;
DEF	return TK_DEF;
FN[A-Z]	{ set_value_string(yytext); return TK_FN; }

INT	return TK_INT;
LEFT\$	return TK_LEFT;
MID\$	return TK_MID;
RIGHT\$	return TK_RIGHT;
STR\$	return TK_STR;
TAB	return TK_TAB;
LEN	return TK_LEN;
ABS	return TK_ABS;
SQR	return TK_SQR;
RND	return TK_RND;
OR	return TK_OR;
AND	return TK_AND;

^{NUM_INT}	{ value_int = atoi(yytext); return TK_LINE_NUMBER; }

{STRING}	{ set_value_string(yytext); return TK_STRING; }

{STRING_VAR}	{ set_value_string(yytext); add_string_variable(yytext); return TK_STRING_VARIABLE; }

{FLOAT_VAR}	{ set_value_string(yytext); add_variable(yytext); return TK_VARIABLE; }

\(	return TK_OPEN_ROUND_BRACKET;
\)	return TK_CLOSE_ROUND_BRACKET;
\[	return TK_OPEN_SQUARE_BRACKET;
\]	return TK_CLOSE_SQUARE_BRACKET;
\+	return TK_PLUS;
\-	return TK_MINUS;
\*	return TK_MULTIPLY;
\/	return TK_DIVIDE;
\^	return TK_POWER;

"="	return TK_EQUAL;
"<"	return TK_LESS_THAN;
"<="	return TK_LESS_THAN_OR_EQUAL;
">"	return TK_GREATER_THAN;
">="	return TK_GREATER_THAN_OR_EQUAL;
"<>"	return TK_NOT_EQUAL;


\:	return TK_COLON;
\;	return TK_SEMICOLON;
\,	return TK_COMMA;

\n	return TK_ENDLINE;

{NUM_INT}	{ value_int = atoi(yytext); return TK_NUMBER_INT; }
{NUM_FLOAT}	{ value_double = atof(yytext); return TK_NUMBER_FLOAT; }

.	{ set_value_string(yytext); return TK_UNKNOWN; }

%%
int main(int argc, char *argv[])
{
	int token, prev_token = 0;
	int in_if_then = 0;
	int in_fn_call = 0;
	int in_array_brackets = 0;

	int print_line_break = 0;

	int on_count = 0;

	int round_bracket_depth = 0;

	int prev_command = 0;

	char prev_cmd_var[3];

	FILE *fp = fopen("header.txt", "r");
	int c;
	while ((c = fgetc(fp)) != EOF)
		putchar(c);

	//printf("int main(int argc, char *argv[]) {\n");
	while(token = yylex())
	{
#if 0
		printf("%s", token_strings[token]);
		if (token == TK_NUMBER_FLOAT)
			printf(": %f\n", value_double);
		else if (token == TK_LINE_NUMBER || token == TK_NUMBER_INT)
			printf(": %d\n", value_int);
		else if (token == TK_STRING || token == TK_STRING_VARIABLE || token == TK_VARIABLE || token == TK_UNKNOWN)
			printf(": %s\n", yytext);
		else
			printf("\n");
#else
		switch(token)
		{
			case TK_REM:
				printf("//%s", yytext + 3);
				break;

			case TK_PRINT:
				print_line_break = 1;
				printf("cout");
				break;

			case TK_INPUT:
				break;

			case TK_ON:
				break;

			case TK_GOTO:
				if (prev_command == TK_ON)
					on_count = 1;
				else
					printf("goto ");
				break;

			case TK_GOSUB:
				printf("GOSUB_");
				break;

			case TK_IF:
				printf("if (");
				break;

			case TK_THEN:
				printf(") {");
				in_if_then++;
				break;

			case TK_DIM:
				printf("/* FIXME-DIM */ ");
				break;

			case TK_RETURN:
				printf("return");
				break;

			case TK_FOR:
				printf("for (");
				break;

			case TK_TO:
				printf("; %s <= ", prev_cmd_var);
				break;

			case TK_STEP:
				printf("; %s += ", prev_cmd_var);
				break;

			case TK_NEXT:
				printf("; }");
				break;

			case TK_END:
			case TK_STOP:
				printf("exit(0)");
				break;

			case TK_DEF:
				printf("/* FIXME-DEF */ ");
				in_fn_call = 1;
				break;

			case TK_FN:
				printf("b_%s", yytext);
				in_fn_call = 1;
				break;

			case TK_INT:
			case TK_LEFT:
			case TK_MID:
			case TK_RIGHT:
			case TK_STR:
			case TK_TAB:
			case TK_LEN:
			case TK_ABS:
			case TK_SQR:
			case TK_RND:
				if (prev_command == TK_PRINT)
				{
					if (round_bracket_depth == 0 && (prev_token == TK_PRINT || prev_token == TK_SEMICOLON))
						printf(" << ");
					print_line_break = 1;
				}
				printf("%s", token_cpp_equivalents[token]);
				break;

			case TK_OR:
			case TK_AND:
				printf("%s", token_cpp_equivalents[token]);
				break;


			case TK_LINE_NUMBER:
				printf("L_%s: ", yytext);
				break;

			case TK_NUMBER_INT:
			case TK_NUMBER_FLOAT:
				if (prev_command == TK_GOTO)
				{
					if (on_count)
						printf("if (%s == %d) goto L_%s;\n", prev_cmd_var, on_count++, yytext);
					else
						printf("L_%s", yytext);
				}
				else if (prev_token == TK_THEN)
					printf("goto L_%s", yytext);
				else if (prev_token == TK_GOSUB)
					printf("L_%s()", yytext);
				else
				{
					if (prev_command == TK_PRINT)
					{
						if (round_bracket_depth == 0 && (prev_token == TK_PRINT || prev_token == TK_SEMICOLON))
							printf(" << ");
						print_line_break = 1;
					}

					if (token == TK_NUMBER_FLOAT)
						printf("%g", value_double);
					else
						printf("%d", value_int);
				}
				break;

			case TK_STRING:
				if (prev_command == TK_INPUT)
					printf("cout << %s;", yytext);
				else if (prev_command == TK_PRINT)
				{
					if (round_bracket_depth == 0)
						printf(" << ");
					printf("%s", yytext);
					print_line_break = 1;
				}
				else
					printf("%s", yytext);
				break;

			case TK_VARIABLE:
				if (prev_command == TK_INPUT)
					printf("cout << \"? \"; cin >> %s; ", yytext);
				else if (prev_command == TK_PRINT)
				{
					if (round_bracket_depth == 0 && (prev_token == TK_PRINT || prev_token == TK_SEMICOLON))
						printf(" << ");
					printf("%s", yytext);
					print_line_break = 1;
				}
				else if (prev_token == TK_ON)
				{
					prev_cmd_var[0] = yytext[0];
					prev_cmd_var[1] = yytext[1];
					prev_cmd_var[2] = '\0';
				}
				else if (prev_token == TK_FOR)
				{
					prev_cmd_var[0] = yytext[0];
					prev_cmd_var[1] = yytext[1];
					prev_cmd_var[2] = '\0';
					printf("%s", yytext);
				}
				else if (prev_token != TK_NEXT)
					printf("%s", yytext);
				break;

			case TK_STRING_VARIABLE:
				if (prev_command == TK_INPUT)
					printf("cout << \"? \"; cin >> ");
				else if (prev_command == TK_PRINT)
				{
					if (round_bracket_depth == 0 && (prev_token == TK_PRINT || prev_token == TK_SEMICOLON))
						printf(" << ");
					print_line_break = 1;
				}

				{
					char *p = yytext;
					printf("s_");
					while (*p && *p != '$')
						putchar(*p++);
				}

				if (prev_command == TK_INPUT)
					printf("; ");

				break;

			case TK_OPEN_ROUND_BRACKET:
				if (prev_token == TK_VARIABLE)
				{
					in_array_brackets = 1;
					printf("[(int)(");
				}
				else if (prev_command == TK_PRINT)
				{
					if (round_bracket_depth == 0 && (prev_token == TK_PRINT || prev_token == TK_SEMICOLON))
						printf(" << ");
					printf("(");
					print_line_break = 1;
				}
				else
					printf("(");
				round_bracket_depth++;
				break;

			case TK_CLOSE_ROUND_BRACKET:
				if (in_array_brackets)
				{
					in_array_brackets = 0;
					printf(")]");
				}
				else
					printf(")");
				round_bracket_depth--;
				break;

			case TK_OPEN_SQUARE_BRACKET:
			case TK_CLOSE_SQUARE_BRACKET:
			case TK_PLUS:
			case TK_MINUS:
			case TK_MULTIPLY:
			case TK_DIVIDE:
			case TK_LESS_THAN:
			case TK_LESS_THAN_OR_EQUAL:
			case TK_GREATER_THAN:
			case TK_GREATER_THAN_OR_EQUAL:
				printf("%s", token_cpp_equivalents[token]);
				break;

			case TK_POWER:
				printf("/* FIXME-POWER */");
				break;

			case TK_NOT_EQUAL:
				printf("%s", token_cpp_equivalents[token]);
				break;

			case TK_EQUAL:
				if (prev_command == TK_IF)
					printf("==");
				else
					printf("=");
				break;

			case TK_COLON:
				if (prev_command == TK_PRINT)
				{
					if (print_line_break)
						printf(" << endl; ");
					else
						printf(";");
				}
				else if (prev_command == TK_TO)
					printf("; %s++) {", prev_cmd_var);
				else if (prev_command == TK_STEP)
					printf(") {", prev_cmd_var);
				else
					printf("; ");

				on_count = 0;
				break;

			case TK_SEMICOLON:
				if (prev_command == TK_PRINT)
					print_line_break = 0;
				break;

			case TK_COMMA:
				if (in_array_brackets)
				{
					printf(")][(int)(");
				}
				else if (prev_command != TK_INPUT && on_count == 0)
					printf(",");
				break;

			case TK_ENDLINE:
				if (prev_command == TK_PRINT)
				{
					if (print_line_break)
						printf(" << endl");
				}

				if (prev_command == TK_TO)
					printf("; %s++) {", prev_cmd_var);
				else if (prev_command == TK_STEP)
					printf(") {", prev_cmd_var);

				if (!in_if_then && prev_command != TK_REM)
					printf(";");

				while (in_if_then)
				{
					in_if_then--;
					printf("; }");
				}

				printf("\n");

				on_count = 0;

				break;

			case TK_UNKNOWN:
			default:
				printf("/* %s */", yytext);
				break;
		}
		prev_token = token;

		switch(token)
		{
			case TK_REM:
			case TK_PRINT:
			case TK_INPUT:
			case TK_ON:
			case TK_GOTO:
			case TK_GOSUB:
			case TK_IF:
			case TK_THEN:
			case TK_DIM:
			case TK_RETURN:
			case TK_FOR:
			case TK_TO:
			case TK_STEP:
			case TK_NEXT:
			case TK_END:
			case TK_DEF:
				prev_command = token;
				break;

			case TK_COLON:
			case TK_ENDLINE:
				prev_command = TK_EOF;
			
			default:
				break;
		}
#endif
	}
	printf("}\n");

	{
		int i;

		printf("double ");

		for (i = 0; i < variable_names_length; i += 2)
			printf("%s%c%c", i == 0 ? "" : ", ", variable_names[i], variable_names[i+1] ? variable_names[i+1] : ' ');

		printf(";\n");

		printf("string ");

		for (i = 0; i < string_variable_names_length; i += 2)
			printf("%ss_%c%c", i == 0 ? "" : ", ", string_variable_names[i], string_variable_names[i+1] ? string_variable_names[i+1] : ' ');

		printf(";\n");
	}
	return 0;
}