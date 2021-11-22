parser grammar Ada2012Parser;

options {
  tokenVocab=Ada2012Lexer;
}

/// 10.1.1 Compilation Units - Library Units
///
/// compilation ::= {compilation_unit}
compilation
 : compilation_unit* EOF
 ;

/// compilation_unit ::=
///     context_clause library_item
///   | context_clause subunit
compilation_unit
 : pragma
 | context_clause library_item
 | context_clause subunit
 ;

/// context_clause ::= {context_item}
context_clause
 : context_item*
 ;

/// context_item ::= with_clause | use_clause
context_item
 : with_clause
 | use_clause
 ;

/// subunit ::= separate (parent_unit_name) proper_body
subunit
 : SEPARATE OPAR name CPAR proper_body
 ;

/// library_item ::=
///     [private] library_unit_declaration
///   | library_unit_body
///   | [private] library_unit_renaming_declaration
library_item
 : PRIVATE? library_unit_declaration
 | library_unit_body
 | PRIVATE? library_unit_renaming_declaration
 ;

/// library_unit_renaming_declaration ::=
///    package_renaming_declaration
///  | generic_renaming_declaration
///  | subprogram_renaming_declaration
library_unit_renaming_declaration
 : package_renaming_declaration
 | generic_renaming_declaration
 | subprogram_renaming_declaration
 ;

/// library_unit_declaration ::=
///      subprogram_declaration | package_declaration
///    | generic_declaration | generic_instantiation
library_unit_declaration
 : subprogram_declaration
 | package_declaration
 | generic_declaration
 | generic_instantiation
 ;

/// library_unit_body ::= subprogram_body | package_body
library_unit_body
 : subprogram_body
 | package_body
 ;

/// sequence_of_statements ::= statement {statement} {label}
sequence_of_statements
 : statement+ label*
 ;

/// statement ::=
///    {label} simple_statement | {label} compound_statement
statement
 : label* simple_statement
 | label* compound_statement
 ;

/// label ::= <<label_statement_identifier>>
///
/// statement_identifier ::= direct_name
label
 : LEFT_LABEL direct_name RIGHT_LABEL
 ;

/// simple_statement ::= null_statement
///    | assignment_statement | exit_statement
///    | goto_statement | procedure_call_statement
///    | simple_return_statement | entry_call_statement
///    | requeue_statement | delay_statement
///    | abort_statement | raise_statement
///    | code_statement
simple_statement
 : pragma
 | null_statement
 | assignment_statement
 | exit_statement
 | goto_statement
 | procedure_or_entry_call_statement
 | simple_return_statement
 | requeue_statement
 | delay_statement
 | abort_statement
 | raise_statement
 | code_statement
 ;

/// compound_statement ::=
///      if_statement | case_statement
///    | loop_statement | block_statement
///    | extended_return_statement
///    | accept_statement | select_statement
compound_statement
 : if_statement
 | case_statement
 | loop_statement
 | block_statement
 | extended_return_statement
 | accept_statement
 | select_statement
 ;

/// null_statement ::= null;
null_statement
 : NULL SEMI
 ;

/// assignment_statement ::=
///    variable_name := expression;
assignment_statement
 : name ASSIGN expression SEMI
 ;

/// exit_statement ::=
///    exit [loop_name] [when condition];
exit_statement
 : EXIT name? ( WHEN condition )? SEMI
 ;

/// goto_statement ::= goto label_name;
goto_statement
 : GOTO name SEMI
 ;

/// procedure_call_statement ::=
///     procedure_name;
///   | procedure_prefix actual_parameter_part;
///
/// entry_call_statement ::= entry_name [actual_parameter_part];
procedure_or_entry_call_statement
 : name actual_parameter_part? SEMI
 ;

/// 6.5 Return Statements
///
/// simple_return_statement ::= return [expression];
simple_return_statement
 : RETURN expression? SEMI
 ;

/// requeue_statement ::= requeue procedure_or_entry_name [with abort];
requeue_statement
 : REQUEUE name ( WITH ABORT )? SEMI
 ;

/// delay_statement ::= delay_until_statement | delay_relative_statement
delay_statement
 : delay_until_statement
 | delay_relative_statement
 ;

/// delay_until_statement ::= delay until delay_expression;
delay_until_statement
 : DELAY UNTIL expression SEMI
 ;

/// delay_relative_statement ::= delay delay_expression;
delay_relative_statement
 :  DELAY expression SEMI
 ;

/// abort_statement ::= abort task_name {, task_name};
abort_statement
 : ABORT name ( COMMA name )* SEMI
 ;

/// raise_statement ::= raise;
///       | raise exception_name [with string_expression];
raise_statement
 : RAISE SEMI
 | RAISE name ( WITH expression )? SEMI
 ;

/// code_statement ::= qualified_expression;
code_statement
 : qualified_expression SEMI
 ;

/// if_statement ::=
///     if condition then
///       sequence_of_statements
///    {elsif condition then
///       sequence_of_statements}
///    [else
///       sequence_of_statements]
///     end if;
if_statement
 : IF expression THEN sequence_of_statements?
   ( ELSIF condition THEN sequence_of_statements? )*
   ( ELSE sequence_of_statements? )?
   END IF SEMI
 ;

/// case_statement ::=
///    case selecting_expression is
///        case_statement_alternative
///       {case_statement_alternative}
///    end case;
case_statement
 : CASE expression IS
   case_statement_alternative+
   END CASE SEMI
 ;

/// case_statement_alternative ::=
///    when discrete_choice_list =>
///       sequence_of_statements
case_statement_alternative
 : WHEN discrete_choice_list ARROW sequence_of_statements
 ;

/// loop_statement ::=
///    [loop_statement_identifier:]
///       [iteration_scheme] loop
///          sequence_of_statements
///       end loop [loop_identifier];
loop_statement
 : ( IDENTIFIER COL )?
   iteration_scheme? LOOP
   sequence_of_statements?
   END LOOP IDENTIFIER? SEMI
 ;

/// iteration_scheme ::=
///      while condition
///    | for loop_parameter_specification
///    | for iterator_specification
iteration_scheme
 : WHILE condition
 | FOR loop_parameter_specification
 | FOR iterator_specification
 ;

/// 5.6 Block Statements
///
/// block_statement ::=
///    [block_statement_identifier:]
///        [declare
///             declarative_part]
///         begin
///             handled_sequence_of_statements
///         end [block_identifier];
block_statement
 : ( IDENTIFIER COL )?
   ( DECLARE declarative_part )?
   BEGIN
   handled_sequence_of_statements
   END IDENTIFIER? SEMI
 ;

/// 6.5 Return Statements
///
/// extended_return_statement ::=
///    return extended_return_object_declaration [do
///      handled_sequence_of_statements
///      end return];
extended_return_statement
 : RETURN extended_return_object_declaration ( DO handled_sequence_of_statements END RETURN )? SEMI
 ;

/// extended_return_object_declaration ::=
///     defining_identifier : [aliased] [constant] return_subtype_indication [:= expression]
extended_return_object_declaration
 : IDENTIFIER COL ALIASED? CONSTANT? return_subtype_indication ( ASSIGN expression )?
 ;

/// return_subtype_indication ::= subtype_indication | access_definition
return_subtype_indication
 : subtype_indication
 | access_definition
 ;

/// accept_statement ::=
///    accept entry_direct_name [(entry_index)] parameter_profile [do
///      handled_sequence_of_statements
///      end [entry_identifier]];
///
/// entry_index ::= expression
accept_statement
 : ACCEPT name ( OPAR expression CPAR )? parameter_profile ( DO handled_sequence_of_statements END IDENTIFIER? )? SEMI
 ;

/// 9.7 Select Statements
///
/// select_statement ::=
///     selective_accept
///   | timed_entry_call
///   | conditional_entry_call
///   | asynchronous_select
select_statement
 : selective_accept
 | timed_entry_call
 | conditional_entry_call
 | asynchronous_select
 ;

