package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class AspectSpecificationTest extends BaseParserTest {

  public AspectSpecificationTest() {
    super("aspect_specification");
  }

  @Test
  public void test() {
    String[] tests = {
        "with mu"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
