package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class NumberDeclarationTest extends BaseParserTest {

  public NumberDeclarationTest() {
    super("number_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "Two_Pi        : constant := 2.0*Ada.Numerics.Pi;",
        "Max           : constant := 500;",
        "Max_Line_Size : constant := Max/6;",
        "Power_16      : constant := 2**16;",
        "One, Un, Eins : constant := 1;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