/// selective_accept ::=
///   select
///     [guard] select_alternative
///     { or [guard] select_alternative }
///     [ else sequence_of_statements ]
///     end select;
selective_accept
 : SELECT
   guard? select_alternative
   ( OR guard? select_alternative )*
   ( ELSE sequence_of_statements? )?
   END SELECT SEMI
 ;

/// timed_entry_call ::=
///   select entry_call_alternative
///   or delay_alternative
///   end select;
timed_entry_call
 : SELECT entry_call_alternative
   OR delay_alternative
   END SELECT SEMI
 ;

/// conditional_entry_call ::=
///   select entry_call_alternative
///   else sequence_of_statements
///   end select;
conditional_entry_call
 : SELECT entry_call_alternative
   ELSE sequence_of_statements?
   END SELECT SEMI
 ;

/// asynchronous_select ::=
///   select triggering_alternative
///   then abort abortable_part
///   end select;
///
/// abortable_part ::= sequence_of_statements
asynchronous_select
 : SELECT triggering_alternative
   THEN ABORT sequence_of_statements?
   END SELECT SEMI
 ;

/// triggering_alternative ::= triggering_statement [sequence_of_statements]
triggering_alternative
 : triggering_statement sequence_of_statements?
 ;

/// triggering_statement ::= procedure_or_entry_call | delay_statement
triggering_statement
 : procedure_or_entry_call
 | delay_statement
 ;

/// select_alternative ::=
///     accept_alternative
///   | delay_alternative
///   | terminate_alternative
select_alternative
 : accept_alternative
 | delay_alternative
 | terminate_alternative
 ;

/// accept_alternative ::=
///   accept_statement [sequence_of_statements]
accept_alternative
 : accept_statement sequence_of_statements?
 ;

/// delay_alternative ::=
///   delay_statement [sequence_of_statements]
delay_alternative
 : delay_statement sequence_of_statements?
 ;

/// terminate_alternative ::= terminate;
terminate_alternative
 : TERMINATE SEMI
 ;

/// entry_call_alternative ::=
///   procedure_or_entry_call [sequence_of_statements]
entry_call_alternative
 : procedure_or_entry_call sequence_of_statements?
 ;

/// procedure_or_entry_call ::=
///   procedure_call_statement | entry_call_statement
///
/// procedure_call_statement ::=
///     procedure_name;
///   | procedure_prefix actual_parameter_part;
///
/// entry_call_statement ::= entry_name [actual_parameter_part];
procedure_or_entry_call
 : name actual_parameter_part? SEMI
 ;

/// handled_sequence_of_statements ::=
///      sequence_of_statements
///   [exception
///      exception_handler
///     {exception_handler}]
handled_sequence_of_statements
 : sequence_of_statements? ( EXCEPTION exception_handler+ )?
 ;

/// exception_handler ::=
///   when [choice_parameter_specification:] exception_choice {| exception_choice} =>
///      sequence_of_statements
///
/// choice_parameter_specification ::= defining_identifier
exception_handler
 : WHEN ( IDENTIFIER COL )? exception_choice ( PIPE exception_choice )* ARROW sequence_of_statements
 ;

/// exception_choice ::= exception_name | others
exception_choice
 : name
 | OTHERS
 ;

/// declarative_part ::= {declarative_item}
declarative_part
 : declarative_item*
 ;

/// declarative_item ::=
///     basic_declarative_item | body
declarative_item
 : pragma
 | basic_declarative_item
 | body
 ;

/// body ::= proper_body | body_stub
body
 : proper_body
 | body_stub
 ;

/// proper_body ::=
///     subprogram_body | package_body | task_body | protected_body
proper_body
 : subprogram_body
 | package_body
 | task_body
 | protected_body
 ;

/// subprogram_body ::=
///     [overriding_indicator]
///     subprogram_specification
///        [aspect_specification] is
///        declarative_part
///     begin
///         handled_sequence_of_statements
///     end [designator];
subprogram_body
 : overriding_indicator? subprogram_specification
   aspect_specification? IS declarative_part
   BEGIN handled_sequence_of_statements
   END designator? SEMI
 ;

/// package_body ::=
///     package body defining_program_unit_name
///     [ aspect_specification ] is
///     declarative_part
///     [begin
///     handled_sequence_of_statements ]
///     end [[ parent_unit_name .] identifier ];
package_body
 : PACKAGE BODY defining_program_unit_name
   aspect_specification? IS declarative_part
   ( BEGIN handled_sequence_of_statements )?
   END ( ( name DOT )? IDENTIFIER )? SEMI
 ;

/// task_body ::=
///     task body defining_identifier
///     [ aspect_specification ] is
///     declarative_part
///     begin
///     handled_sequence_of_statements
///     end [task_ identifier ];
task_body
 : TASK BODY IDENTIFIER
   aspect_specification? IS declarative_part
   BEGIN handled_sequence_of_statements
   END IDENTIFIER? SEMI
 ;

/// protected_body ::=
///     protected body defining_identifier
///     [ aspect_specification ] is
///     { protected_operation_item }
///     end [protected_ identifier ];
protected_body
 : PROTECTED BODY IDENTIFIER
   aspect_specification? IS
   protected_operation_item*
   END IDENTIFIER? SEMI
 ;

/// protected_operation_item ::= subprogram_declaration
///     | subprogram_body
///     | entry_body
///     | aspect_clause
protected_operation_item
 : subprogram_declaration
 | subprogram_body
 | entry_body
 | aspect_clause
 ;

/// entry_body ::=
///     entry defining_identifier entry_body_formal_part entry_barrier is
///     declarative_part
///     begin
///     handled_sequence_of_statements
///     end [entry_ identifier ];
entry_body
 : ENTRY IDENTIFIER entry_body_formal_part entry_barrier IS
   declarative_part
   BEGIN
   handled_sequence_of_statements
   END IDENTIFIER? SEMI
 ;

/// entry_body_formal_part ::= [( entry_index_specification )] parameter_profile
entry_body_formal_part
 : ( OPAR entry_index_specification CPAR )? parameter_profile
 ;

/// entry_index_specification ::= for defining_identifier in discrete_subtype_definition
entry_index_specification
 : FOR IDENTIFIER IN discrete_subtype_definition
 ;

/// entry_barrier ::= when condition
entry_barrier
 : WHEN condition
 ;

/// guard ::= when condition =>
guard
 : WHEN condition ARROW
 ;

/// overriding_indicator ::= [not] overriding
overriding_indicator
 : NOT? OVERRIDING
 ;

/// designator ::= [ parent_unit_name . ] identifier | operator_symbol
designator
 : ( name DOT )? IDENTIFIER
 | operator_symbol
 ;

/// subprogram_specification ::=
///     procedure_specification
///   | function_specification
subprogram_specification
 : procedure_specification
 | function_specification
 ;

/// procedure_specification ::= procedure defining_program_unit_name parameter_profile
procedure_specification
 : PROCEDURE defining_program_unit_name parameter_profile
 ;

/// function_specification ::= function defining_designator parameter_and_result_profile
function_specification
 : FUNCTION defining_designator parameter_and_result_profile
 ;

/// defining_program_unit_name ::= [ parent_unit_name . ] defining_identifier
defining_program_unit_name
 : ( name DOT )? IDENTIFIER
 ;

/// defining_designator ::= defining_program_unit_name | defining_operator_symbol
///
/// defining_operator_symbol ::= operator_symbol
defining_designator
 : defining_program_unit_name
 | operator_symbol
 ;

/// basic_declarative_item ::=
///     basic_declaration | aspect_clause | use_clause
basic_declarative_item
 : basic_declaration
 | aspect_clause
 | use_clause
 ;

/// aspect_clause ::= attribute_definition_clause
///       | enumeration_representation_clause
///       | record_representation_clause
///       | at_clause
aspect_clause
 : attribute_definition_clause
 | enumeration_representation_clause
 | record_representation_clause
 | at_clause
 ;

