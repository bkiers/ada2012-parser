package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class AbstractSubprogramDeclarationTest extends BaseParserTest {

  public AbstractSubprogramDeclarationTest() {
    super("abstract_subprogram_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "function Union(Left, Right : Set) return Set is abstract;",
        "function Intersection(Left, Right : Set) return Set is abstract;",
        "function Unit_Set(Element : Element_Type) return Set is abstract;",
        "procedure Take(Element : out Element_Type; From : in out Set) is abstract;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}