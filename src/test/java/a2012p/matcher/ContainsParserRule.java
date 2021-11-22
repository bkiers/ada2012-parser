package a2012p.matcher;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTree;
import org.hamcrest.Description;
import org.hamcrest.TypeSafeMatcher;
import a2012p.Ada2012Lexer;
import a2012p.Ada2012Parser;

public class ContainsParserRule extends TypeSafeMatcher<String> {

  private final String parserRule;
  private String source = null;
  private String errorMessage = null;
  private String parseTree = null;

  public ContainsParserRule(String parserRule) {
    this.parserRule = parserRule;
  }

  @Override
  protected boolean matchesSafely(String source) {
    this.source = source;

    try {
      Ada2012Lexer lexer = new Ada2012Lexer(CharStreams.fromString(source));
      Ada2012Parser parser = new Ada2012Parser(new CommonTokenStream(lexer));

      parser.removeErrorListeners();
      parser.setErrorHandler(new BailErrorStrategy());

      ParseTree root = parser.compilation();

      this.parseTree = root.toStringTree(parser);

      return this.parseTree.matches("^(?s).*?\\(" + this.parserRule + " .*$");
    }
    catch (Exception e) {
      Throwable rootCause = e;

      while (true) {
        Throwable temp = rootCause.getCause();
        if (temp == null) {
          break;
        }
        rootCause = temp;
      }

      this.errorMessage = rootCause.getMessage();
    }

    return false;
  }

  @Override
  public void describeTo(Description description) {
    description.appendText("the parse tree to contain `")
        .appendText(this.parserRule)
        .appendText("` for source: ")
        .appendText(this.source);
  }

  @Override
  protected void describeMismatchSafely(String item, Description description) {
    description.appendText("`")
        .appendText(this.parserRule)
        .appendText("` was not found: ")
        .appendText(this.errorMessage == null ? this.parseTree : this.errorMessage);
  }

  public static ContainsParserRule containsParserRule(String parserRule) {
    return new ContainsParserRule(parserRule);
  }
}
