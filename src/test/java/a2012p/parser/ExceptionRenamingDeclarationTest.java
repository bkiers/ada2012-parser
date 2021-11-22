package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class ExceptionRenamingDeclarationTest extends BaseParserTest {

  public ExceptionRenamingDeclarationTest() {
    super("exception_renaming_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "EOF : exception renames Ada.IO_Exceptions.End_Error;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}