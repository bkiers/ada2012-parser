package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class BlockStatementTest extends BaseParserTest {

  public BlockStatementTest() {
    super("block_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "Swap:\n" +
        "  declare\n" +
        "    Temp : Integer;\n" +
        "  begin\n" +
        "    Temp := V; V := U; U := Temp;\n" +
        "  end Swap;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
