package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class PrivateExtensionDeclarationTest extends BaseParserTest {

  public PrivateExtensionDeclarationTest() {
    super("private_extension_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "type List is new Ada.Finalization.Controlled with private;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}