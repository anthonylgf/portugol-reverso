package br.com.portugol_reverso;

public class Main {
    public static void main(String ...args) {
        if (args.length != 1) {
            throwErrorMessage();
        }

        System.out.println("Starting project!");
    }

    private static void throwErrorMessage() {
        final var errorMessage =
                """
                Incorrect options while running command, you should run the follow command:
                    $ java -jar [PATH]/portugol-reverso-<VERSION>.jar [FILE-NAME]
                """;

        throw new RuntimeException(errorMessage);
    }
}
