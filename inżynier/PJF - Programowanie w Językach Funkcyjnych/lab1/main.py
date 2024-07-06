# Wykonal: Radoslaw Relidzynski, WCY20IJ1S1

from csv import reader
from datetime import datetime
from enum import Enum
from pathlib import Path
from typing import List, Optional

file = 'football_results_shorter.csv'


def read_csv_file(input_file: str) -> List[List[str]]:
    """read cvs file to List[List[str]]"""
    return [row for row in reader(Path(input_file).read_text(
        encoding="utf-8").splitlines(), delimiter=',')][1:]


Team = Enum("Team", {team_name: team_name for team_name in
                     set([m[0] for m in read_csv_file(file)] +
                         [m[1] for m in read_csv_file(file)])})


# Zad 1
def total_matches_by_year(year: int, team: Optional[Team] = None) -> int:
    """return total matches played in given year and optionally for given team"""
    file_content = read_csv_file(file)
    if team:
        return len(list(filter(lambda m: m[2][:4] == str(year) and team.value in (m[0], m[1]), file_content)))
    return len(list(filter(lambda m: m[2][:4] == str(year), file_content)))


# Zad 2
def most_goals(number: int) -> List[tuple[str, str, str, int]]:
    """return matches ordered by goals"""
    file_content = read_csv_file(file)
    return sorted(map(lambda m: (m[2], m[0], m[1], int(m[3]) + int(m[4])), file_content),
                  key=lambda mx: (mx[0], mx[3]), reverse=True)[:number]


# Zad 3
def team_matches_stats_per_year(team: Team) -> dict[str: dict[str: int]]:
    """return team statistics from every year"""
    file_content = read_csv_file(file)
    team_content = list(filter(lambda m: m[0] == team.value or m[1] == team.value, file_content))
    get_wins = lambda y: len(list(filter(
        lambda m: y == m[2][:4] and ((team.value == m[0] and m[3] > m[4]) or (team.value == m[1] and m[4] > m[3])),
        team_content)))
    get_loses = lambda y: len(list(filter(
        lambda m: y == m[2][:4] and ((team.value == m[0] and m[3] < m[4]) or (team.value == m[1] and m[4] < m[3])),
        team_content)))
    get_draws = lambda y: len(list(filter(
        lambda m: y == m[2][:4] and team.value in (m[0], m[1]) and m[3] == m[4], team_content)))
    get_penalties = lambda y: len(list(filter(
        lambda m: y == m[2][:4] and team.value in (m[0], m[1]) and m[5] == 'P', team_content)))
    return dict(sorted(
        {year: {'w': get_wins(year), 'l': get_loses(year), 'd': get_draws(year), 'p': get_penalties(year)}
         for year in sorted(set(map(lambda m: m[2][:4], team_content)),
                            key=lambda s: s[0])}.items(), key=lambda x: x[0]))


# Zad 4
def get_won(t, c):
    print(t)
    print(list(c))
    for i in list(filter(lambda m: m[0] == '07 Vestur', list(c))):
        print(i)
    quit()
    return len(list(c))


def teams_summary(number: Optional[int] = None) -> List[dict[str: int]]:
    """return summary of matches for every team"""
    file_content = read_csv_file(file)
    team_content = lambda t: filter(lambda m: m[0] == t or m[1] == t, file_content)
    get_played = lambda t, c: len(list(filter(lambda m: t in (m[0], m[1]), c)))
    get_won = lambda t, c: len(list(filter(
        lambda m: (t == m[0] and m[3] > m[4]) or (t == m[1] and m[4] > m[3]), c)))
    get_draw = lambda t, c: len(list(filter(lambda m: t in (m[0], m[1]) and m[3] == m[4], c)))
    get_lost = lambda t, c: len(list(filter(
        lambda m: (t == m[0] and m[3] < m[4]) or (t == m[1] and m[4] < m[3]), c)))
    get_for = lambda t, c: sum(list(map(
        lambda m: int(m[3]) if t == m[0] else int(m[4]) if t == m[1] else 0, c)))
    get_against = lambda t, c: sum(list(map(
        lambda m: int(m[4]) if t == m[0] else int(m[3]) if t == m[1] else 0, c)))
    get_gd = lambda t, c: get_for(t, c) - get_against(t, c)
    get_points = lambda t, c: 3 * get_won(t, c) + get_draw(t, c)

    get_summary = lambda t, c: {
            'team_name': t,
            'played': get_played(t, c),
            'won': get_won(t, c),
            'draw': get_draw(t, c),
            'lost': get_lost(t, c),
            'for': get_for(t, c),
            'against': get_against(t, c),
            'gd': get_gd(t, c),
            'points': get_points(t, c),
        }

    if number:
        return sorted(list(map(lambda t: get_summary(t.value, team_content(t.value)), Team)),
                      key=lambda d: d['points'], reverse=True)[:number]

    return sorted(list(map(lambda t: get_summary(t.value, team_content(t.value)), Team)),
                  key=lambda d: d['points'], reverse=True)


if __name__ == '__main__':

    # Specify which function You want to test
    run = (0, 1, 2, 3, 4)

    if 1 in run:
        print('Zad 1')
        print(total_matches_by_year(datetime(1888, 1, 1).year))
        print(total_matches_by_year(datetime(1888, 1, 1).year, Team('Bolton Wanderers')))

    if 2 in run:
        print('Zad 2')
        print(most_goals(10))
        print(most_goals(2))

    if 3 in run:
        print('Zad 3')
        print(team_matches_stats_per_year(Team('Viktoria Plzen')))
        print(team_matches_stats_per_year(Team('Derby County')))

    if 4 in run:
        print('Zad 4')
        print(teams_summary())
        print(teams_summary(2))
