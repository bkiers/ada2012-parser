package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class SubprogramRenamingDeclarationTest extends BaseParserTest {

  public SubprogramRenamingDeclarationTest() {
    super("subprogram_renaming_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "procedure My_Write(C : in Character) renames Pool(K).Write;",
        "function Real_Plus(Left, Right : Real   ) return Real    renames \"+\";",
        "function Int_Plus (Left, Right : Integer) return Integer renames \"+\";",
        "function Rouge return Color renames Red;",
        "function Rot   return Color renames Red;",
        "function Rosso return Color renames Rouge;",
        "function Next(X : Color) return Color renames Color'Succ;",
        "overriding function Next(X : Color) return Color renames Color'Succ;",
        "not overriding function Next(X : Color) return Color renames Color'Succ;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}