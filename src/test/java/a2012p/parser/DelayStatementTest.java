package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class DelayStatementTest extends BaseParserTest {

  public DelayStatementTest() {
    super("delay_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "delay 3.0;",
        "delay until Next_Time;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
