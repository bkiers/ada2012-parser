package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class GenericDeclarationTest extends BaseParserTest {

  public GenericDeclarationTest() {
    super("generic_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "generic\n" +
        "   type Elem is private;\n" +
        "procedure Exchange(U, V : in out Elem);",

        "generic\n" +
        "   type Item is private;\n" +
        "   with function \"*\"(U, V : Item) return Item is <>;\n" +
        "function Squaring(X : Item) return Item;",

        "generic\n" +
        "   type Item   is private;\n" +
        "   type Vector is array (Positive range <>) of Item;\n" +
        "   with function Sum(X, Y : Item) return Item;\n" +
        "package On_Vectors is\n" +
        "   function Sum  (A, B : Vector) return Vector;\n" +
        "   function Sigma(A    : Vector) return Item;\n" +
        "   Length_Error : exception;\n" +
        "end On_Vectors;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}