package a2012p.parser;

import org.junit.Test;

import static a2012p.matcher.UsesAllTokens.usesAllTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class TaskTypeDeclarationTest extends BaseParserTest {

  public TaskTypeDeclarationTest() {
    super("task_type_declaration");
  }

  @Test
  public void test() {
    String[] tests = {
        "task type Server is\n" +
        "   entry Next_Work_Item(WI : in Work_Item);\n" +
        "   entry Shut_Down;\n" +
        "end Server;",

        "task type Keyboard_Driver(ID : Keyboard_ID := New_ID) is\n" +
        "      new Serial_Device with\n" +
        "   entry Read (C : out Character);\n" +
        "   entry Write(C : in  Character);\n" +
        "end Keyboard_Driver;"
    };

    for (String test : tests) {
      assertThat(test, usesAllTokens(super.parserRule));
    }
  }
}