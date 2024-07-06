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
#include <pthread.h>

#define steps 14
pthread_mutex_t mt1, mt2, mtp;
pthread_t t1, t2, tp;
int i=1;
char c[1];

void *Threadp(void* v){ //Producent thread
    while(i < steps){
        pthread_mutex_lock(&mtp); //Lock p if available
        c[0] = 'A' + (random() % 26);
        printf("Thread p - step: %d\t Drawn character %c\n", i, c[0]);
        i++;
        pthread_mutex_unlock(&mt2); //Unlocking 2
    }
    //printf("End of thread p\n");
    pthread_exit(0);
}

void *Thread1(void* v){ //Consument 1 thread
    while(i < steps){
        pthread_mutex_lock(&mt1); //Lock 1 if available
        printf("Thread 1 - step: %d\t Imported character %c\n", i, c[0]);
        i++;
        pthread_mutex_unlock(&mtp); //Unlocking p
    }
    //printf("End of thread 1\n");
    pthread_exit(0);
}

void *Thread2(void* v){ //Consument 2 thread
    while(i < steps){
        pthread_mutex_lock(&mt2); //Lock 2 if available
        printf("Thread 2 - step: %d\t Imported character %c\n", i, c[0]);
        i++;
        pthread_mutex_unlock(&mt1); //Unlocking 1
    }
    //printf("End of thread 2\n");
    pthread_exit(0);
}

int main(){
    srand(time(NULL));
    printf("Inicjalizing threads\n");
    pthread_mutex_init(&mtp, NULL);
    pthread_mutex_init(&mt1, NULL);
    pthread_mutex_init(&mt2, NULL);
    printf("Locking mutex 1 and 2\n");
    pthread_mutex_lock(&mt1);
    pthread_mutex_lock(&mt2);
    printf("Calling threads\n");
    pthread_create(&tp, NULL, Threadp, NULL);
    pthread_create(&t1, NULL, Thread1, NULL);
    pthread_create(&t2, NULL, Thread2, NULL);
    printf("Waiting for threads to finish\n");
    pthread_join(tp, NULL);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    printf("Deleting threads from memory\n");
    pthread_mutex_destroy(&mtp);
    pthread_mutex_destroy(&mt1);
    pthread_mutex_destroy(&mt2);
    printf("End\n");
    return 0;
}
