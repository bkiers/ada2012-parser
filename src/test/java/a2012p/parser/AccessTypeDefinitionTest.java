package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class AccessTypeDefinitionTest extends BaseParserTest {

  public AccessTypeDefinitionTest() {
    super("access_type_definition");
  }

  @Test
  public void test() {
    String[] tests = {
        "access Peripheral",
        "access all Binary_Operation'Class",
        "access procedure (M : in String := \"Error!\")"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
