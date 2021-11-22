package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class LoopStatementTest extends BaseParserTest {

  public LoopStatementTest() {
    super("loop_statement");
  }

  @Test
  public void test() {
    String[] tests = {
        "loop\n" +
        "   Get(Current_Character);\n" +
        "   exit when Current_Character = '*';\n" +
        "end loop;",

        "while Bid(N).Price < Cut_Off.Price loop\n" +
        "   Record_Bid(Bid(N).Price);\n" +
        "   N := N + 1;\n" +
        "end loop;",

        "for J in Buffer'Range loop\n" +
        "   if Buffer(J) /= Space then\n" +
        "      Put(Buffer(J));\n" +
        "   end if;\n" +
        "end loop;",

        "while Next /= Head loop\n" +
        "      Sum  := Sum + Next.Value;\n" +
        "      Next := Next.Succ;\n" +
        "   end loop Summation;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}
