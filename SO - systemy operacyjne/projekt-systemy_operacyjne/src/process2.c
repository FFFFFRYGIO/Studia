#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <errno.h>

int stop_working = 0;

//F ending app
void end(int x){
	kill(getppid(), SIGTRAP);
};

//F stopping app
void stop_program(int x){
	if(!stop_working)
		kill(getppid(), SIGSTOP);
	return;
};

//F resuming app
void resume_program(int x){
	if (stop_working){
		stop_working = 0;
		kill(getppid(), SIGCONT);
	}
	return;
};

//Defining shared memory buffer
struct sembuf buffer;
void bufSET(int semID, int n, int o){
	buffer.sem_num = n;
	buffer.sem_op = o;
	buffer.sem_flg = 0;
	while((semop(semID, &buffer, 1) == -1)){
		if(errno != EINTR)
			perror("sem value error\n");
	};
};

int main(int argc, char *argv[]){
	printf("Second process (PID%d: %d)\n", 2, getpid());
	
	//Capturing PIPE
	int pdes[2] = {atoi(argv[1]), atoi(argv[2])};
	close(pdes[1]);
	//Capturing shared memory
	int semID = atoi(argv[3]);
	int shmID = atoi(argv[4]);
		//Connecting to shared memory
	char *buffer = shmat(shmID, NULL, 0);
	
	//Signals handling
	sigset_t mask;
	sigfillset(&mask);
	sigdelset(&mask, SIGINT);
	sigdelset(&mask, SIGTRAP);
	sigdelset(&mask, SIGSTOP);
	sigdelset(&mask, SIGCONT);
	sigprocmask(SIG_SETMASK, &mask, NULL);
	signal(SIGTRAP, end);
	signal(SIGSTOP, stop_program);
	signal(SIGCONT, resume_program);
	
	//Converting characters
	char out[1];
	while(1){
		if(stop_working) continue; //Dont load if stopped
		read(pdes[0], out, sizeof(out)); //Load
		if (out[0] == '\n') continue; //Dont load simple newline
		bufSET(semID, 0, -1);
		if(!stop_working){
			printf("P1: received %c\n", out[0]);
			printf("P2: converted %c to 0x%02X\n", out[0], out[0]);
		}
		sprintf(buffer, "0x%02X", out[0]);
		bufSET(semID, 1, 1);
	};
	return 0;
}
