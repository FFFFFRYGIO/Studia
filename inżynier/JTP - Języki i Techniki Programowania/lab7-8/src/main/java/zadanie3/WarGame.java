package zadanie3;

import java.util.Collections;
import java.util.LinkedList;

public class WarGame {
    private LinkedList<GameCard> firstPlayerCards;
    private LinkedList<GameCard> secondPlayerCards;
    private int turnCount;

    public WarGame() {
        firstPlayerCards = new LinkedList<>();
        secondPlayerCards = new LinkedList<>();
        initializeDeck();
        shuffleCards();
    }

    private void initializeDeck() {
        for (CardSuit suit : CardSuit.values()) {
            for (int rank = 1; rank <= 13; rank++) {
                firstPlayerCards.add(new GameCard(rank, suit));
            }
        }
    }

    private void shuffleCards() {
        Collections.shuffle(firstPlayerCards);
    }

    public void play() {
        while (!firstPlayerCards.isEmpty() && !secondPlayerCards.isEmpty()) {
            turnCount++;
            GameCard firstPlayerCard = firstPlayerCards.pop();
            GameCard secondPlayerCard = secondPlayerCards.pop();

            System.out.println("Player 1 plays: " + firstPlayerCard);
            System.out.println("Player 2 plays: " + secondPlayerCard);

            if (firstPlayerCard.getRank() > secondPlayerCard.getRank()) {
                firstPlayerCards.addLast(firstPlayerCard);
                firstPlayerCards.addLast(secondPlayerCard);
                System.out.println("Player 1 wins the turn!");
            } else if (firstPlayerCard.getRank() < secondPlayerCard.getRank()) {
                secondPlayerCards.addLast(firstPlayerCard);
                secondPlayerCards.addLast(secondPlayerCard);
                System.out.println("Player 2 wins the turn!");
            } else {
                System.out.println("War!");

                LinkedList<GameCard> warCards = new LinkedList<>();
                warCards.add(firstPlayerCard);
                warCards.add(secondPlayerCard);

                while (true) {
                    if (firstPlayerCards.size() < 2 || secondPlayerCards.size() < 2) {
                        // Not enough cards to continue the war
                        return;
                    }

                    warCards.add(firstPlayerCards.pop());
                    warCards.add(secondPlayerCards.pop());

                    GameCard firstPlayerWarCard = firstPlayerCards.pop();
                    GameCard secondPlayerWarCard = secondPlayerCards.pop();

                    System.out.println("Player 1 plays: " + firstPlayerWarCard);
                    System.out.println("Player 2 plays: " + secondPlayerWarCard);

                    warCards.add(firstPlayerWarCard);
                    warCards.add(secondPlayerWarCard);

                    if (firstPlayerWarCard.getRank() > secondPlayerWarCard.getRank()) {
                        firstPlayerCards.addAll(warCards);
                        System.out.println("Player 1 wins the war!");
                        break;
                    } else if (firstPlayerWarCard.getRank() < secondPlayerWarCard.getRank()) {
                        secondPlayerCards.addAll(warCards);
                        System.out.println("Player 2 wins the war!");
                        break;
                    }
                }
            }
        }

        if (firstPlayerCards.isEmpty()) {
            System.out.println("Player 2 wins the game!");
        } else {
            System.out.println("Player 1 wins the game!");
        }

        System.out.println("Total turns: " + turnCount);
    }

    public static void main(String[] args) {
        WarGame game = new WarGame();
        game.play();
    }
}
