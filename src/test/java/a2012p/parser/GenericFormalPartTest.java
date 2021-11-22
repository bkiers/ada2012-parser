package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class GenericFormalPartTest extends BaseParserTest {

  public GenericFormalPartTest() {
    super("generic_formal_part");
  }

  @Test
  public void test() {
    String[] tests = {
        "generic",
        "generic Size   : Natural;",
        "generic Length : Integer := 200;",
        "generic Area   : Integer := Length*Length;",

        "generic\n" +
        "   type Item  is private;\n" +
        "   type Index is (<>);\n" +
        "   type Row   is array(Index range <>) of Item;\n" +
        "   with function \"<\"(X, Y : Item) return Boolean;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
