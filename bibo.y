%{
  #include <iostream>
	#include <string> 
   
  using std::string;
	using std::cout;
	using std::cin; 
  
  extern int yylex(void);
  extern int yyparse(void);
  extern void yyerror(const char *);

  extern FILE *reconhecimento; 
  extern FILE *cpp;

  #pragma clang diagnostic ignored "-Wunused-variable"
%}

/* Tipos de tokens */
%token IGUAL          /* == */
%token MAIORIG       /* >= */
%token MENORIG      /* <= */
%token MAIOR       /* >  */
%token MENOR      /* <  */
%token DIFERENTE /* /= */

%token SOMA     /* + */
%token SUB     /* - */
%token MULT   /* * */
%token DIV   /* / */
%token MOD  /* % */
%token AUTOATR

%token AND    /* &&& */
%token OR    /* ||| */
%token NOT  /*  ~  */

%token ATR          /* =  */
%token ENTRADA     /* >< */
%token SAIDA      /* <> */
%token CONCATOUT /* << */
%token CONCATIN /* << */

%token IF    /* ? */
%token ELSE /* ! */

%token WHILE /* _8 */
%token FOR  /* _4 */

%token ABRPARENTESES  /* ( */
%token FECPARENTESES /* ) */
%token PONTO        /* . */
%token SEPARADOR   /* , */
%token INICIO     /* : */
%token FIM       /* ; */

%token ID            /* VARIAVEL    */
%token NUMFLOAT  	  /* tipo FLOAT  */
%token NUMINT      /* tipo INT    */
%token CARACTER   /* tipo CHAR   */
%token STRING  	 /* tipo STRING */
%token NOMEFUNC /* nome funcao */

%token MAIN             /* dielson */
%token TRUE            /* true    */
%token FALSE          /* false   */
%token INT           /* int     */
%token FLOAT        /* FLOAT   */
%token CHAR        /* char    */
%token ENDMAIN    /* edilson */
%token PULALINHA /*   \n    */
%token ENDLINE  /* "bibo"  */
%token RETURN  /* retour  */

%type begin
%type func
%type parametros
%type chamadafunc
%type expparam
%type programa
%type comandos
%type tipo
%type var
%type dec
%type at
%type exp
%type out
%type ent
%type explogic
%type expcond
%type expwhile
%type expfor

%left SOMA SUB
%left MULT DIV
%nonassoc UMINUS

%%

begin: func MAIN programa ENDMAIN
		 | MAIN programa ENDMAIN 
		 ;

func: tipo NOMEFUNC ABRPARENTESES FECPARENTESES INICIO programa FIM PULALINHA
		| tipo NOMEFUNC ABRPARENTESES parametros FECPARENTESES INICIO programa FIM PULALINHA
		| func func

parametros: tipo ID
					| tipo ID SEPARADOR parametros

chamadafunc: NOMEFUNC ABRPARENTESES FECPARENTESES PONTO 
					 | NOMEFUNC ABRPARENTESES expparam FECPARENTESES PONTO

expparam: exp
				| exp SEPARADOR expparam

programa: comandos programa
        | comandos
        ;

comandos: ent 
        | out
        | expcond 
        | expfor
        | expwhile 
        | dec
        | at PONTO 
        | PULALINHA
				| chamadafunc
				| RETURN exp PONTO
        ;

tipo: INT
    | FLOAT
    | CHAR
    ;

var: NUMINT
   | NUMFLOAT
   | CARACTER
   ;

dec: tipo ID PONTO
   | tipo ID ATR ID PONTO
   | tipo ID ATR var PONTO
   ;

at:   ID ATR exp 
		| ID AUTOATR
		;

exp: exp SOMA exp
   | exp SUB exp
   | exp MULT exp
   | exp DIV exp
   | exp MOD exp
   | ABRPARENTESES exp FECPARENTESES
   | SUB exp %prec UMINUS
   | ID 
   | NUMINT
   | NUMFLOAT
   | CARACTER
	 | TRUE
	 | FALSE
   ;

out: SAIDA expout PONTO
   | SAIDA ABRPARENTESES expout FECPARENTESES PONTO
   ;

expout: exp   
			| STRING
			| ENDLINE
			| expout CONCATOUT expout
   		;

ent: ENTRADA expent PONTO ;

expent: ID
      | expent CONCATIN expent
      ;

explogic: ABRPARENTESES explogic FECPARENTESES
      | exp IGUAL exp 
      | exp MAIORIG exp 
      | exp MENORIG exp 
      | exp MAIOR exp 
      | exp MENOR exp 
      | exp DIFERENTE exp
      | exp AND exp
      | exp OR exp
      | NOT exp
			| exp
      ;

expcond: IF ABRPARENTESES explogic FECPARENTESES INICIO programa FIM 
			|  IF ABRPARENTESES explogic FECPARENTESES INICIO programa ELSE INICIO programa FIM
			|  IF ABRPARENTESES explogic FECPARENTESES INICIO programa ELSE IF ABRPARENTESES explogic FECPARENTESES INICIO programa FIM
			;

expwhile: WHILE ABRPARENTESES explogic FECPARENTESES INICIO programa FIM ;

expfor: FOR ABRPARENTESES at PONTO explogic PONTO at FECPARENTESES INICIO programa FIM ;

%%

void yyerror(const char * s) {
	extern int yylineno;    
	extern char * yytext;   
	
  cout << "Erro (" << s << "): símbolo \"" << yytext << "\" (linha " << yylineno << ")\n";
}