grammar Parser;

fragmento
    : expressao
    | definicaovariavel
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
MAIOR_IGUAL: '>=';
MENOR_IGUAL: '<=';
DIFERENTE: '!==';

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
    | MAIOR_IGUAL
    | MENOR_IGUAL
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
    | ('+' | '-') expressao                                                   #unary_modifier
    | expressao OperadoresAritmeticosMultiplicacaoDivisao expressao           #multiplicacao_divisao
    | expressao OperadoresAritmeticosAdicaoSubtracao expressao                #adicao_subtracao
    | expressao OperadoresComparacao expressao                                #comparacao
    | expressao OperadoresLogicos expressao                                   #logicos
    | se_bloco                                                                #condicional
    | enquanto_bloco                                                          #repeticao
    | '(' expressao ')'                                                       #parenteses
    ;

lista_expressoes
    : fragmento*
    ;

// Variable and function definition
definicaovariavel
    : DefinidoresDeTipos NomeDeVariavelOuFuncao DEFINICAO expressao
    | NomeDeVariavelOuFuncao DEFINICAO expressao
    ;

// Loops and Conditions definition
se_bloco
    : SE expressao bloco_generico senao_se_bloco* senao_bloco? FIM
    ;

senao_se_bloco
    : SENAOSE expressao bloco_generico
    ;

senao_bloco
    : SENAO lista_expressoes
    ;

enquanto_bloco
    : ENQUANTO expressao bloco_generico FIM
    ;

bloco_generico
    : ':' lista_expressoes
    ;

// Generic

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