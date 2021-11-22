package a2012p.matcher;

import org.antlr.v4.runtime.BailErrorStrategy;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import a2012p.Ada2012Lexer;

import java.util.List;
import java.util.stream.Collectors;

import static a2012p.Ada2012Lexer.VOCABULARY;

public class ProducesTokens extends TypeSafeMatcher<String> {

  private String source;
  private final List<Integer> expected;
  private List<Integer> actual;

  private ProducesTokens(List<Integer> expected) {
    this.expected = expected;
  }

  @Override
  protected boolean matchesSafely(String source) {
    this.source = source;

    Ada2012Lexer lexer = new Ada2012Lexer(CharStreams.fromString(source));
    CommonTokenStream tokenStream = new CommonTokenStream(lexer);
    tokenStream.fill();

    List<Token> tokens = tokenStream.getTokens().subList(0, tokenStream.size() - 1);

    this.actual = tokens.stream().map(Token::getType).collect(Collectors.toList());

    return this.expected.equals(this.actual);
  }

  @Override
  public void describeTo(Description description) {
    String message = String.format("  %s",
        this.expected.stream().map(VOCABULARY::getSymbolicName).collect(Collectors.toList()));

    description.appendText(message);
  }

  @Override
  protected void describeMismatchSafely(String item, Description description) {
    String message = String.format("  %s\nFor input   %s",
        this.actual.stream().map(VOCABULARY::getSymbolicName).collect(Collectors.toList()),
        this.source);

    description.appendText(message);
  }

  public static Matcher<String> producesTokens(List<Integer> actual) {
    return new ProducesTokens(actual);
  }
}
