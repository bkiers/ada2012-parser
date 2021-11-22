package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class PackageRenamingDeclarationTest extends BaseParserTest {

  public PackageRenamingDeclarationTest() {
    super("package_renaming_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "package TM renames Table_Manager;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}