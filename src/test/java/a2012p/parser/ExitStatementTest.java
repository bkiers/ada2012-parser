package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class ExitStatementTest extends BaseParserTest {

  public ExitStatementTest() {
    super("exit_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "EXIT;",
        "exit when New_Item = Terminal_Item;",
        "exit Main_Cycle when Found;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
