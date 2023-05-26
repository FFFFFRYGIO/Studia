package zadanie3;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class PlayersService implements PlayersServiceInterface {
    LinkedList<GameCard> firstPlayerCards = new LinkedList<>();
    LinkedList<GameCard> secondPlayerCards = new LinkedList<>();

    @Override
    public void SplitDeck() {

        List<GameCard> deck = IntStream.rangeClosed(2, 14).boxed().flatMap(value -> Stream.of(CardSuit.values()).map(suit -> new GameCard(value, suit))).collect(Collectors.toList());

        System.out.println("Card Deck");
        Collections.shuffle(deck);
        System.out.println(deck);

        System.out.println("Player #1 Deck");
        firstPlayerCards = deck.stream().limit(deck.size()/2).collect(Collectors.toCollection(LinkedList::new));
        System.out.println(firstPlayerCards);

        System.out.println("Player #2 Deck");
        secondPlayerCards = deck.stream().skip(deck.size()/2).collect(Collectors.toCollection(LinkedList::new));
        System.out.println(secondPlayerCards);
    }

    @Override
    public void Play() {
        boolean endgame = false;
        int GameTurnCounter = 0;
        String winner = "";
        while(!endgame)
        {
            if(firstPlayerCards.isEmpty() || secondPlayerCards.isEmpty())
            {
                if(firstPlayerCards.isEmpty())
                {
                    winner = "Player #1";
                }
                else {
                    winner = "Player #2";
                }
                endgame = true;
            }
            else
            {
                if(GameTurnCounter % 2000 == 0)
                {
                    Collections.shuffle(firstPlayerCards);
                    Collections.shuffle(secondPlayerCards);
                }
                GameCard FirstPlayerCard = firstPlayerCards.pollFirst();
                GameCard SecondPlayerCard = secondPlayerCards.pollFirst();

                System.out.println("\tPlayer #1 card: " + FirstPlayerCard + "\t\tPlayer #2 card: " + SecondPlayerCard);

                assert FirstPlayerCard != null;
                assert SecondPlayerCard != null;
                if(FirstPlayerCard.getRank() > SecondPlayerCard.getRank())
                {
                    System.out.println("WIN1 Player #1 card > Player #2 card");
                    firstPlayerCards.add(FirstPlayerCard);
                    firstPlayerCards.add(SecondPlayerCard);
                    GameTurnCounter++;
                }
                else if(FirstPlayerCard.getRank() < SecondPlayerCard.getRank())
                {
                    System.out.println("WIN2 Player #2 card > Player #1 card");
                    secondPlayerCards.add(FirstPlayerCard);
                    secondPlayerCards.add(SecondPlayerCard);
                    GameTurnCounter++;
                }
                else if(FirstPlayerCard.getRank() == SecondPlayerCard.getRank())
                {
                    System.out.println("WAR! Player #1 card = Player #2 card");

                    List<GameCard> warCards = new ArrayList<>();
                    warCards.add(FirstPlayerCard);
                    warCards.add(SecondPlayerCard);

                    boolean warEnd = false;
                    while(!warEnd)
                    {
                        if (firstPlayerCards.size() < 2 || secondPlayerCards.size() < 2)
                        {

                            if(firstPlayerCards.size() < 2 )
                            {
                                winner = "Player #2 - Player #1 ran out of cards";
                            }
                            else {
                                winner = "Player #1 - Player #2 ran out of cards";
                            }
                            endgame = true;
                            break;
                        }
                        else
                        {
                            warCards.add(firstPlayerCards.pollFirst());
                            warCards.add(secondPlayerCards.pollFirst());

                            GameCard FirstPlayerCard2 = firstPlayerCards.pollFirst();
                            GameCard SecondPlayerCard2 = secondPlayerCards.pollFirst();

                            warCards.add(FirstPlayerCard2);
                            warCards.add(SecondPlayerCard2);

                            System.out.println("\tPlayer #1 card: " + FirstPlayerCard + "\t\tPlayer #2 card: " + SecondPlayerCard);

                            assert FirstPlayerCard2 != null;
                            assert SecondPlayerCard2 != null;
                            if(FirstPlayerCard2.getRank() > SecondPlayerCard2.getRank())
                            {
                                System.out.println("WIN1 Player #1 card > Player #2 card");
                                firstPlayerCards.addAll(warCards);
                                warEnd = true;
                                GameTurnCounter++;
                            }
                            else if(FirstPlayerCard2.getRank() < SecondPlayerCard2.getRank())
                            {
                                System.out.println("WIN2 Player #2 card > Player #1 card");
                                secondPlayerCards.addAll(warCards);
                                warEnd = true;
                                GameTurnCounter++;
                            }
                            else if(FirstPlayerCard2.getRank() == SecondPlayerCard2.getRank())
                            {
                                System.out.println("WAR!! Player #1 card = Player #2 card");
                                GameTurnCounter++;
                            }
                        }
                    }
                }
            }
        }
        System.out.println("Winner: [ " + winner + " ]");
        System.out.println("Number of Game Turns: [ " + GameTurnCounter + " ]");
    }
}
