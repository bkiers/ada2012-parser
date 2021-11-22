package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class GenericRenamingDeclarationTest extends BaseParserTest {

  public GenericRenamingDeclarationTest() {
    super("generic_renaming_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "generic package Enum_IO renames Ada.Text_IO.Enumeration_IO;",
        "generic procedure Enum_IO renames Ada.Text_IO.Enumeration_IO;",
        "generic function Enum_IO renames Ada.Text_IO.Enumeration_IO;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}