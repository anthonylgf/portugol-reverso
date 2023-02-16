package br.com.portugolreverso.parser;

import br.com.portugolreverso.antlr.LogutropLexer;
import br.com.portugolreverso.antlr.LogutropParser;
import br.com.portugolreverso.errors.InvalidFileContentFormatException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

public class Parser {

    private InputStream inputStream;

    private Visitor visitor;

    public Parser(InputStream inputStream, Visitor visitor) {
        this.inputStream = inputStream;
        this.visitor = visitor;
    }

    public void parseAndExecuteLanguage() {
        try {
            var inputStream = CharStreams.fromStream(this.inputStream, Charset.forName("UTF-8"));
            var antlrLexer = new LogutropLexer(inputStream);
            var commonTokenStream = new CommonTokenStream(antlrLexer);
            var parser = new LogutropParser(commonTokenStream);

            var context = parser.programa();
            this.visitor.visitPrograma(context);
        } catch (IOException ioException) {
            throw new InvalidFileContentFormatException();
        }
    }
}