/// attribute_definition_clause ::=
///       for local_name'attribute_designator use expression;
///     | for local_name'attribute_designator use name;
attribute_definition_clause
 : FOR local_name SQ attribute_designator USE expression SEMI
 | FOR local_name SQ attribute_designator USE name SEMI
 ;

/// enumeration_representation_clause ::=
///       for first_subtype_local_name use enumeration_aggregate ;
///
/// enumeration_aggregate ::= array_aggregate
enumeration_representation_clause
 : FOR local_name USE array_aggregate SEMI
 ;

/// record_representation_clause ::=
///       for first_subtype_ local_name use
///       record [ mod_clause ]
///       { component_clause }
///       end record;
record_representation_clause
 : FOR local_name USE
   RECORD mod_clause?
   component_clause*
   END RECORD SEMI
 ;

/// mod_clause ::= at mod static_ expression ;
mod_clause
 : AT MOD expression SEMI
 ;

/// component_clause ::=
///       component_ local_name at position range first_bit .. last_bit ;
///
/// position ::= static_ expression
///
/// first_bit ::= static_ simple_expression
///
/// last_bit ::= static_ simple_expression
component_clause
 : local_name AT expression RANGE simple_expression DOT_DOT simple_expression SEMI
 ;

/// at_clause ::= for direct_name use at expression ;
at_clause
 : FOR direct_name USE AT expression SEMI
 ;

/// local_name ::= direct_name
///       | direct_name'attribute_designator
///       | library_unit_name
local_name
 : direct_name ( SQ attribute_designator )?
 | name
 ;

/// use_clause ::= use_package_clause | use_type_clause
use_clause
 : use_package_clause
 | use_type_clause
 ;

/// with_clause ::= limited_with_clause | nonlimited_with_clause
with_clause
 : limited_with_clause
 | nonlimited_with_clause
 ;

/// limited_with_clause ::= limited [private] with library_unit_name {, library_unit_name};
limited_with_clause
 : LIMITED PRIVATE? WITH name ( COMMA name )* SEMI
 ;

/// nonlimited_with_clause ::= [private] with library_unit_name {, library_unit_name};
nonlimited_with_clause
 : PRIVATE? WITH name ( COMMA name )* SEMI
 ;

/// use_package_clause ::= use package_ name {, package_ name };
use_package_clause
 : USE name ( COMMA name )* SEMI
 ;

/// use_type_clause ::= use [all] type subtype_mark {, subtype_mark };
use_type_clause
 : USE ALL? TYPE subtype_mark ( COMMA subtype_mark )* SEMI
 ;

/// 10.1.3 Subunits of Compilation Units
///
/// body_stub ::= subprogram_body_stub | package_body_stub | task_body_stub | protected_body_stub
body_stub
 : subprogram_body_stub
 | package_body_stub
 | task_body_stub
 | protected_body_stub
 ;

/// subprogram_body_stub ::=
///    [overriding_indicator]
///    subprogram_specification is separate
///       [aspect_specification];
subprogram_body_stub
 : overriding_indicator? subprogram_specification IS SEPARATE aspect_specification? SEMI
 ;

/// package_body_stub ::=
///    package body defining_identifier is separate
///    [ aspect_specification ];
package_body_stub
 : PACKAGE BODY IDENTIFIER IS SEPARATE aspect_specification? SEMI
 ;

/// task_body_stub ::=
///    task body defining_identifier is separate
///    [ aspect_specification ];
task_body_stub
 : TASK BODY IDENTIFIER IS SEPARATE aspect_specification? SEMI
 ;

/// protected_body_stub ::=
///    protected body defining_identifier is separate
///    [ aspect_specification ];
protected_body_stub
 : PROTECTED BODY IDENTIFIER IS SEPARATE aspect_specification? SEMI
 ;

/// pragma ::=
///    pragma identifier [(pragma_argument_association {, pragma_argument_association})];
///
/// pragma_argument_association ::=
///      [pragma_argument_identifier =>] name
///    | [pragma_argument_identifier =>] expression
///    | pragma_argument_aspect_mark =>  name
///    | pragma_argument_aspect_mark =>  expression
pragma
 : PRAGMA IDENTIFIER ( OPAR pragma_argument_association ( COMMA pragma_argument_association )* CPAR )? SEMI
 ;

pragma_argument_association
 : ( IDENTIFIER ARROW )? name
 | ( IDENTIFIER ARROW )? expression
 | aspect_mark ARROW name
 | aspect_mark ARROW expression
 ;

/// aspect_mark ::= aspect_identifier['Class]
aspect_mark
  : IDENTIFIER ( SQ IDENTIFIER )?
  ;

/// 3.1 Declarations
///
/// basic_declaration ::=
///      type_declaration | subtype_declaration
///    | object_declaration | number_declaration
///    | subprogram_declaration | abstract_subprogram_declaration
///    | null_procedure_declaration | expression_function_declaration
///    | package_declaration | renaming_declaration
///    | exception_declaration | generic_declaration
///    | generic_instantiation
///
/// defining_identifier ::= identifier
basic_declaration
 : type_declaration
 | subtype_declaration
 | object_declaration
 | number_declaration
 | subprogram_declaration
 | abstract_subprogram_declaration
 | null_procedure_declaration
 | expression_function_declaration
 | package_declaration
 | renaming_declaration
 | exception_declaration
 | generic_declaration
 | generic_instantiation
 ;

/// 3.2.1 Type Declarations
///
/// type_declaration ::=  full_type_declaration
///    | incomplete_type_declaration
///    | private_type_declaration
///    | private_extension_declaration
type_declaration
 : full_type_declaration
 | incomplete_type_declaration
 | private_type_declaration
 | private_extension_declaration
 ;

/// 3.2.2 Subtype Declarations
///
/// subtype_declaration ::=
///    subtype defining_identifier is subtype_indication
///    [ aspect_specification ];
subtype_declaration
 : SUBTYPE IDENTIFIER IS subtype_indication aspect_specification? SEMI
 ;

/// 3.3.1 Object Declarations
///
/// object_declaration ::=
///      defining_identifier_list : [aliased] [constant] subtype_indication [:= expression ] [ aspect_specification ];
///    | defining_identifier_list : [aliased] [constant] access_definition [:= expression ] [ aspect_specification ];
///    | defining_identifier_list : [aliased] [constant] array_type_definition [:= expression ] [ aspect_specification ];
///    | single_task_declaration
///    | single_protected_declaration
object_declaration
 : defining_identifier_list COL ALIASED? CONSTANT? subtype_indication ( ASSIGN expression )? aspect_specification? SEMI
 | defining_identifier_list COL ALIASED? CONSTANT? access_definition ( ASSIGN expression )? aspect_specification? SEMI
 | defining_identifier_list COL ALIASED? CONSTANT? array_type_definition ( ASSIGN expression )? aspect_specification? SEMI
 | single_task_declaration
 | single_protected_declaration
 ;

/// unconstrained_array_definition ::=
///    array ( index_subtype_definition {, index_subtype_definition }) of component_definition
unconstrained_array_definition
 : ARRAY OPAR index_subtype_definition ( COMMA index_subtype_definition )* CPAR OF component_definition
 ;

/// constrained_array_definition ::=
///    array ( discrete_subtype_definition {, discrete_subtype_definition }) of component_definition
constrained_array_definition
 : ARRAY OPAR discrete_subtype_definition ( COMMA discrete_subtype_definition )* CPAR OF component_definition
 ;

/// single_task_declaration ::=
///    task defining_identifier
///    [ aspect_specification ] [ is [new interface_list with] task_definition ];
single_task_declaration
 : TASK IDENTIFIER aspect_specification? ( IS ( NEW interface_list WITH )? task_definition )? SEMI
 ;

