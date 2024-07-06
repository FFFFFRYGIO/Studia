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
#include <string.h>

struct sembuf bufor;

void setSem(int semid, int semnum, int opt) {
  bufor.sem_num = semnum;
  bufor.sem_op = opt;
  bufor.sem_flg = 0;
  if (semop(semid, &bufor, 1) == -1) {
    perror("Error with semaphore update\n");
    exit(1);
  }
};

void validateSem(int v) {
  if (v == -1) {
    perror("Error with semaphore value");
    exit(1);
  }
};

int main() {
  pid_t k1, k2;
  if ((k1=fork()) == 0) { // K2
     execlp("./k2", "k2", (char *)NULL);
  } else if ((k2 = fork()) == 0) { // K1
     execlp("./k1", "k1", (char *)NULL);
  } else { // P
     int semid = semget(45287, 3, IPC_CREAT|0600);
     if (semid == -1) {
       perror("Error with creating semaphore table\n");
       exit(1);
     }
     validateSem(semctl(semid, 0, SETVAL, (int)1));
     validateSem(semctl(semid, 1, SETVAL, (int)0));
     validateSem(semctl(semid, 2, SETVAL, (int)0));
     int shmid = shmget(45286, sizeof(char), IPC_CREAT|0600);
     if (shmid == -1) {
       perror("Error with creating shared memory\n");
       exit(1);
     }
     char *bufor = shmat(shmid, NULL, 0);
     if (bufor == NULL) {
       perror("Error with joining a shared memory segment\n");
       exit(1);
     };
     char c[2];
     int i;
     for (i=0; i<10; i++) {
       setSem(semid, 0, -1);
       c[0] = 'A' + (random() % 26);
       c[1] = '\0';
       strcpy(bufor, c);
       printf("P1 - save value: %s\n", bufor);
       if(i!=0) printf("\n");
       setSem(semid, 2, 1);
     }
     sleep(3);
     kill(k1, SIGINT);
     kill(k2, SIGINT);
     shmdt(bufor);
     shmctl(shmid, IPC_RMID, NULL);
     semctl(semid, 1, IPC_RMID);
  }
  return 0;
};
