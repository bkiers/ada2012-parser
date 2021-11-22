package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class CodeStatementTest extends BaseParserTest {

  public CodeStatementTest() {
    super("code_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "SI_Format'(Code => SSM, B => M'Base_Reg, D => M'Disp);"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
