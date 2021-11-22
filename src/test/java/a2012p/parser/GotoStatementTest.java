package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class GotoStatementTest extends BaseParserTest {

  public GotoStatementTest() {
    super("goto_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "goto Sort;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
