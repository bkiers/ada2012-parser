package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class EnumerationTypeDefinitionTest extends BaseParserTest {

  public EnumerationTypeDefinitionTest() {
    super("enumeration_type_definition");
  }

  @Test
  public void test() {
    String[] tests = {
        "(Mon, Tue, Wed, Thu, Fri, Sat, Sun)",
        "(Clubs, Diamonds, Hearts, Spades)",
        "(M, F)",
        "(Low, Medium, Urgent)",
        "(White, Red, Yellow, Green, Blue, Brown, Black)",
        "(Red, Amber, Green)",
        "('A', 'B', 'C', 'D', 'E', 'F')",
        "('A', 'B', '*', B, None, '?', '%')"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}