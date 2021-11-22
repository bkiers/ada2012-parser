package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class InterfaceTypeDefinitionTest extends BaseParserTest {

  public InterfaceTypeDefinitionTest() {
    super("interface_type_definition");
  }

  @Test
  public void test() {
    String[] tests = {
        "limited interface",
        "synchronized interface and Queue"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
