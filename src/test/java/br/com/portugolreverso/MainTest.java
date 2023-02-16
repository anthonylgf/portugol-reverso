package br.com.portugolreverso;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class MainTest {

    @Test
    void passWrongCommandLine() {
        Assertions.assertThrows(RuntimeException.class, () -> Main.main("arquivo1.txt", "arquivo2.txt"));
    }
}