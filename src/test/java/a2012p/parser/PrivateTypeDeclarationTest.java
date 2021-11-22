package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class PrivateTypeDeclarationTest extends BaseParserTest {

  public PrivateTypeDeclarationTest() {
    super("private_type_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "type Key is private;",
        "type File_Name is limited private;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}