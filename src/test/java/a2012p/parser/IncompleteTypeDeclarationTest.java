package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class IncompleteTypeDeclarationTest extends BaseParserTest {

  public IncompleteTypeDeclarationTest() {
    super("incomplete_type_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "type Cell;",
        "type Person(<>);",
        "type Car is tagged;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}