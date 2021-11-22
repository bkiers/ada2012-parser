package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class NameTest extends BaseParserTest {

  public NameTest() {
    super("name");
  }

  @Test
  public void qualifiedExpressionsTest() {
    String[] tests = {
        "Mask'(Dec)",
        "Code'(Dec)",
        "Dozen'(1 | 3 | 5 | 7 => 2, others => 0)"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }

  @Test
  public void functionCallTest() {
    String[] tests = {
        "Dot_Product(U, V)",
        "Clock",
        "F.all",
        "Set(Signal => Red)",
        "Set(Color'(Red))",
        "Activate(X, Wait => 60.0, Prior => True)",
        "Activate(X, Y, 10.0, False)"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }

  @Test
  public void characterLiteralTest() {
    String[] tests = {
        "'''",
        "' '",
        "'x'"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}

