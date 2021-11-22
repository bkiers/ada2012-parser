package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class IntegerTypeDefinitionTest extends BaseParserTest {

  public IntegerTypeDefinitionTest() {
    super("integer_type_definition");
  }

  @Test
  public void test() {
    String[] tests = {
        "range 1 .. 2_000",
        "range 1 .. Max_Line_Size",
        "range -10 .. 10",
        "range 1 .. 10",
        "range 0 .. Max",
        "mod 256",
        "mod 97"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}