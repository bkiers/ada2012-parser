lexer grammar Ada2012Lexer;

SPACES
 : [ \t\r\n]+ -> skip
 ;

ABORT : A B O R T;
ABS : A B S;
ABSTRACT : A B S T R A C T;
ACCEPT : A C C E P T;
ACCESS : A C C E S S;
ALIASED : A L I A S E D;
ALL : A L L;
AND : A N D;
ARRAY : A R R A Y;
AT : A T;
BEGIN : B E G I N;
BODY : B O D Y;
CASE : C A S E;
CONSTANT : C O N S T A N T;
DECLARE : D E C L A R E;
DELAY : D E L A Y;
DELTA : D E L T A;
DIGITS : D I G I T S;
DO : D O;
ELSE : E L S E;
ELSIF : E L S I F;
END : E N D;
ENTRY : E N T R Y;
EXCEPTION : E X C E P T I O N;
EXIT : E X I T;
FOR : F O R;
FUNCTION : F U N C T I O N;
GENERIC : G E N E R I C;
GOTO : G O T O;
IF : I F;
IN : I N;
INTERFACE : I N T E R F A C E;
IS : I S;
LIMITED : L I M I T E D;
LOOP : L O O P;
MOD : M O D;
NEW : N E W;
NOT : N O T;
NULL : N U L L;
OF : O F;
OR : O R;
OTHERS : O T H E R S;
OUT : O U T;
OVERRIDING : O V E R R I D I N G;
PACKAGE : P A C K A G E;
PRAGMA : P R A G M A;
PRIVATE : P R I V A T E;
PROCEDURE : P R O C E D U R E;
PROTECTED : P R O T E C T E D;
RAISE : R A I S E;
RANGE : R A N G E;
RECORD : R E C O R D;
REM : R E M;
RENAMES : R E N A M E S;
REQUEUE : R E Q U E U E;
RETURN : R E T U R N;
REVERSE : R E V E R S E;
SELECT : S E L E C T;
SEPARATE : S E P A R A T E;
SOME : S O M E;
SUBTYPE : S U B T Y P E;
SYNCHRONIZED : S Y N C H R O N I Z E D;
TAGGED : T A G G E D;
TASK : T A S K;
TERMINATE : T E R M I N A T E;
THEN : T H E N;
TYPE : T Y P E;
UNTIL : U N T I L;
USE : U S E;
WHEN : W H E N;
WHILE : W H I L E;
WITH : W I T H;
XOR : X O R;

SQ : '\'';
OPAR : '(';
CPAR : ')';
COMMA : ',';
SEMI : ';';
COL : ':';
AMP : '&';
MULT : '*';
DIV : '/';
PLUS : '+';
MIN : '-';
DOT : '.';
LT : '<';
GT : '>';
EQ : '=';
PIPE : '|';
ARROW : '=>';
DOT_DOT : '..';
EXP : '**';
ASSIGN : ':=';
N_EQ : '/=';
GT_EQ : '>=';
LT_EQ : '<=';
LEFT_LABEL : '<<';
RIGHT_LABEL : '>>';
BOX : '<>';

/// comment ::= --{non_end_of_line_character}
COMMENT
 : '--' ~[\r\n]* -> channel(HIDDEN)
 ;

/// identifier ::= identifier_start {identifier_start | identifier_extend}
IDENTIFIER
 : IDENTIFIER_START ( IDENTIFIER_START | IDENTIFIER_EXTEND )*
 ;

/// decimal_literal ::= numeral [.numeral] [exponent]
DECIMAL_LITERAL
 : NUMERAL ( '.' NUMERAL )? EXPONENT?
 ;

/// based_literal ::=
///    base # based_numeral [.based_numeral] # [exponent]
BASED_LITERAL
 : BASE '#' BASED_NUMERAL ( '.' BASED_NUMERAL )? '#' EXPONENT?
 ;

/// character_literal ::= 'graphic_character'
CHARACTER_LITERAL
 : '\'' ~[\r\n] '\''
 ;

/// string_literal ::= "{string_element}"
STRING_LITERAL
 : '"' STRING_ELEMENT* '"'
 ;

UNKNOWN
 : .
 ;

/// identifier_start ::=
///      letter_uppercase
///    | letter_lowercase
///    | letter_titlecase
///    | letter_modifier
///    | letter_other
///    | number_letter
fragment IDENTIFIER_START
 : [\p{Lu}\p{Ll}\p{Lt}\p{Lm}\p{Lo}\p{Nl}]
 ;

/// identifier_extend ::=
///      mark_non_spacing
///    | mark_spacing_combining
///    | number_decimal
///    | punctuation_connector
fragment IDENTIFIER_EXTEND
 : [\p{Mn}\p{Mc}\p{Nd}\p{Pc}]
 ;

/// numeral ::= digit {[underline] digit}
///
/// digit ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
fragment NUMERAL
 : [0-9] ( '_'? [0-9] )*
 ;

/// exponent ::= E [+] numeral | E – numeral
fragment EXPONENT
 : [eE] [+-]? NUMERAL
 ;

/// base ::= numeral
fragment BASE
 : NUMERAL
 ;

/// based_numeral ::=
///    extended_digit {[underline] extended_digit}
///
/// extended_digit ::= digit | A | B | C | D | E | F
fragment BASED_NUMERAL
 : [0-9a-fA-F] ( '_'? [0-9a-fA-F] )*
 ;

/// string_element ::= "" | non_quotation_mark_graphic_character
fragment STRING_ELEMENT
 : '""'
 | ~["]
 ;

fragment A: [aA];
fragment B: [bB];
fragment C: [cC];
fragment D: [dD];
fragment E: [eE];
fragment F: [fF];
fragment G: [gG];
fragment H: [hH];
fragment I: [iI];
fragment J: [jJ];
fragment K: [kK];
fragment L: [lL];
fragment M: [mM];
fragment N: [nN];
fragment O: [oO];
fragment P: [pP];
fragment Q: [qQ];
fragment R: [rR];
fragment S: [sS];
fragment T: [tT];
fragment U: [uU];
fragment V: [vV];
fragment W: [wW];
fragment X: [xX];
fragment Y: [yY];
fragment Z: [zZ];
