package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class ExpressionTest extends BaseParserTest {

  public ExpressionTest() {
    super("expression");
  }

  @Test
  public void test() {
    String[] tests = {
        "Index = 0 or Item_Hit",
        "(Cold and Sunny) or Warm",
        "A**(B**C)"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
