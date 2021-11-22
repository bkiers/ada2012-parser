package a2012p.lexer;

import org.junit.Test;

import java.util.Collections;
import java.util.List;

import static a2012p.Ada2012Lexer.*;
import static a2012p.matcher.ProducesTokens.producesTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class KeywordTest {

  @Test
  @SuppressWarnings("unchecked")
  public void test() {
    Object[][] tests = {
        { "abort", Collections.singletonList(ABORT) },
        { "Abort", Collections.singletonList(ABORT) },
        { "ABORT", Collections.singletonList(ABORT) },
        { "ABS", Collections.singletonList(ABS) },
        { "ABSTRACT", Collections.singletonList(ABSTRACT) },
        { "ACCEPT", Collections.singletonList(ACCEPT) },
        { "ACCESS", Collections.singletonList(ACCESS) },
        { "ALIASED", Collections.singletonList(ALIASED) },
        { "ALL", Collections.singletonList(ALL) },
        { "AND", Collections.singletonList(AND) },
        { "ARRAY", Collections.singletonList(ARRAY) },
        { "AT", Collections.singletonList(AT) },
        { "BEGIN", Collections.singletonList(BEGIN) },
        { "BODY", Collections.singletonList(BODY) },
        { "CASE", Collections.singletonList(CASE) },
        { "CONSTANT", Collections.singletonList(CONSTANT) },
        { "DECLARE", Collections.singletonList(DECLARE) },
        { "DELAY", Collections.singletonList(DELAY) },
        { "DELTA", Collections.singletonList(DELTA) },
        { "DIGITS", Collections.singletonList(DIGITS) },
        { "DO", Collections.singletonList(DO) },
        { "ELSE", Collections.singletonList(ELSE) },
        { "ELSIF", Collections.singletonList(ELSIF) },
        { "END", Collections.singletonList(END) },
        { "ENTRY", Collections.singletonList(ENTRY) },
        { "EXCEPTION", Collections.singletonList(EXCEPTION) },
        { "EXIT", Collections.singletonList(EXIT) },
        { "FOR", Collections.singletonList(FOR) },
        { "FUNCTION", Collections.singletonList(FUNCTION) },
        { "GENERIC", Collections.singletonList(GENERIC) },
        { "GOTO", Collections.singletonList(GOTO) },
        { "IF", Collections.singletonList(IF) },
        { "IN", Collections.singletonList(IN) },
        { "INTERFACE", Collections.singletonList(INTERFACE) },
        { "IS", Collections.singletonList(IS) },
        { "LIMITED", Collections.singletonList(LIMITED) },
        { "LOOP", Collections.singletonList(LOOP) },
        { "MOD", Collections.singletonList(MOD) },
        { "NEW", Collections.singletonList(NEW) },
        { "NOT", Collections.singletonList(NOT) },
        { "NULL", Collections.singletonList(NULL) },
        { "OF", Collections.singletonList(OF) },
        { "OR", Collections.singletonList(OR) },
        { "OTHERS", Collections.singletonList(OTHERS) },
        { "OUT", Collections.singletonList(OUT) },
        { "OVERRIDING", Collections.singletonList(OVERRIDING) },
        { "PACKAGE", Collections.singletonList(PACKAGE) },
        { "PRAGMA", Collections.singletonList(PRAGMA) },
        { "PRIVATE", Collections.singletonList(PRIVATE) },
        { "PROCEDURE", Collections.singletonList(PROCEDURE) },
        { "PROTECTED", Collections.singletonList(PROTECTED) },
        { "RAISE", Collections.singletonList(RAISE) },
        { "RANGE", Collections.singletonList(RANGE) },
        { "RECORD", Collections.singletonList(RECORD) },
        { "REM", Collections.singletonList(REM) },
        { "RENAMES", Collections.singletonList(RENAMES) },
        { "REQUEUE", Collections.singletonList(REQUEUE) },
        { "RETURN", Collections.singletonList(RETURN) },
        { "REVERSE", Collections.singletonList(REVERSE) },
        { "SELECT", Collections.singletonList(SELECT) },
        { "SEPARATE", Collections.singletonList(SEPARATE) },
        { "SOME", Collections.singletonList(SOME) },
        { "SUBTYPE", Collections.singletonList(SUBTYPE) },
        { "SYNCHRONIZED", Collections.singletonList(SYNCHRONIZED) },
        { "TAGGED", Collections.singletonList(TAGGED) },
        { "TASK", Collections.singletonList(TASK) },
        { "TERMINATE", Collections.singletonList(TERMINATE) },
        { "THEN", Collections.singletonList(THEN) },
        { "TYPE", Collections.singletonList(TYPE) },
        { "UNTIL", Collections.singletonList(UNTIL) },
        { "USE", Collections.singletonList(USE) },
        { "WHEN", Collections.singletonList(WHEN) },
        { "WHILE", Collections.singletonList(WHILE) },
        { "WITH", Collections.singletonList(WITH) },
        { "XOR", Collections.singletonList(XOR) },
    };

    for (Object[] testCase : tests) {
      assertThat((String)testCase[0], producesTokens((List<Integer>)testCase[1]));
    }
  }
}
