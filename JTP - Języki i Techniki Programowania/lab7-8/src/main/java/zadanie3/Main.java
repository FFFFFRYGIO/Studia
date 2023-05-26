package zadanie3;

public class Main {
    public static void main(String[] args) {
        PlayersService playersService = new PlayersService();
        playersService.SplitDeck();
        playersService.Play();
    }
}