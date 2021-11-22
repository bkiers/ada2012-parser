package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class SubprogramDeclarationTest extends BaseParserTest {

  public SubprogramDeclarationTest() {
    super("subprogram_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "procedure Traverse_Tree;",
        "procedure Increment(X : in out Integer);",
        "procedure Right_Indent(Margin : out Line_Size);",
        "procedure Switch(From, To : in out Link);",
        "function Random return Probability;",
        "function Min_Cell(X : Link) return Cell;",
        "function Next_Frame(K : Positive) return Frame;",
        "function Dot_Product(Left, Right : Vector) return Real;",
        "function \"*\"(Left, Right : Matrix) return Matrix;",

        "procedure Print_Header(Pages  : in Natural;\n" +
        "            Header : in Line    :=  (1 .. Line'Last => ' ');\n" +
        "            Center : in Boolean := True);"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
