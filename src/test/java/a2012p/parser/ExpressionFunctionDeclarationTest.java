package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class ExpressionFunctionDeclarationTest extends BaseParserTest {

  public ExpressionFunctionDeclarationTest() {
    super("expression_function_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "function Is_Origin (P : in Point) return Boolean is\n" +
        "   (P.X = 0.0 and P.Y = 0.0);"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}