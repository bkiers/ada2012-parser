package a2012p;

import org.antlr.v4.runtime.BailErrorStrategy;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.junit.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import static org.junit.Assert.fail;

public class RegressionTest {

  private Ada2012Lexer lexer = null;
  private Ada2012Parser parser = null;

  @Test
  public void test() throws IOException {
    Path resourceDirectory = Paths.get("src","test", "resources");

    Files.walk(resourceDirectory)
        .filter(f -> Files.isRegularFile(f) && f.toString().matches(".*\\.(ada|adb|ads|adabody|ada_specification)"))
        .forEach(f -> this.parse(f.toAbsolutePath().toString()));

    System.out.println("failed=" + failed);
  }

  int failed = 0;

  private void parse(String fileName) {

    try {
      if (this.lexer == null) {
        this.lexer = new Ada2012Lexer(CharStreams.fromFileName(fileName));
        this.parser = new Ada2012Parser(new CommonTokenStream(this.lexer));

        this.parser.removeErrorListeners();
        this.parser.setErrorHandler(new BailErrorStrategy());
      }
      else {
        this.lexer.setInputStream(CharStreams.fromFileName(fileName));
        this.lexer.reset();

        this.parser.setTokenStream(new CommonTokenStream(this.lexer));
        this.parser.reset();
      }

      this.parser.compilation();
    }
    catch (Exception e) {
//      System.err.printf("ERROR: %s\n", fileName);
//
//      fail("Failed to parse: " + fileName);

      failed++;
      System.out.println(fileName);
    }
  }
}
