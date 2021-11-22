package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class NullStatementTest extends BaseParserTest {

  public NullStatementTest() {
    super("null_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "null;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