/// single_protected_declaration ::=
///    protected defining_identifier
///    [ aspect_specification ] is
///    [new interface_list with]
///    protected_definition ;
single_protected_declaration
 : PROTECTED IDENTIFIER
   aspect_specification? IS
   ( NEW interface_list WITH )?
   protected_definition SEMI
 ;

/// protected_definition ::=
///    { protected_operation_declaration }
///    [ private { protected_element_declaration } ]
///    end [protected_ identifier ]
protected_definition
 : protected_operation_declaration*
   ( PRIVATE protected_element_declaration* )?
   END IDENTIFIER?
 ;

/// protected_operation_declaration ::=
///      subprogram_declaration
///    | entry_declaration
///    | aspect_clause
protected_operation_declaration
 : subprogram_declaration
 | entry_declaration
 | aspect_clause
 ;

/// protected_element_declaration ::=
///      protected_operation_declaration
///    | component_declaration
protected_element_declaration
 : protected_operation_declaration
 | component_declaration
 ;

/// component_declaration ::=
///    defining_identifier_list : component_definition [:= default_expression ]
///    [ aspect_specification ];
component_declaration
 : defining_identifier_list COL component_definition ( ASSIGN expression )? aspect_specification? SEMI
 ;

/// interface_list ::= interface_ subtype_mark {and interface_ subtype_mark }
interface_list
 : subtype_mark ( AND subtype_mark )*
 ;

/// task_definition ::=
///    { task_item }
///    [ private { task_item }]
///    end [ task_ identifier ]
task_definition
 : task_item* ( PRIVATE task_item* )? END IDENTIFIER?
 ;

/// task_item ::= entry_declaration | aspect_clause
task_item
 : entry_declaration
 | aspect_clause
 ;

/// entry_declaration ::=
///    [ overriding_indicator ]
///    entry defining_identifier [( discrete_subtype_definition )] parameter_profile
///    [ aspect_specification ];
entry_declaration
 : overriding_indicator?
   ENTRY IDENTIFIER ( OPAR discrete_subtype_definition CPAR )? parameter_profile
   aspect_specification? SEMI
 ;

/// component_definition ::=
///      [aliased] subtype_indication
///    | [aliased] access_definition
component_definition
 : ALIASED? subtype_indication
 | ALIASED? access_definition
 ;

/// index_subtype_definition ::= subtype_mark range <>
index_subtype_definition
 : subtype_mark RANGE BOX
 ;

/// 3.3.2 Number Declarations
///
/// number_declaration ::=
///      defining_identifier_list : constant := static_expression;
number_declaration
 : defining_identifier_list COL CONSTANT ASSIGN expression SEMI
 ;

/// 6.1 Subprogram Declarations
///
/// subprogram_declaration ::=
///     [overriding_indicator]
///     subprogram_specification
///         [aspect_specification];
subprogram_declaration
 : overriding_indicator? subprogram_specification aspect_specification? SEMI
 ;

/// 3.9.3 Abstract Types and Subprograms
///
/// abstract_subprogram_declaration ::=
///    [overriding_indicator]
///    subprogram_specification is abstract
///        [aspect_specification];
abstract_subprogram_declaration
 : overriding_indicator? subprogram_specification IS ABSTRACT aspect_specification? SEMI
 ;

/// 6.7 Null Procedures
///
/// null_procedure_declaration ::=
///    [overriding_indicator]
///    procedure_specification is null
///        [aspect_specification];
null_procedure_declaration
 : overriding_indicator? procedure_specification IS NULL aspect_specification? SEMI
 ;

/// 6.8 Expression Functions
///
/// expression_function_declaration ::=
///    [overriding_indicator]
///    function_specification is
///        (expression)
///        [aspect_specification];
expression_function_declaration
 : overriding_indicator? function_specification IS OPAR expression CPAR aspect_specification? SEMI
 ;

/// 7.1 Package Specifications and Declarations
///
/// package_declaration ::= package_specification;
package_declaration
 : package_specification SEMI
 ;

/// package_specification ::=
///     package defining_program_unit_name [aspect_specification] is {basic_declarative_item}
///     [private {basic_declarative_item}]
///     end [[parent_unit_name.]identifier]
package_specification
 : PACKAGE name aspect_specification? IS basic_declarative_item*
   ( PRIVATE basic_declarative_item* )?
   END ( ( name DOT )? IDENTIFIER )?
 ;

/// 8.5 Renaming Declarations
///
/// renaming_declaration ::=
///       object_renaming_declaration
///     | exception_renaming_declaration
///     | package_renaming_declaration
///     | subprogram_renaming_declaration
///     | generic_renaming_declaration
renaming_declaration
 : object_renaming_declaration
 | exception_renaming_declaration
 | package_renaming_declaration
 | subprogram_renaming_declaration
 | generic_renaming_declaration
 ;

/// 8.5.1 Object Renaming Declarations
///
/// object_renaming_declaration ::=
///     defining_identifier : [null_exclusion] subtype_mark renames object_name [aspect_specification];
///   | defining_identifier : access_definition renames object_name [aspect_specification];
object_renaming_declaration
 : IDENTIFIER COL null_exclusion? subtype_mark RENAMES name aspect_specification? SEMI
 | IDENTIFIER COL access_definition RENAMES name aspect_specification? SEMI
 ;

/// 8.5.2 Exception Renaming Declarations
///
/// exception_renaming_declaration ::= defining_identifier : exception renames exception_name [aspect_specification];
exception_renaming_declaration
 : IDENTIFIER COL EXCEPTION RENAMES name aspect_specification? SEMI
 ;

/// 8.5.3 Package Renaming Declarations
///
/// package_renaming_declaration ::= package defining_program_unit_name renames package_name [aspect_specification];
package_renaming_declaration
 : PACKAGE name RENAMES name aspect_specification? SEMI
 ;

/// 8.5.4 Subprogram Renaming Declarations
///
/// subprogram_renaming_declaration ::=
///     [overriding_indicator]
///     subprogram_specification renames callable_entity_name
///         [aspect_specification];
subprogram_renaming_declaration
 : overriding_indicator? subprogram_specification RENAMES name aspect_specification? SEMI
 ;

/// 8.5.5 Generic Renaming Declarations
///
/// generic_renaming_declaration ::=
///     generic package defining_program_unit_name renames generic_package_name [aspect_specification];
///   | generic procedure defining_program_unit_name renames generic_procedure_name [aspect_specification];
///   | generic function defining_program_unit_name renames generic_function_name [aspect_specification];
generic_renaming_declaration
 : GENERIC PACKAGE name RENAMES name aspect_specification? SEMI
 | GENERIC PROCEDURE name RENAMES name aspect_specification? SEMI
 | GENERIC FUNCTION name RENAMES name aspect_specification? SEMI
 ;

/// 11.1 Exception Declarations
///
/// exception_declaration ::= defining_identifier_list : exception [aspect_specification];
exception_declaration
 : defining_identifier_list COL EXCEPTION aspect_specification? SEMI
 ;

/// 12.1 Generic Declarations
///
/// generic_declaration ::= generic_subprogram_declaration | generic_package_declaration
generic_declaration
 : generic_subprogram_declaration
 | generic_package_declaration
 ;

/// generic_subprogram_declaration ::=
///      generic_formal_part  subprogram_specification [aspect_specification];
generic_subprogram_declaration
 : generic_formal_part subprogram_specification aspect_specification? SEMI
 ;

/// generic_package_declaration ::=
///      generic_formal_part  package_specification;
generic_package_declaration
 : generic_formal_part package_specification SEMI
 ;

/// generic_formal_part ::= generic {generic_formal_parameter_declaration | use_clause}
generic_formal_part
 : GENERIC ( generic_formal_parameter_declaration | use_clause )*
 ;

