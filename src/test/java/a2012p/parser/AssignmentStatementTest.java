package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class AssignmentStatementTest extends BaseParserTest {

  public AssignmentStatementTest() {
    super("assignment_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "Value := Max_Value - 1;",
        "Shade := Blue;",
        "Next_Frame(F)(M, N) := 2.5;",
        "U := Dot_Product(V, W);",
        "Writer := (Status => Open, Unit => Printer, Line_Count => 60);",
        "Next_Car.all := (72074, null);",
        "I := J;",
        "A(1 .. 9)  := \"tar sauce\";",
        "A(4 .. 12) := A(1 .. 9);"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
