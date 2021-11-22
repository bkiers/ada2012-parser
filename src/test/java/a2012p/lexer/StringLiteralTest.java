package a2012p.lexer;

import org.junit.Test;

import java.util.Collections;
import java.util.List;

import static a2012p.Ada2012Lexer.STRING_LITERAL;
import static a2012p.matcher.ProducesTokens.producesTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class StringLiteralTest {

  @Test
  @SuppressWarnings("unchecked")
  public void test() {
    Object[][] tests = {
        { "\"Message of the day:\"", Collections.singletonList(STRING_LITERAL) },
        { "\"\"", Collections.singletonList(STRING_LITERAL) },
        { "\" \"", Collections.singletonList(STRING_LITERAL) },
        { "\"A\"", Collections.singletonList(STRING_LITERAL) },
        { "\"\"\"\"", Collections.singletonList(STRING_LITERAL) },
        { "\"Characters such as $, %, and } are allowed in string literals\"", Collections.singletonList(STRING_LITERAL) },
        { "\"Archimedes said \"\"Εύρηκα\"\"\"", Collections.singletonList(STRING_LITERAL) },
        { "\"Volume of cylinder (πr²h) = \"", Collections.singletonList(STRING_LITERAL) }
    };

    for (Object[] testCase : tests) {
      assertThat((String)testCase[0], producesTokens((List<Integer>)testCase[1]));
    }
  }
}
