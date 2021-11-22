package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class CaseStatementTest extends BaseParserTest {

  public CaseStatementTest() {
    super("case_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "case Sensor is\n" +
        "   when Elevation      => Record_Elevation(Sensor_Value);\n" +
        "   when Azimuth        => Record_Azimuth  (Sensor_Value);\n" +
        "   when Distance       => Record_Distance (Sensor_Value);\n" +
        "   when others         => null;\n" +
        "end case;",

        "case Today is\n" +
        "   when Mon            => Compute_Initial_Balance;\n" +
        "   when Fri            => Compute_Closing_Balance;\n" +
        "   when Tue .. Thu     => Generate_Report(Today);\n" +
        "   when Sat .. Sun     => null;\n" +
        "end case;",

        "case Bin_Number(Count) is\n" +
        "   when 1        => Update_Bin(1);\n" +
        "   when 2        => Update_Bin(2);\n" +
        "   when 3 | 4    =>\n" +
        "      Empty_Bin(1);\n" +
        "      Empty_Bin(2);\n" +
        "   when others   => raise Error;\n" +
        "end case;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
