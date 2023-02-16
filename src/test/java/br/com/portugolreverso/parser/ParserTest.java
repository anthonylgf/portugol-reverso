package br.com.portugolreverso.parser;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ParserTest {

    private Visitor visitor;

    @BeforeEach
    void setup() {
        this.visitor = new Visitor();
    }

    @Test
    void testWrongTokens() {
        var parser = new Parser(null, visitor)

        String callWriteWithoutParam = "rimirpmi";
        var stream = getInputStreamFromString(callWriteWithoutParam);
        assertDoesNotThrow(() -> );
    }

    private InputStream getInputStreamFromString(String str) {
        return new ByteArrayInputStream(str.getBytes());
    }

}
