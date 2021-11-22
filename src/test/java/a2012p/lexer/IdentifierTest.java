package a2012p.lexer;

import org.junit.Test;

import java.util.Collections;
import java.util.List;

import static a2012p.Ada2012Lexer.IDENTIFIER;
import static a2012p.matcher.ProducesTokens.producesTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class IdentifierTest {

  @Test
  @SuppressWarnings("unchecked")
  public void test() {
    Object[][] tests = {
        { "Count", Collections.singletonList(IDENTIFIER) },
        { "X", Collections.singletonList(IDENTIFIER) },
        { "Get_Symbol", Collections.singletonList(IDENTIFIER) },
        { "Ethelyn", Collections.singletonList(IDENTIFIER) },
        { "Marion", Collections.singletonList(IDENTIFIER) },
        { "Snobol_4", Collections.singletonList(IDENTIFIER) },
        { "X1", Collections.singletonList(IDENTIFIER) },
        { "Page_Count", Collections.singletonList(IDENTIFIER) },
        { "Store_Next_Item", Collections.singletonList(IDENTIFIER) },
        { "Πλάτων", Collections.singletonList(IDENTIFIER) },
        { "Чайковский", Collections.singletonList(IDENTIFIER) },
        { "θ", Collections.singletonList(IDENTIFIER) },
        { "φ", Collections.singletonList(IDENTIFIER) }
    };

    for (Object[] testCase : tests) {
      assertThat((String)testCase[0], producesTokens((List<Integer>)testCase[1]));
    }
  }
}
