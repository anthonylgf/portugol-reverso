package br.com.portugolreverso.errors;

public class InvalidFileException extends RuntimeException {
    
    public InvalidFileException(String filePath) {    
        super(String.format("Invalid file path: %s", filePath));
    }
}
