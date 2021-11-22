package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class ObjectRenamingDeclarationTest extends BaseParserTest {

  public ObjectRenamingDeclarationTest() {
    super("object_renaming_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "L : Person renames Leftmost_Person;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}