package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class ProtectedTypeDeclarationTest extends BaseParserTest {

  public ProtectedTypeDeclarationTest() {
    super("protected_type_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "protected type Resource is\n" +
        "   entry Seize;\n" +
        "   procedure Release;\n" +
        "private\n" +
        "   Busy : Boolean := False;\n" +
        "end Resource;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}