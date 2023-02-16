package br.com.portugolreverso;

import br.com.portugolreverso.errors.InvalidOptionsException;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class MainTest {

    @Test
    void passWrongCommandLine() {
        Assertions.assertThrows(InvalidOptionsException.class, () -> Main.main("arquivo1.txt", "arquivo2.txt"));
    }
}