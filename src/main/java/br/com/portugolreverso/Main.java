package br.com.portugolreverso;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.nio.file.Path;

import br.com.portugolreverso.errors.InvalidFileException;
import br.com.portugolreverso.errors.InvalidOptionsException;
import br.com.portugolreverso.parser.Parser;
import br.com.portugolreverso.parser.Visitor;

public class Main {
  public static void main(String... args) {
    if (args.length != 1) {
      throw new InvalidOptionsException();
    }

    var fileStream = getFileStream(args[0]);

    var visitor = new Visitor();

    var parser = new Parser(fileStream, visitor);
    parser.parseAndExecuteLanguage();
  }

  private static FileInputStream getFileStream(String filePath) {
    var path = Path.of(filePath);

    try {
      return new FileInputStream(path.toFile());
    } catch (FileNotFoundException e) {
      throw new InvalidFileException(path.toAbsolutePath().toString());
    }
  }
}
