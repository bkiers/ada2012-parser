package a2012p.lexer;

import org.junit.Test;

import java.util.Collections;
import java.util.List;

import static a2012p.Ada2012Lexer.DECIMAL_LITERAL;
import static a2012p.matcher.ProducesTokens.producesTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class DecimalLiteralTest {

  @Test
  @SuppressWarnings("unchecked")
  public void test() {
    Object[][] tests = {
        { "12", Collections.singletonList(DECIMAL_LITERAL) },
        { "0", Collections.singletonList(DECIMAL_LITERAL) },
        { "1E6", Collections.singletonList(DECIMAL_LITERAL) },
        { "123_456", Collections.singletonList(DECIMAL_LITERAL) },
        { "12.0", Collections.singletonList(DECIMAL_LITERAL) },
        { "0.0", Collections.singletonList(DECIMAL_LITERAL) },
        { "0.456", Collections.singletonList(DECIMAL_LITERAL) },
        { "3.14159_26", Collections.singletonList(DECIMAL_LITERAL) }
    };

    for (Object[] testCase : tests) {
      assertThat((String)testCase[0], producesTokens((List<Integer>)testCase[1]));
    }
  }
}
