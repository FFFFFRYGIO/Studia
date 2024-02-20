import get_content
import multiprocessing
import time

path = 'AB_NYC_2019.csv'


def avg(prices):
    amount = 0
    size = len(prices)
    for j in prices:
        amount += j
    prices = amount/size
    return prices


def get_neighborhood():
    df = get_content.read_csv(path)
    neighborhoods = {}

    for i, row in df.iterrows():
        neighbourhood = row['neighbourhood_group']
        price = row['price']
        if neighbourhood in neighborhoods:
            neighborhoods[neighbourhood].append(price)
        else:
            neighborhoods[neighbourhood] = [price]

    return neighborhoods


def calculate_average_rental_costs():
    neighborhoods = get_neighborhood()
    start_time = time.time()

    for i in neighborhoods:
        neighborhoods[i] = avg(neighborhoods[i])

    end_time = time.time()
    print(neighborhoods, end_time - start_time)


def calculate_average_rental_cost_parallel():
    neighborhoods = get_neighborhood()

    pool = multiprocessing.Pool(processes=len(neighborhoods))
    range = [([neighborhoods[i]]) for i in neighborhoods]

    start_time = time.time()
    result = pool.starmap(avg, range)
    end_time = time.time()

    print(result, end_time - start_time)


if __name__ == '__main__':

    calculate_average_rental_costs()
    calculate_average_rental_cost_parallel()
