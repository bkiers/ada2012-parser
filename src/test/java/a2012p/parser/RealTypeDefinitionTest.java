package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class RealTypeDefinitionTest extends BaseParserTest {

  public RealTypeDefinitionTest() {
    super("real_type_definition");
  }

  @Test
  public void test() {
    String[] tests = {
        "digits 10 range -1.0 .. 1.0",
        "digits 8",
        "digits 7 range 0.0 .. 1.0E35",
        "delta 0.125 range 0.0 .. 255.0",
        "delta System.Fine_Delta range -1.0 .. 1.0",
        "delta 0.01 digits 15"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
