package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class PragmaTest extends BaseParserTest {

  public PragmaTest() {
    super("pragma");
  }

  @Test
  public void test() {
    String[] tests = {
        "pragma List(Off);",
        "pragma Optimize(Off);",
        "pragma Pure(Rational_Numbers);",
        "pragma Assert(Exists(File_Name), Message => \"Nonexistent file\");"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