/// generic_formal_parameter_declaration ::=
///       formal_object_declaration
///     | formal_type_declaration
///     | formal_subprogram_declaration
///     | formal_package_declaration
generic_formal_parameter_declaration
 : formal_object_declaration
 | formal_type_declaration
 | formal_subprogram_declaration
 | formal_package_declaration
 ;

/// 12.4 Formal Objects
///
/// formal_object_declaration ::=
///     defining_identifier_list : mode [null_exclusion] subtype_mark [:= default_expression] [aspect_specification];
///   | defining_identifier_list : mode access_definition [:= default_expression] [aspect_specification];
formal_object_declaration
 : defining_identifier_list COL mode_ null_exclusion? subtype_mark ( ASSIGN expression )? aspect_specification? SEMI
 | defining_identifier_list COL mode_ access_definition ( ASSIGN expression )? aspect_specification? SEMI
 ;

/// 12.5 Formal Types
///
/// formal_type_declaration ::=
///       formal_complete_type_declaration
///     | formal_incomplete_type_declaration
formal_type_declaration
 : formal_complete_type_declaration
 | formal_incomplete_type_declaration
 ;

/// formal_subprogram_declaration ::=
///       formal_concrete_subprogram_declaration
///     | formal_abstract_subprogram_declaration
formal_subprogram_declaration
 : formal_concrete_subprogram_declaration
 | formal_abstract_subprogram_declaration
 ;

/// 12.7 Formal Packages
///
/// formal_package_declaration ::=
///     with package defining_identifier is new generic_package_name formal_package_actual_part [aspect_specification];
formal_package_declaration
 : WITH PACKAGE IDENTIFIER IS NEW name formal_package_actual_part aspect_specification? SEMI
 ;

/// formal_package_actual_part ::=
///     ([others =>] <>)
///   | [generic_actual_part]
///   | (formal_package_association {, formal_package_association} [, others => <>])
formal_package_actual_part
 : OPAR ( OTHERS ARROW )? BOX CPAR
 | OPAR formal_package_association ( COMMA formal_package_association )* ( COMMA OTHERS ARROW BOX )? CPAR
 | generic_actual_part
 ;

/// formal_package_association ::=
///     generic_association
///   | generic_formal_parameter_selector_name => <>
formal_package_association
 : generic_association
 | selector_name ARROW BOX
 ;

/// generic_association ::=
///    [generic_formal_parameter_selector_name =>] explicit_generic_actual_parameter
generic_association
 : ( selector_name ARROW )? explicit_generic_actual_parameter
 ;

/// explicit_generic_actual_parameter ::=
///      expression | variable_name
///    | subprogram_name | entry_name | subtype_mark
///    | package_instance_name
explicit_generic_actual_parameter
 : expression
 | name
 | subtype_mark
 ;

/// generic_actual_part ::=
///    (generic_association {, generic_association})
generic_actual_part
 : OPAR generic_association ( COMMA generic_association )*  CPAR
 ;

/// formal_concrete_subprogram_declaration ::=
///      with subprogram_specification [is subprogram_default] [aspect_specification];
formal_concrete_subprogram_declaration
 : WITH subprogram_specification ( IS subprogram_default )? aspect_specification? SEMI
 ;

/// formal_abstract_subprogram_declaration ::=
///      with subprogram_specification is abstract [subprogram_default] [aspect_specification];
formal_abstract_subprogram_declaration
 : WITH subprogram_specification IS ABSTRACT subprogram_default? aspect_specification? SEMI
 ;

/// subprogram_default ::= default_name | <> | null
subprogram_default
 : name
 | BOX
 | NULL
 ;

/// formal_complete_type_declaration ::=
///     type defining_identifier [discriminant_part] is formal_type_definition [aspect_specification];
formal_complete_type_declaration
 : TYPE IDENTIFIER discriminant_part? IS formal_type_definition aspect_specification? SEMI
 ;

/// formal_incomplete_type_declaration ::=
///     type defining_identifier [discriminant_part] [is tagged];
formal_incomplete_type_declaration
 : TYPE IDENTIFIER discriminant_part? ( IS TAGGED )? SEMI
 ;

/// formal_type_definition ::=
///       formal_private_type_definition
///     | formal_derived_type_definition
///     | formal_discrete_type_definition
///     | formal_signed_integer_type_definition
///     | formal_modular_type_definition
///     | formal_floating_point_definition
///     | formal_ordinary_fixed_point_definition
///     | formal_decimal_fixed_point_definition
///     | formal_array_type_definition
///     | formal_access_type_definition
///     | formal_interface_type_definition
///
/// formal_array_type_definition ::= array_type_definition
///
/// formal_access_type_definition ::= access_type_definition
///
/// formal_interface_type_definition ::= interface_type_definition
formal_type_definition
 : formal_private_type_definition
 | formal_derived_type_definition
 | formal_discrete_type_definition
 | formal_signed_integer_type_definition
 | formal_modular_type_definition
 | formal_floating_point_definition
 | formal_ordinary_fixed_point_definition
 | formal_decimal_fixed_point_definition
 | array_type_definition
 | access_type_definition
 | interface_type_definition
 ;

/// formal_private_type_definition ::= [[abstract] tagged] [limited] private
formal_private_type_definition
 : ( ABSTRACT? TAGGED )? LIMITED? PRIVATE
 ;

/// formal_derived_type_definition ::=
///      [abstract] [limited | synchronized] new subtype_mark [[and interface_list] with private]
formal_derived_type_definition
 : ABSTRACT? ( LIMITED | SYNCHRONIZED )? NEW subtype_mark ( ( AND interface_list )? WITH PRIVATE )?
 ;

/// formal_discrete_type_definition ::= (<>)
formal_discrete_type_definition
 : OPAR BOX CPAR
 ;

/// formal_signed_integer_type_definition ::= range <>
formal_signed_integer_type_definition
 : RANGE BOX
 ;

/// formal_modular_type_definition ::= mod <>
formal_modular_type_definition
 : MOD BOX
 ;

/// formal_floating_point_definition ::= digits <>
formal_floating_point_definition
 : DIGITS BOX
 ;

/// formal_ordinary_fixed_point_definition ::= delta <>
formal_ordinary_fixed_point_definition
 : DELTA BOX
 ;

/// formal_decimal_fixed_point_definition ::= delta <> digits <>
formal_decimal_fixed_point_definition
 : DELTA BOX DIGITS BOX
 ;

/// 12.3 Generic Instantiation
///
/// generic_instantiation ::=
///      package defining_program_unit_name is new generic_package_name [generic_actual_part] [aspect_specification];
///    | [overriding_indicator] procedure defining_program_unit_name is new generic_procedure_name [generic_actual_part] [aspect_specification];
///    | [overriding_indicator] function defining_designator is new generic_function_name [generic_actual_part] [aspect_specification];
generic_instantiation
 : PACKAGE name IS ( NEW name generic_actual_part? aspect_specification? | NULL ) SEMI
 | overriding_indicator? PROCEDURE name IS ( NEW name generic_actual_part? aspect_specification? | NULL ) SEMI
 | overriding_indicator? FUNCTION name IS ( NEW name generic_actual_part? aspect_specification? | NULL ) SEMI
 ;

/// full_type_declaration ::=
///      type defining_identifier [known_discriminant_part] is type_definition [aspect_specification];
///    | task_type_declaration
///    | protected_type_declaration
full_type_declaration
 : TYPE IDENTIFIER known_discriminant_part? IS type_definition aspect_specification? SEMI
 | task_type_declaration
 | protected_type_declaration
 ;

/// 3.10.1 Incomplete Type Declarations
///
/// incomplete_type_declaration ::= type defining_identifier [discriminant_part] [is tagged];
incomplete_type_declaration
 : TYPE IDENTIFIER discriminant_part? ( IS TAGGED )? SEMI
 ;

