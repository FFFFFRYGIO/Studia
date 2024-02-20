import time
import multiprocessing
from calculate_average_rental_cost import get_neibourhoods, calculate_average_rental_costs


neibourhoods_list = get_neibourhoods()


def run_serial():
    start_time = time.time()

    result = []
    for neibourhood in neibourhoods_list:
        average_cost = calculate_average_rental_costs(neibourhood)
        result += (neibourhood, average_cost)

    end_time = time.time()
    return result, end_time - start_time


def run_parallel(num_processes):
    start_time = time.time()

    chunk_size = len(neibourhoods_list) // num_processes

    # create a pool of processes to spread calculation between them
    pool = multiprocessing.Pool(processes=num_processes)
    # create list of ranges to specify for every process neibourhoods to calculate average rental cost
    # ranges =                  [(i * chunk_size+1,(i + 1) * chunk_size) for i in range(num_processes)]
    ranges = [(neibourhoods_list[(i * chunk_size):((i + 1) * chunk_size)]) for i in range(num_processes)]
    # for every process run function, giving neibourhoods list from ranges to ever process
    result = pool.starmap(calculate_average_rental_costs, ranges)

    end_time = time.time()
    return result, end_time - start_time


def main():
    print(f"neibourhoods_list={neibourhoods_list}")

    result, time_run = run_serial()
    print(f"serial time={time_run}result=\n{result}")

    result, time_run = run_parallel(2)
    print(f"parallel2 time={time_run}result=\n{result}")

    result, time_run = run_parallel(4)
    print(f"parallel4 time={time_run}result=\n{result}")


if __name__ == '__main__':
    main()
