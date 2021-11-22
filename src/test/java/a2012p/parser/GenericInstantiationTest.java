package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class GenericInstantiationTest extends BaseParserTest {

  public GenericInstantiationTest() {
    super("generic_instantiation");
  }

  @Test
  public void test() {
    String[] tests = {
        "procedure Swap is new Exchange(Elem => Integer);",
        "procedure Swap is new Exchange(Character);",
        "function Square is new Squaring(Integer);",
        "function Square is new Squaring(Item => Matrix, \"*\" => Matrix_Product);",
        "function Square is new Squaring(Matrix, Matrix_Product);",
        "package Int_Vectors is new On_Vectors(Integer, Table, \"+\");"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}