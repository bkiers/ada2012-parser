package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class ExceptionDeclarationTest extends BaseParserTest {

  public ExceptionDeclarationTest() {
    super("exception_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "Singular : exception;",
        "Error    : exception;",
        "Overflow, Underflow : exception;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}