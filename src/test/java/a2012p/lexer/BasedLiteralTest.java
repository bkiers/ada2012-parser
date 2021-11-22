package a2012p.lexer;

import org.junit.Test;

import java.util.Collections;
import java.util.List;

import static a2012p.Ada2012Lexer.BASED_LITERAL;
import static a2012p.matcher.ProducesTokens.producesTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class BasedLiteralTest {

  @Test
  @SuppressWarnings("unchecked")
  public void test() {
    Object[][] tests = {
        { "2#1111_1111#", Collections.singletonList(BASED_LITERAL) },
        { "16#FF#", Collections.singletonList(BASED_LITERAL) },
        { "016#0ff#", Collections.singletonList(BASED_LITERAL) },
        { "16#E#E1", Collections.singletonList(BASED_LITERAL) },
        { "2#1110_0000#", Collections.singletonList(BASED_LITERAL) },
        { "16#F.FF#E+2", Collections.singletonList(BASED_LITERAL) },
        { "2#1.1111_1111_1110#E11", Collections.singletonList(BASED_LITERAL) }
    };

    for (Object[] testCase : tests) {
      assertThat((String)testCase[0], producesTokens((List<Integer>)testCase[1]));
    }
  }
}
