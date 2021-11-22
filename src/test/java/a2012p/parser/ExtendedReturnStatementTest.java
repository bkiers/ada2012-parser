package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class ExtendedReturnStatementTest extends BaseParserTest {

  public ExtendedReturnStatementTest() {
    super("extended_return_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "return Node : Cell do\n" +
        "   Node.Value := Result;\n" +
        "   Node.Succ := Next_Node;\n" +
        "end return;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
