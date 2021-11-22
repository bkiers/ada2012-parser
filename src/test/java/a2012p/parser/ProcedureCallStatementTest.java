package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class ProcedureCallStatementTest extends BaseParserTest {

  public ProcedureCallStatementTest() {
    super("procedure_or_entry_call_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "Traverse_Tree;",
        "Print_Header(128, Title, True);",
        "Switch(From => X, To => Next);",
        "Print_Header(128, Header => Title, Center => True);",
        "Print_Header(Header => Title, Center => True, Pages => 128);"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
