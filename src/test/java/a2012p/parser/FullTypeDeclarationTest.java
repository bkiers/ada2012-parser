package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class FullTypeDeclarationTest extends BaseParserTest {

  public FullTypeDeclarationTest() {
    super("full_type_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "type Color  is (White, Red, Yellow, Green, Blue, Brown, Black);",
        "type Column is range 1 .. 72;",
        "type Table  is array(1 .. 10) of Integer;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}