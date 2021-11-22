package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class SelectStatementTest extends BaseParserTest {

  public SelectStatementTest() {
    super("select_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "select\n" +
        "   accept Driver_Awake_Signal;\n" +
        "or\n" +
        "   delay 30.0*Seconds;\n" +
        "   Stop_The_Train;\n" +
        "end select;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
