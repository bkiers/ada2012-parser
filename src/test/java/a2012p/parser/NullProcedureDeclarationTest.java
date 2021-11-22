package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class NullProcedureDeclarationTest extends BaseParserTest {

  public NullProcedureDeclarationTest() {
    super("null_procedure_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "procedure Simplify(Expr : in out Expression) is null;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}