#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/msg.h>
#include <sys/sem.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <time.h>
#include <signal.h>

struct sembuf bufor;

void setSem(int semid, int semnum, int opt) {
  bufor.sem_num = semnum;
  bufor.sem_op = opt;
  bufor.sem_flg = 0;
  if (semop(semid, &bufor, 1) == -1) {
    perror("Error with semaphore value\n");
    exit(1);
  }
};

int main() {
  printf("K1 start\n\n");
  int semid = semget(45287, 3, IPC_CREAT|0600);
  if (semid == -1) {
    perror("Error with semaphore table connection\n");
    exit(1);
  }
  int shmid = shmget(45286, sizeof(char), IPC_CREAT|0600);
  if (shmid == -1) {
    perror("Error with connecting shared memory\n");
    exit(1);
  }
  char *bufor = shmat(shmid, NULL, 0);
  if (bufor == NULL) {
    perror("Error with joining a shared memory segment\n");
    exit(1);
  }
  while (1) {
    setSem(semid, 1, -1);
    sleep(1);
    printf("K1 - received value: %s\n", bufor);
    setSem(semid, 0, 1);
  }
  return 0;
};
