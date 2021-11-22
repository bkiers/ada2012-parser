package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class SimpleExpressionTest extends BaseParserTest {

  public SimpleExpressionTest() {
    super("simple_expression");
  }

  @Test
  public void test() {
    String[] tests = {
        "-4.0",
        "-4.0 + A",
        "B**2 - 4.0*A*C",
        "R*Sin(θ)*Cos(φ)"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
