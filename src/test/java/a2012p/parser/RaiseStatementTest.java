package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class RaiseStatementTest extends BaseParserTest {

  public RaiseStatementTest() {
    super("raise_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "raise;",
        "raise Queue_Error with \"Buffer Full\";",
        "raise Ada.IO_Exceptions.Name_Error;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
