package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class TermTest extends BaseParserTest {

  public TermTest() {
    super("term");
  }

  @Test
  public void test() {
    String[] tests = {
        "2*Line_Count"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
