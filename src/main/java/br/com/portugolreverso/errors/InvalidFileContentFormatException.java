package br.com.portugolreverso.errors;

public class InvalidFileContentFormatException extends RuntimeException {

    public InvalidFileContentFormatException() {
        super("Cannot read the content in specified file!");
    }

}
