package zadanie3;

public class GameCard {
    private final int rank;
    private final CardSuit cardSuit;

    public GameCard(int rank, CardSuit cardSuit) {
        this.rank = rank;
        this.cardSuit = cardSuit;
    }

    public int getRank() {
        return rank;
    }

    public CardSuit getCardSuit() {
        return cardSuit;
    }

    @Override
    public String toString() {
        return rank + " of " + cardSuit;
    }
}
