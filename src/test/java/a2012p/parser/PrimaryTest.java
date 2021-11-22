package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class PrimaryTest extends BaseParserTest {

  public PrimaryTest() {
    super("primary");
  }

  @Test
  public void test() {
    String[] tests = {
        "Volume",
        "4.0",
        "Pi",
        "(1 .. 10 => 0)",
        "Sum",
        "Integer'Last",
        "Sine(X)",
        "Color'(Blue)",
        "Real(M*N)",
        "(Line_Count + 10)"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
