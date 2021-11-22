package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class RelationTest extends BaseParserTest {

  public RelationTest() {
    super("relation");
  }

  @Test
  public void test() {
    String[] tests = {
        "Password(1 .. 3) = \"Bwv\"",
        "Count in Small_Int",
        "Count not in Small_Int"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
