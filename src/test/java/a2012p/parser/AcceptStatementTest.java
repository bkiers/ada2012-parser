package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class AcceptStatementTest extends BaseParserTest {

  public AcceptStatementTest() {
    super("accept_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "accept Shut_Down;",

        "accept Read(V : out Item) do\n" +
        "   V := Local_Item;\n" +
        "end Read;",

        "accept Request(Low)(D : Item) do\n" +
        "   Q := 42;\n" +
        "end Request;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
