package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class PackageDeclarationTest extends BaseParserTest {

  public PackageDeclarationTest() {
    super("package_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "package Rational_Numbers is\n" +
        "   type Rational is\n" +
        "      record\n" +
        "         Numerator   : Integer;\n" +
        "         Denominator : Positive;\n" +
        "      end record;\n" +
        "   function \"=\"(X,Y : Rational) return Boolean;\n" +
        "   function \"/\"  (X,Y : Integer)  return Rational;\n" +
        "   function \"+\"  (X,Y : Rational) return Rational;\n" +
        "   function \"-\"  (X,Y : Rational) return Rational;\n" +
        "   function \"*\"  (X,Y : Rational) return Rational;\n" +
        "   function \"/\"  (X,Y : Rational) return Rational;\n" +
        "end Rational_Numbers;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}