/// 7.3 Private Types and Private Extensions
///
/// private_type_declaration ::=
///    type defining_identifier [discriminant_part] is [[abstract] tagged] [limited] private [aspect_specification];
private_type_declaration
 : TYPE IDENTIFIER discriminant_part? IS ( ABSTRACT? TAGGED )? LIMITED? PRIVATE aspect_specification? SEMI
 ;

/// 7.3 Private Types and Private Extensions
///
/// private_extension_declaration ::=
///    type defining_identifier [discriminant_part] is
///      [abstract] [limited | synchronized] new ancestor_subtype_indication
///      [and interface_list] with private [aspect_specification];
private_extension_declaration
 : TYPE IDENTIFIER discriminant_part? IS
   ABSTRACT? ( LIMITED | SYNCHRONIZED )? NEW subtype_indication
   ( AND interface_list )? WITH PRIVATE aspect_specification? SEMI
 ;

/// 13.1.1 Aspect Specifications
///
/// aspect_specification ::=
///    with aspect_mark [=> aspect_definition] {, aspect_mark [=> aspect_definition] }
aspect_specification
 : WITH aspect_mark ( ARROW aspect_definition )? ( COMMA aspect_mark ( ARROW aspect_definition )? )*
 ;

/// aspect_definition ::= name | expression | identifier
aspect_definition
 : name
 | expression
 | IDENTIFIER
 ;

/// 9.1 Task Units and Task Objects
///
/// task_type_declaration ::=
///    task type defining_identifier [known_discriminant_part] [aspect_specification]
///    [is [new interface_list with] task_definition];
task_type_declaration
 : TASK TYPE IDENTIFIER known_discriminant_part? aspect_specification?
   ( IS ( NEW interface_list WITH )? task_definition )? SEMI
 ;

/// 9.4 Protected Units and Protected Objects
///
/// protected_type_declaration ::=
///   protected type defining_identifier [known_discriminant_part] [aspect_specification]
///   is [new interface_list with] protected_definition;
protected_type_declaration
 : PROTECTED TYPE IDENTIFIER known_discriminant_part? aspect_specification?
   IS ( NEW interface_list WITH )? protected_definition SEMI
 ;

/// type_definition ::=
///      enumeration_type_definition | integer_type_definition
///    | real_type_definition | array_type_definition
///    | record_type_definition | access_type_definition
///    | derived_type_definition | interface_type_definition
type_definition
 : enumeration_type_definition
 | integer_type_definition
 | real_type_definition
 | array_type_definition
 | record_type_definition
 | access_type_definition
 | derived_type_definition
 | interface_type_definition
 ;

/// 3.5.1 Enumeration Types
///
/// enumeration_type_definition ::=
///    (enumeration_literal_specification {, enumeration_literal_specification})
enumeration_type_definition
 : OPAR enumeration_literal_specification ( COMMA enumeration_literal_specification )* CPAR
 ;

/// enumeration_literal_specification ::=  defining_identifier | defining_character_literal
enumeration_literal_specification
 : IDENTIFIER
 | CHARACTER_LITERAL
 ;

/// 3.5.4 Integer Types
///
/// integer_type_definition ::= signed_integer_type_definition | modular_type_definition
integer_type_definition
 : signed_integer_type_definition
 | modular_type_definition
 ;

/// signed_integer_type_definition ::= range static_simple_expression .. static_simple_expression
signed_integer_type_definition
 : RANGE simple_expression DOT_DOT simple_expression
 ;

/// modular_type_definition ::= mod static_expression
modular_type_definition
 : MOD simple_expression
 ;

/// 3.5.6 Real Types
///
/// real_type_definition ::=
///    floating_point_definition | fixed_point_definition
real_type_definition
 : floating_point_definition
 | fixed_point_definition
 ;

/// 3.5.7 Floating Point Types
///
/// floating_point_definition ::=
///   digits static_expression [real_range_specification]
floating_point_definition
 : DIGITS expression real_range_specification?
 ;

/// real_range_specification ::=
///   range static_simple_expression .. static_simple_expression
real_range_specification
 : RANGE simple_expression DOT_DOT simple_expression
 ;

/// fixed_point_definition ::= ordinary_fixed_point_definition | decimal_fixed_point_definition
fixed_point_definition
 : ordinary_fixed_point_definition
 | decimal_fixed_point_definition
 ;

/// ordinary_fixed_point_definition ::=
///    delta static_expression  real_range_specification
ordinary_fixed_point_definition
 : DELTA expression real_range_specification
 ;

/// decimal_fixed_point_definition ::=
///    delta static_expression digits static_expression [real_range_specification]
decimal_fixed_point_definition
 : DELTA expression DIGITS expression real_range_specification?
 ;

/// digits_constraint ::=
///    digits static_expression [range_constraint]
digits_constraint
 : DIGITS expression range_constraint?
 ;

/// 3.6 Array Types
///
/// array_type_definition ::=
///    unconstrained_array_definition | constrained_array_definition
array_type_definition
 : unconstrained_array_definition
 | constrained_array_definition
 ;

/// 3.8 Record Types
///
/// record_type_definition ::= [[abstract] tagged] [limited] record_definition
record_type_definition
 : ( ABSTRACT? TAGGED )? LIMITED? record_definition
 ;

/// record_definition ::=
///     record
///        component_list
///     end record
///   | null record
record_definition
 : RECORD component_list END RECORD
 | NULL RECORD
 ;

/// component_list ::=
///       component_item {component_item}
///    | {component_item} variant_part
///    |  null;
component_list
 : component_item+
 | component_item* variant_part
 | NULL SEMI
 ;

/// 3.8.1 Variant Parts and Discrete Choices
///
/// variant_part ::=
///    case discriminant_direct_name is
///        variant
///       {variant}
///    end case;
variant_part
 : CASE direct_name IS variant+ END CASE SEMI
 ;

/// variant ::=
///    when discrete_choice_list =>
///       component_list
variant
 : WHEN discrete_choice_list ARROW component_list
 ;

/// component_item ::= component_declaration | aspect_clause
component_item
 : component_declaration
 | aspect_clause
 ;

/// 3.10 Access Types
///
/// access_type_definition ::=
///     [null_exclusion] access_to_object_definition
///   | [null_exclusion] access_to_subprogram_definition
access_type_definition
 : null_exclusion? access_to_object_definition
 | null_exclusion? access_to_subprogram_definition
 ;

/// access_to_object_definition ::=
///     access [general_access_modifier] subtype_indication
access_to_object_definition
 : ACCESS general_access_modifier? subtype_indication
 ;

/// general_access_modifier ::= all | constant
general_access_modifier
 : ALL
 | CONSTANT
 ;

/// access_to_subprogram_definition ::=
///     access [protected] procedure parameter_profile
///   | access [protected] function  parameter_and_result_profile
access_to_subprogram_definition
 : ACCESS PROTECTED? PROCEDURE parameter_profile
 | ACCESS PROTECTED? FUNCTION parameter_and_result_profile
 ;

/// 3.4 Derived Types and Classes
///
/// derived_type_definition ::=
///     [abstract] [limited] new parent_subtype_indication [[and interface_list] record_extension_part]
derived_type_definition
 : ABSTRACT? LIMITED? NEW subtype_indication ( ( AND interface_list )? record_extension_part )?
 ;

/// 3.9.1 Type Extensions
///
/// record_extension_part ::= with record_definition
record_extension_part
 : WITH record_definition
 ;

/// 3.9.4 Interface Types
///
/// interface_type_definition ::=
///     [limited | task | protected | synchronized] interface [and interface_list]
interface_type_definition
 : ( LIMITED | TASK | PROTECTED | SYNCHRONIZED )? INTERFACE ( AND interface_list )?
 ;

/// discrete_subtype_definition ::= discrete_subtype_indication | range
discrete_subtype_definition
 : subtype_indication
 | range
 ;

/// discriminant_part ::= unknown_discriminant_part | known_discriminant_part
discriminant_part
 : unknown_discriminant_part
 | known_discriminant_part
 ;

