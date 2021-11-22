package a2012p.lexer;

import org.junit.Test;

import java.util.Collections;
import java.util.List;

import static a2012p.Ada2012Lexer.COMMENT;
import static a2012p.matcher.ProducesTokens.producesTokens;
import static org.hamcrest.MatcherAssert.assertThat;

public class CommentTest {

  @Test
  @SuppressWarnings("unchecked")
  public void test() {
    Object[][] tests = {
        { "-- the last sentence above echoes the Algol 68 report", Collections.singletonList(COMMENT) },
        { "---------------- the first two hyphens start the comment", Collections.singletonList(COMMENT) }
    };

    for (Object[] testCase : tests) {
      assertThat((String)testCase[0], producesTokens((List<Integer>)testCase[1]));
    }
  }
}
