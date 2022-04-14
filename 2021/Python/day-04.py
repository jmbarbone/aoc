import numpy as np
import unittest


def clean_card(card) :
    return np.array([i.rsplit() for i in card], dtype=int)


def card_has_bingo(card) :
    col = card.all(0).any()
    row = card.all(1).any()
    return col or row


def get_cards(x) :
    cards = [i for i in x if len(i) > 1]
    cards = [c.rstrip() for c in cards]
    cards = np.array_split(cards, len(cards) / 5)
    cards = [clean_card(i) for i in cards]
    return cards


def day_04a(calls, cards) :
    return play_bingo(calls=calls, cards=cards, method="first")


def day_04b(calls, cards) :
    return play_bingo(calls=calls, cards=cards, method="last")


def play_bingo(calls, cards, method="first") :
    nr = range(len(cards))
    # make game cards
    game_cards = [np.full([5, 5], False) for i in nr]
    winners = []

    for i in nr :
        # print(f"Calling number {i}: {calls[i]}")

        any_bingo = []
        for j in list(set(nr) - set(winners)) :
        # for j in nr :
            # remove the winners from the checks -- speed?
            # mark the called number as True
            game_cards[j][cards[j] == calls[i]] = True

            # if the game card has any matches, add it to the winner list
            if card_has_bingo(game_cards[j]) :
                winners.append(j)
                any_bingo.append(True)
            else :
                any_bingo.append(False)

        # get unique values
        winners = list(dict.fromkeys(winners))
        if method == "first" :
            # if playing for first, any bingo is a winner
            bingo = any(any_bingo)
        elif method == "last" :
            # otherwise all have to match (or all those that are left)
            # print(any_bingo)
            bingo = all(any_bingo)
        else :
            raise ValueError("method must be 'first' or 'last'")

        if bingo :
            break

    if not bingo :
          raise ValueError("bingo is not True")

    # print("the winners are: " + str(winners))
    # print("the call position is: " + str(i))
    # choose the last one
    winner = winners[-1]
    # print("the winner is: " + str(winner))
    # numbers that weren't called * the last number called
    res = cards[winner][np.invert(game_cards[winner])].sum() * calls[i]
    return res


class testDay04(unittest.TestCase) :

    def test_day_04a(self) :
        self.assertEqual(day_04a(calls, cards), 55770)

    def test_day_04b(self) :
        self.assertEqual(day_04b(calls, cards), 2980)


if __name__ == '__main__':
    with open("data/day-04.txt") as f :
        x = f.readlines()

    calls = [int(i) for i in x[0].rsplit(",")]
    cards = get_cards(x[2:])
    unittest.main()
