package br.com.portugolreverso.errors;

public final class InvalidOptionsException extends RuntimeException {

    private static final String EXCEPTION_MESSAGE = 
        """
            You should run your command using the following options:
                $ java -jar [PATH]/portugol-reverso-<VERSION>.jar [FILE-NAME]        
        """;
    
    
    public InvalidOptionsException(){
        super(EXCEPTION_MESSAGE);
    }
    
}
