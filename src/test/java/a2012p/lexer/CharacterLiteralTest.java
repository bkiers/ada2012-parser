package a2012p.lexer;

import org.junit.Test;

import java.util.Collections;
import java.util.List;

import static a2012p.Ada2012Lexer.CHARACTER_LITERAL;
import static a2012p.matcher.ProducesTokens.producesTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class CharacterLiteralTest {

  @Test
  @SuppressWarnings("unchecked")
  public void test() {
    Object[][] tests = {
        { "'A'", Collections.singletonList(CHARACTER_LITERAL) },
        { "'*'", Collections.singletonList(CHARACTER_LITERAL) },
        { "'''", Collections.singletonList(CHARACTER_LITERAL) },
        { "' '", Collections.singletonList(CHARACTER_LITERAL) },
        { "'L'", Collections.singletonList(CHARACTER_LITERAL) },
        { "'Л'", Collections.singletonList(CHARACTER_LITERAL) },
        { "'Λ'", Collections.singletonList(CHARACTER_LITERAL) },
        { "'א'", Collections.singletonList(CHARACTER_LITERAL) },
        { "'∞'", Collections.singletonList(CHARACTER_LITERAL) }
    };

    for (Object[] testCase : tests) {
      assertThat((String)testCase[0], producesTokens((List<Integer>)testCase[1]));
    }
  }
}
