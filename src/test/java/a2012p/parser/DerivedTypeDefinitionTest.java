package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class DerivedTypeDefinitionTest extends BaseParserTest {

  public DerivedTypeDefinitionTest() {
    super("derived_type_definition");
  }

  @Test
  public void test() {
    String[] tests = {
        "new Coordinate",
        "new Day range Tue .. Thu",
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
