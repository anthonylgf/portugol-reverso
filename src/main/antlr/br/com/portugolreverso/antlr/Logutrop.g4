grammar Logutrop;

programa
    : fragmento*
    ;

fragmento
    : expressao
    | definicaovariavel
    | command
    ;

// Keywords
SE : 'es';
SENAO : 'oanes';
SENAOSE : 'esoanes';
E : 'e';
OU : 'uo';
NAO : 'oan';
XOU : 'uox';
VERDADEIRO: 'oriedadrev';
FALSO: 'oslaf';
INTEIRO: 'orietni';
REAL: 'laer';
LOGICO: 'ocigol';
TEXTO: 'otxet';
FIM: 'mif';
ENQUANTO: 'otnauqne';

// Operations
SOMA : '+';
SUBTRACAO: '-';
MULTIPLICACAO: '*';
DIVISAO: '/';
MODULO: '%';
POTENCIACAO: '**';
DEFINICAO: '=';
MAIOR: '>';
MENOR: '<';
IGUAL: '==';
MAIORIGUAL: '>=';
MENORIGUAL: '<=';
DIFERENTE: '!==';

// Commands
ESCREVA : 'avercse';
IMPRIMIR : 'rimirpmi';

// Fragments
fragment
ListaPalavraChaves
    : SE
    | SENAO
    | SENAOSE
    | E
    | OU
    | VERDADEIRO
    | FALSO
    | INTEIRO
    | REAL
    | LOGICO
    | TEXTO
    | FIM
    | ENQUANTO
    | ESCREVA
    | IMPRIMIR
    ;

fragment
Digitos
    : [0-9]
    ;

fragment
LetrasUnderscore
    : [a-zA-Z_]
    ;

fragment
StringGenerica
    : '\'' (CaractereDeEscape | ~[{]) *? '\''
    ;

fragment
CaractereDeEscape
    : '\\\''
    | '\\\\' ;

fragment
NumeroRealGenerico
    : (Digitos)+ '.' (Digitos)+
    ;

fragment
NumeroInteiroGenerico
    : (Digitos)+
    ;

fragment
NumeroHexadecimalGenerico
    : ('0x' | '0y') [0-9A-Fa-f]+
    ;

fragment
NumeroBinarioGenerico
    : ('0b' | '0B') [0-1]+
    ;

fragment
ValorBooleanoGenerico
    : VERDADEIRO
    | FALSO
    ;

// Expressions
Atomos
    : StringGenerica
    | NumeroBinarioGenerico
    | NumeroHexadecimalGenerico
    | NumeroInteiroGenerico
    | NumeroRealGenerico
    | ValorBooleanoGenerico
    | NomeDeVariavelOuFuncao
    ;

DefinidoresDeTipos
    : INTEIRO
    | REAL
    | TEXTO
    | LOGICO
    ;

NomeDeVariavelOuFuncao
    : LetrasUnderscore ( Digitos | LetrasUnderscore )*
    ;

OperadoresAritmeticosMultiplicacaoDivisao
    : MODULO
    | MULTIPLICACAO
    | DIVISAO
    ;

OperadoresAritmeticosAdicaoSubtracao
    : SOMA
    | SUBTRACAO
    ;

OperadoresComparacao
    : MAIOR
    | MENOR
    | IGUAL
    | MAIORIGUAL
    | MENORIGUAL
    | DIFERENTE
    ;

OperadoresLogicos
    : NAO
    | E
    | OU
    | XOU
    ;

expressao
    : Atomos                                                                  #atomo
    | ('+' | '-') expressao                                                   #unarymodifier
    | expressao OperadoresAritmeticosMultiplicacaoDivisao expressao           #multidiv
    | expressao OperadoresAritmeticosAdicaoSubtracao expressao                #adicaosubtr
    | expressao OperadoresComparacao expressao                                #comparacao
    | expressao OperadoresLogicos expressao                                   #logicos
    | sebloco                                                                 #condicional
    | enquantobloco                                                           #repeticao
    | '(' expressao ')'                                                       #parenteses
    ;

listaexpressoes
    : fragmento*
    ;

// Variable and function definition
definicaovariavel
    : DefinidoresDeTipos NomeDeVariavelOuFuncao DEFINICAO expressao
    | NomeDeVariavelOuFuncao DEFINICAO expressao
    ;

// Loops and Conditions definition
sebloco
    : SE expressao blocogenerico senaosebloco* senaobloco? FIM
    ;

senaosebloco
    : SENAOSE expressao blocogenerico
    ;

senaobloco
    : SENAO listaexpressoes
    ;

enquantobloco
    : ENQUANTO expressao blocogenerico FIM
    ;

blocogenerico
    : ':' listaexpressoes
    ;

// Generic Commands
command
    : IMPRIMIR expressao        #imprimir
    ;

// Things to skip while processing
EspacosEmBranco
    :   [ \t]+
        -> skip
    ;

QuebraDeLinha
    :   (   '\r' '\n'?
        |   '\n'
        )
        -> skip
    ;

ComentarionEmBloco
    :   '/*' .*? '*/'
        -> skip
    ;

ComentarioEmLinha
    :   '//' ~[\r\n]*
        -> skip
    ;