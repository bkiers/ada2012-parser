package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class AbortStatementTest extends BaseParserTest {

  public AbortStatementTest() {
    super("abort_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "abort a;",
        "abort a, b, c;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
