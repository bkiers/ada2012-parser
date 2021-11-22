package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class SimpleReturnStatementTest extends BaseParserTest {

  public SimpleReturnStatementTest() {
    super("simple_return_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "return;",
        "return Key_Value(Last_Index);"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
