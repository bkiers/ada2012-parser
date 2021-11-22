package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class RequeueStatementTest extends BaseParserTest {

  public RequeueStatementTest() {
    super("requeue_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "requeue Request(Medium) with abort;",
        "requeue Flags(I).Seize;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