/// unknown_discriminant_part ::= (<>)
unknown_discriminant_part
 : OPAR BOX CPAR
 ;

/// known_discriminant_part ::=
///    (discriminant_specification {; discriminant_specification})
known_discriminant_part
 : OPAR discriminant_specification ( SEMI discriminant_specification )* CPAR
 ;

/// discriminant_specification ::=
///    defining_identifier_list : [null_exclusion] subtype_mark [:= default_expression]
///  | defining_identifier_list : access_definition [:= default_expression]
discriminant_specification
 : defining_identifier_list COL null_exclusion? subtype_mark ( ASSIGN default_expression )?
 | defining_identifier_list COL access_definition ( ASSIGN default_expression )?
 ;

/// access_definition ::=
///     [null_exclusion] access [constant] subtype_mark
///   | [null_exclusion] access [protected] procedure parameter_profile
///   | [null_exclusion] access [protected] function parameter_and_result_profile
access_definition
 : null_exclusion? ACCESS CONSTANT? subtype_mark
 | null_exclusion? ACCESS PROTECTED? PROCEDURE parameter_profile
 | null_exclusion? ACCESS PROTECTED? FUNCTION parameter_and_result_profile
 ;

/// parameter_and_result_profile ::=
///     [formal_part] return [null_exclusion] subtype_mark
///   | [formal_part] return access_definition
parameter_and_result_profile
 : formal_part? RETURN null_exclusion? subtype_mark
 | formal_part? RETURN access_definition
 ;

/// parameter_profile ::= [formal_part]
parameter_profile
 : formal_part?
 ;

/// formal_part ::=
///    (parameter_specification {; parameter_specification})
formal_part
 : OPAR parameter_specification ( SEMI parameter_specification )* CPAR
 ;

/// parameter_specification ::=
///     defining_identifier_list : [aliased] mode [null_exclusion] subtype_mark [:= default_expression]
///   | defining_identifier_list : access_definition [:= default_expression]
parameter_specification
 : defining_identifier_list COL ALIASED? mode_ null_exclusion? subtype_mark ( ASSIGN default_expression )?
 | defining_identifier_list COL access_definition ( ASSIGN default_expression )?
 ;

/// mode ::= [in] | in out | out
mode_
 : IN OUT
 | OUT
 | IN?
 ;

/// defining_identifier_list ::=
///   defining_identifier {, defining_identifier}
defining_identifier_list
 : IDENTIFIER ( COMMA IDENTIFIER )*
 ;

/// default_expression ::= expression
default_expression
 : expression
 ;

/// null_exclusion ::= not null
null_exclusion
 : NOT NULL
 ;

/// subtype_mark ::= subtype name
subtype_mark
 : name
 ;

prefix
 : name
 ;

/// aggregate ::= record_aggregate | extension_aggregate | array_aggregate
aggregate
 : record_aggregate
 | extension_aggregate
 | array_aggregate
 ;

/// record_aggregate ::= (record_component_association_list)
record_aggregate
 : OPAR record_component_association_list CPAR
 ;

/// record_component_association_list ::=
///     record_component_association {, record_component_association}
///   | null record
record_component_association_list
 : record_component_association ( COMMA record_component_association )*
 | NULL RECORD
 ;

/// record_component_association ::=
///     [component_choice_list =>] expression
///    | component_choice_list => <>
record_component_association
 : ( component_choice_list ARROW )? expression
 | component_choice_list ARROW BOX
 ;

/// component_choice_list ::=
///      component_selector_name {| component_selector_name}
///    | others
component_choice_list
 : selector_name ( PIPE selector_name )*
 | OTHERS
 ;

/// extension_aggregate ::=
///     (ancestor_part with record_component_association_list)
extension_aggregate
 : OPAR ancestor_part WITH record_component_association_list CPAR
 ;

/// ancestor_part ::= expression | subtype_mark
ancestor_part
 : expression
 | subtype_mark
 ;

/// array_aggregate ::=
///   positional_array_aggregate | named_array_aggregate
array_aggregate
 : positional_array_aggregate
 | named_array_aggregate
 ;

/// positional_array_aggregate ::=
///     (expression, expression {, expression})
///   | (expression {, expression}, others => expression)
///   | (expression {, expression}, others => <>)
positional_array_aggregate
 : OPAR expression COMMA expression ( COMMA expression )* CPAR
 | OPAR expression ( COMMA expression )* COMMA OTHERS ARROW expression CPAR
 | OPAR expression ( COMMA expression )* COMMA OTHERS ARROW BOX CPAR
 ;

/// named_array_aggregate ::=
///     (array_component_association {, array_component_association})
named_array_aggregate
 : OPAR array_component_association ( COMMA array_component_association )* CPAR
 ;

/// array_component_association ::=
///     discrete_choice_list => expression
///   | discrete_choice_list => <>
array_component_association
 : discrete_choice_list ARROW expression
 | discrete_choice_list ARROW BOX
 ;

/// name ::=
///      direct_name | explicit_dereference
///    | indexed_component | slice
///    | selected_component | attribute_reference
///    | type_conversion | function_call
///    | character_literal | qualified_expression
///    | generalized_reference | generalized_indexing
///
/// explicit_dereference ::= name.all
///
/// prefix ::= name | implicit_dereference
///
/// implicit_dereference ::= name
///
/// indexed_component ::= prefix(expression {, expression})
///
/// attribute_reference ::= prefix'attribute_designator
///
/// qualified_expression ::= subtype_mark'(expression) | subtype_mark'aggregate
///
/// selected_component ::= prefix . selector_name
///
/// type_conversion ::=
///     subtype_mark(expression)
///   | subtype_mark(name)
///
/// function_call ::=
///     function_name
///   | function_prefix actual_parameter_part
///
/// generalized_reference ::= reference_object_name
///
/// generalized_indexing ::= indexable_container_object_prefix actual_parameter_part
name
 : CHARACTER_LITERAL
 | name SQ OPAR expression CPAR                    // qualified_expression ::= subtype_mark'(expression) | ...
 | name SQ aggregate                               // qualified_expression ::= ... | subtype_mark'aggregate
 | name DOT ALL                                    // explicit_dereference ::= name.all
 | name OPAR expression ( COMMA expression )* CPAR // indexed_component ::= prefix(expression {, expression})
 | name OPAR discrete_range CPAR                   // slice ::= prefix(discrete_range)
 | name DOT selector_name                          // selected_component ::= prefix . selector_name
 | name SQ attribute_designator                    // attribute_reference ::= prefix'attribute_designator
 | name OPAR expression CPAR                       // type_conversion ::= subtype_mark(expression) | ...
 | name OPAR name CPAR                             // type_conversion ::= ... | subtype_mark(name)
 | name actual_parameter_part                      // function_call ::= ... | function_prefix actual_parameter_part
 | direct_name
 ;

/// actual_parameter_part ::=
///     (parameter_association {, parameter_association})
actual_parameter_part
 : OPAR parameter_association ( COMMA parameter_association )* CPAR
 ;

/// parameter_association ::=
///    [formal_parameter_selector_name =>] explicit_actual_parameter
parameter_association
 : ( selector_name ARROW )? explicit_actual_parameter
 ;

/// explicit_actual_parameter ::= expression | variable_name
explicit_actual_parameter
 : expression
 | name
 ;

/// allocator ::=
///    new [subpool_specification] subtype_indication
///  | new [subpool_specification] qualified_expression
allocator
 : NEW subpool_specification? subtype_indication
 | NEW subpool_specification? qualified_expression
 ;

/// qualified_expression ::=
///    subtype_mark'(expression) | subtype_mark'aggregate
qualified_expression
 : subtype_mark SQ OPAR expression CPAR
 | subtype_mark SQ aggregate
 ;

/// subpool_specification ::= (subpool_handle_name)
subpool_specification
 : OPAR name CPAR
 ;

/// direct_name ::= identifier | operator_symbol
direct_name
 : IDENTIFIER
 | operator_symbol
 ;

