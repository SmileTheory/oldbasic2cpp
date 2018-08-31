%{
	int prev_space = 0;
%}


%option noyywrap

%%
REM.*	ECHO;
\"([^\\\"]|(\\.))*\" { prev_space = 0; ECHO; }

PRINT|INPUT|STOP|ON|GOTO|GOSUB|IF|THEN|DIM|RETURN|FOR|TO|NEXT|OR|AND|STEP|END {
		if (!prev_space)
			putchar(' ');

		printf("%s ", yytext);
		prev_space = 1;
	}

[ \t\f\r\v] {
		if (!prev_space)
			putchar(' ');

		prev_space = 1;
	}

.	{ prev_space = 0; ECHO; }
%%
int main(int argc, char *argv[])
{
	int token;
	while(token = yylex())
		;
}