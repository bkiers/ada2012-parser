package a2012p.matcher;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.hamcrest.Description;
import org.hamcrest.TypeSafeMatcher;
import a2012p.Ada2012Lexer;
import a2012p.Ada2012Parser;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class UsesAllTokens extends TypeSafeMatcher<String> {

  private final String parserRule;
  private String source = null;
  private String errorMessage = null;

  private UsesAllTokens(String parserRule) {
    this.parserRule = parserRule;
  }

  @Override
  protected boolean matchesSafely(String source) {
    this.source = source;
    List<Token> tokens = new ArrayList<>();

    try {
      Ada2012Lexer lexer = new Ada2012Lexer(CharStreams.fromString(source));
      Ada2012Parser parser = new Ada2012Parser(new CommonTokenStream(lexer));

      parser.removeErrorListeners();
      parser.setErrorHandler(new BailErrorStrategy());

      tokens = this.createTokens(source);

      List<Integer> allTokenTypes = tokens.stream()
          .map(Token::getType)
          .collect(Collectors.toList());

      Method method = parser.getClass().getMethod(this.parserRule);
      ParserRuleContext context = (ParserRuleContext) method.invoke(parser);

      List<Integer> parsedTokenTypes = this.getTokenTypes(context);

      if (parsedTokenTypes.size() < allTokenTypes.size()) {
        int failedFromIndex = parsedTokenTypes.size();

        for (int i = 0; i < parsedTokenTypes.size(); i++) {
          if (!parsedTokenTypes.get(i).equals(allTokenTypes.get(i))) {
            failedFromIndex = i;
          }
        }

        List<Token> failed = tokens.subList(failedFromIndex, allTokenTypes.size());

        this.errorMessage = String.format("%s %s %s not included",
            failed.size() > 1 ? "tokens" : "token",
            failed.stream().map((t) -> String.format("`%s`", t.getText())).collect(Collectors.joining(", ")),
            failed.size() > 1 ? "are" : "is");
      }

      return allTokenTypes.equals(parsedTokenTypes);
    }
    catch (NoSuchMethodException e) {
      this.errorMessage = "Could not find parser rule: '" + this.parserRule + "'";
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

      if (rootCause instanceof NoViableAltException) {
        NoViableAltException ex = (NoViableAltException) rootCause;
        String notIncluded = tokens.get(Math.max(ex.getCtx().getSourceInterval().b, 0)).getText();
        this.errorMessage = String.format("token `%s` was not included", notIncluded);
      }
      else if (rootCause instanceof LexerNoViableAltException) {
        LexerNoViableAltException ex = (LexerNoViableAltException) rootCause;
        String offending = this.source.substring(ex.getStartIndex(), 1);
        this.errorMessage = String.format("the lexer did not recognise character `%s`", offending);
      }
    }

    return false;
  }

  @Override
  public void describeTo(Description description) {
    description.appendText("all tokens to be used by parser rule `")
        .appendText(this.parserRule)
        .appendText("`");
  }

  @Override
  protected void describeMismatchSafely(String item, Description description) {
    description.appendText(this.errorMessage)
        .appendText(" from `")
        .appendText(this.source)
        .appendText("`");
  }

  public static UsesAllTokens usesAllTokens(String parserRule) {
    return new UsesAllTokens(parserRule);
  }

  private List<Integer> getTokenTypes(ParserRuleContext context) {
    List<Integer> tokenTypes = new ArrayList<>();
    diveInto(context, tokenTypes);
    return tokenTypes;
  }

  private void diveInto(ParseTree parseTree, List<Integer> tokenTypes) {
    for (int i = 0; i < parseTree.getChildCount(); i++) {
      ParseTree child = parseTree.getChild(i);

      if (child instanceof TerminalNode) {
        tokenTypes.add(((TerminalNode) child).getSymbol().getType());
      }
      else {
        this.diveInto(child, tokenTypes);
      }
    }
  }

  private List<Token> createTokens(String input) {
    List<Token> tokens = new ArrayList<>();

    if (input == null) {
      return tokens;
    }

    CommonTokenStream tokenStream = new CommonTokenStream(new Ada2012Lexer(CharStreams.fromString(input)));
    tokenStream.fill();

    for (Token token : tokenStream.getTokens()) {
      if (token.getType() == Lexer.EOF) break;

      tokens.add(token);
    }

    return tokens;
  }
}
