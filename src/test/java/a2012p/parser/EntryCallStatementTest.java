package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class EntryCallStatementTest extends BaseParserTest {

  public EntryCallStatementTest() {
    super("procedure_or_entry_call_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "Agent.Shut_Down;",
        "Parser.Next_Lexeme(E);",
        "Pool(5).Read(Next_Char);",
        "Controller.Request(Low)(Some_Item);",
        "Flags(3).Seize;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
