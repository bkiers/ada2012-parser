package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class FactorTest extends BaseParserTest {

  public FactorTest() {
    super("factor");
  }

  @Test
  public void test() {
    String[] tests = {
        "not Destroyed"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