/// discrete_range ::= discrete_subtype_indication | range
discrete_range
 : subtype_indication
 | range
 ;

/// attribute_designator ::=
///     identifier[(static_expression)]
///   | Access | Delta | Digits | Mod
attribute_designator
 : IDENTIFIER ( OPAR expression CPAR )?
 | ACCESS
 | DELTA
 | DIGITS
 | MOD
 ;

/// range_constraint ::=  range range
range_constraint
 : RANGE range
 ;

/// range ::=  range_attribute_reference
///    | simple_expression .. simple_expression
range
 : range_attribute_reference
 | simple_expression DOT_DOT simple_expression
 ;

/// range_attribute_reference ::= prefix'range_attribute_designator
range_attribute_reference
 : prefix SQ range_attribute_designator
 ;

/// range_attribute_designator ::= Range[(static_expression)]
range_attribute_designator
 : RANGE ( OPAR expression CPAR )?
 ;

/// operator_symbol ::= string_literal
operator_symbol
 : STRING_LITERAL
 ;

/// numeric_literal ::= decimal_literal | based_literal
numeric_literal
 : DECIMAL_LITERAL
 | BASED_LITERAL
 ;

/// expression ::=
///      relation {and relation}  | relation {and then relation}
///    | relation {or relation}  | relation {or else relation}
///    | relation {xor relation}
expression
 : relation ( AND relation )*
 | relation ( AND THEN relation )*
 | relation ( OR relation )*
 | relation ( OR ELSE relation )*
 | relation ( XOR relation )*
 ;

/// choice_expression ::=
///      choice_relation {and choice_relation}
///    | choice_relation {or choice_relation}
///    | choice_relation {xor choice_relation}
///    | choice_relation {and then choice_relation}
///    | choice_relation {or else choice_relation}
choice_expression
 : choice_relation ( AND choice_relation )*
 | choice_relation ( OR choice_relation )*
 | choice_relation ( XOR choice_relation )*
 | choice_relation ( AND THEN choice_relation )*
 | choice_relation ( OR ELSE choice_relation )*
 ;

/// choice_relation ::=
///      simple_expression [relational_operator simple_expression]
choice_relation
 : simple_expression ( relational_operator simple_expression )?
 ;

/// relation ::=
///      simple_expression [relational_operator simple_expression]
///    | simple_expression [not] in membership_choice_list
relation
 : simple_expression ( relational_operator simple_expression )?
 | simple_expression NOT? IN membership_choice_list
 ;

/// membership_choice_list ::= membership_choice {| membership_choice}
membership_choice_list
 : membership_choice ( PIPE membership_choice )*
 ;

/// membership_choice ::= choice_expression | range | subtype_mark
membership_choice
 : choice_expression
 | range
 | subtype_mark
 ;

/// simple_expression ::= [unary_adding_operator] term {binary_adding_operator term}
simple_expression
 : unary_adding_operator? term ( binary_adding_operator term )*
 ;

/// term ::= factor {multiplying_operator factor}
term
 : factor ( multiplying_operator factor )*
 ;

/// factor ::= primary [** primary] | abs primary | not primary
factor
 : primary ( EXP primary )?
 | ABS primary
 | NOT primary
 ;

/// primary ::=
///   numeric_literal | null | string_literal | aggregate
/// | name | allocator | (expression)
/// | (conditional_expression) | (quantified_expression)
primary
 : numeric_literal
 | NULL
 | STRING_LITERAL
 | aggregate
 | name
 | allocator
 | conditional_expression // the parens will be matched by `OPAR expression CPAR`
 | quantified_expression  // the parens will be matched by `OPAR expression CPAR`
 | OPAR expression CPAR
 ;

/// conditional_expression ::= if_expression | case_expression
conditional_expression
 : if_expression
 | case_expression
 ;

/// if_expression ::=
///    if condition then dependent_expression
///    {elsif condition then dependent_expression}
///    [else dependent_expression]
if_expression
 : IF condition THEN expression
   ( ELSIF condition THEN expression )*
   ( ELSE expression )?
 ;

/// case_expression ::=
///     case selecting_expression is
///     case_expression_alternative {,
///     case_expression_alternative}
case_expression
 : CASE expression IS case_expression_alternative ( COMMA case_expression_alternative )*
 ;

/// case_expression_alternative ::=
///     when discrete_choice_list =>
///         dependent_expression
case_expression_alternative
 : WHEN discrete_choice_list ARROW expression
 ;

/// discrete_choice_list ::= discrete_choice {| discrete_choice}
discrete_choice_list
 : discrete_choice ( PIPE discrete_choice )*
 ;

/// discrete_choice ::= choice_expression | discrete_subtype_indication | range | others
discrete_choice
 : choice_expression
 | subtype_indication
 | range
 | OTHERS
 ;

/// subtype_indication ::=  [null_exclusion] subtype_mark [constraint]
subtype_indication
 : null_exclusion? subtype_mark constraint?
 ;

/// constraint ::= scalar_constraint | composite_constraint
constraint
 : scalar_constraint
 | composite_constraint
 ;

/// scalar_constraint ::=
///      range_constraint | digits_constraint | delta_constraint
scalar_constraint
 : range_constraint
 | digits_constraint
 | delta_constraint
 ;

/// delta_constraint ::= delta static_expression [range_constraint]
delta_constraint
 : DELTA expression range_constraint?
 ;

/// composite_constraint ::=
///      index_constraint | discriminant_constraint
composite_constraint
 : index_constraint
 | discriminant_constraint
 ;

/// index_constraint ::=  (discrete_range {, discrete_range})
index_constraint
 : OPAR discrete_range ( COMMA discrete_range )* CPAR
 ;

/// discriminant_constraint ::=
///    (discriminant_association {, discriminant_association})
discriminant_constraint
 : OPAR discriminant_association ( COMMA discriminant_association )* CPAR
 ;

/// discriminant_association ::=
///    [discriminant_selector_name {| discriminant_selector_name} =>] expression
discriminant_association
 : ( selector_name ( PIPE selector_name )* ARROW )? expression
 ;

/// selector_name ::= identifier | character_literal | operator_symbol
selector_name
 : IDENTIFIER
 | CHARACTER_LITERAL
 | operator_symbol
 ;

/// condition ::= boolean_expression
condition
 : expression
 ;

/// quantified_expression ::=
///     for quantifier loop_parameter_specification => predicate
///   | for quantifier iterator_specification => predicate
quantified_expression
 : FOR quantifier loop_parameter_specification ARROW predicate
 | FOR quantifier iterator_specification ARROW predicate
 ;

/// iterator_specification ::=
///     defining_identifier in [reverse] iterator_name
///   | defining_identifier [: subtype_indication] of [reverse] iterable_name
iterator_specification
 : IDENTIFIER IN REVERSE? name
 | IDENTIFIER ( COL subtype_indication )? OF REVERSE? name
 ;

/// loop_parameter_specification ::=
///    defining_identifier in [reverse] discrete_subtype_definition
loop_parameter_specification
 : IDENTIFIER IN REVERSE? discrete_subtype_definition
 ;

/// quantifier ::= all | some
quantifier
 : ALL
 | SOME
 ;

/// predicate ::= boolean_expression
predicate
 : expression
 ;

/// relational_operator ::=   =   | /=  | <   | <= | > | >=
relational_operator
 : EQ
 | N_EQ
 | LT
 | LT_EQ
 | GT
 | GT_EQ
 ;

/// binary_adding_operator ::=   +   | –   | &
binary_adding_operator
 : PLUS
 | MIN
 | AMP
 ;

/// unary_adding_operator ::=   +   | –
unary_adding_operator
 : PLUS
 | MIN
 ;

/// multiplying_operator ::=   *   | /   | mod | rem
multiplying_operator
 : MULT
 | DIV
 | MOD
 | REM
 ;
