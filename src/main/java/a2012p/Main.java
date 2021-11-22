package a2012p;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;
import java.io.StringWriter;

public class Main {

  private static void dump(String source) {
    Ada2012Lexer lexer = new Ada2012Lexer(CharStreams.fromString(source));
    CommonTokenStream tokens = new CommonTokenStream(lexer);
    tokens.fill();

    for (Token t : tokens.getTokens()) {
      System.out.printf("%-20s '%s'\n",
          Ada2012Lexer.VOCABULARY.getSymbolicName(t.getType()),
          t.getText());
    }
  }

  public static void main(String[] args) {
    String source = "with Ada.Text_IO;\n" +
        "\n" +
        "procedure Greet is\n" +
        "begin\n" +
        "  -- Print \"Hello, World!\" to the screen\n" +
        "  Ada.Text_IO.Put_Line (\"Hello, World!\");\n" +
        "end Greet;";

    dump(source);

    Ada2012Lexer lexer = new Ada2012Lexer(CharStreams.fromString(source));
    Ada2012Parser parser = new Ada2012Parser(new CommonTokenStream(lexer));
    System.out.println(parser.compilation().toStringTree(parser));
  }
}