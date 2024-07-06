import random
import time
import multiprocessing

numbers = []


def get_numbers(n):
    for _ in range(n):
        numbers.append(random.randint(1, 100))


def count_numbers(divisor, numbers_subset):
    result = 0

    for number in numbers_subset:
        if number % divisor == 0:
            result += 1

    return result


def run_serial(n, divisor):
    start_time = time.time()

    result = count_numbers(divisor, numbers[0:n])

    end_time = time.time()
    return result, end_time - start_time


def run_parallel(num_processes, n, divisor):
    start_time = time.time()

    chunk_size = n // num_processes
    # create a pool of processes to spread calculation between them
    pool = multiprocessing.Pool(processes=num_processes)
    # create list of ranges to specify for every process neibourhoods to calculate average rental cost
    # ranges = [(divisor, i * chunk_size + 1, (i + 1) * chunk_size) for i in range(num_processes)]
    ranges = [(divisor, numbers[(i * chunk_size + 1):((i + 1) * chunk_size)]) for i in range(num_processes)]
    # for every process run function, giving neibourhoods list from ranges to ever process
    results = pool.starmap(count_numbers, ranges)
    result = sum(results)

    end_time = time.time()
    return result, end_time - start_time


def main():
    n = 1000
    get_numbers(n)

    result, time_run = run_serial(n, 2)
    print(f"serial time={time_run} result={result}")

    result, time_run = run_parallel(n, 4, 2)
    print(f"parallel4 time={time_run}result={result}")

    result, time_run = run_parallel(n, 2, 2)
    print(f"parallel2 time={time_run} result={result}")


if __name__ == '__main__':
    main()
