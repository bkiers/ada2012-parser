package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class IfStatementTest extends BaseParserTest {

  public IfStatementTest() {
    super("if_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "if Month = December and Day = 31 then\n" +
        "   Month := January;\n" +
        "   Day   := 1;\n" +
        "   Year  := Year + 1;\n" +
        "end if;",

        "if Line_Too_Short then\n" +
        "   raise Layout_Error;\n" +
        "elsif Line_Full then\n" +
        "   New_Line;\n" +
        "   Put(Item);\n" +
        "else\n" +
        "   Put(Item);\n" +
        "end if;",

        "if My_Car.Owner.Vehicle /= My_Car then\n" +
        "   Report (\"Incorrect data\");\n" +
        "end if;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
