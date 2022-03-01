#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>

#define SHMID 11111
#define SEMID 22222
#define SEML 2

pid_t mPid, p1PID, p2PID, p3PID, pcPID;
int endprogram = 0;

//F ending app
void end_program(int x){
	endprogram = 1;
};

//F stopping app
void wstrzymaj(int x){
	kill(p1PID, SIGSTOP);
	kill(p2PID, SIGSTOP);
	kill(p3PID, SIGSTOP);
};

//F resuming app
void wznow(int x){
	kill(p1PID, SIGCONT);
	kill(p2PID, SIGCONT);
	kill(p3PID, SIGCONT);
};

int main(int argc, char *argv[]){
	printf("\nSTART\n");
	
	//PIPE
	printf("Creating PIPE\n");
	int pdes[2];
	char pdes_argv[2][10];
	pipe(pdes);
	sprintf(pdes_argv[0], "%d", pdes[0]);
	sprintf(pdes_argv[1], "%d", pdes[1]);
	
	//Shared memory
	printf("Creating shared memory\n");
	int semID, shmID;
	char shm_argv[2][10];
	semID = semget(SEMID, SEML, IPC_CREAT|0600);
	sprintf(shm_argv[0], "%d", semID);
	shmID = shmget(SHMID, 20*sizeof(char), IPC_CREAT|0600);
	sprintf(shm_argv[1], "%d", shmID);
	semctl(semID, 0, SETVAL, 1);
	semctl(semID, 1, SETVAL, 0);

	//Starting processes
	printf("Starting processes\n");
	if((p1PID = fork()) == 0){
		return execlp(
		"./apps/process1.exe", "process1", 
		pdes_argv[0], pdes_argv[1], 
		shm_argv[0], shm_argv[1], 
		argv[1], (char *)NULL
		);
	} 
	else if((p2PID = fork()) == 0){
		return execlp(
		"./apps/process2.exe", "process2", 
		pdes_argv[0], pdes_argv[1], 
		shm_argv[0], shm_argv[1], 
		(char *)NULL
		);
	}
	else if((p3PID = fork()) == 0){
		return execlp(
		"./apps/process3.exe", "process3", 
		pdes_argv[0], pdes_argv[1], 
		shm_argv[0], shm_argv[1], 
		(char *)NULL
		);
	}
	else{
		mPid = getpid();
		printf("Parent process (PID%c: %d)\n", 'm', mPid);
	}
	usleep(5000);
	//Handling signals
	printf("Creating signal handle mechanizm\n");
	sigset_t mask;
	sigfillset(&mask);
	sigdelset(&mask, SIGINT);
	sigdelset(&mask, SIGTRAP);
	sigdelset(&mask, SIGSTOP);
	sigdelset(&mask, SIGCONT);
	sigprocmask(SIG_SETMASK, &mask, NULL);
	signal(SIGINT, end_program);
	signal(SIGTRAP, end_program);
	signal(SIGSTOP, wstrzymaj);
	signal(SIGCONT, wznow);
	
	
	//Waiting for processes to end
	while(endprogram == 0);
	printf("\nEnd of work\n");
	kill(p1PID, SIGINT);
	kill(p2PID, SIGINT);
	kill(p3PID, SIGINT);
	semctl(semID, SEML, IPC_RMID);
	shmctl(shmID, IPC_RMID, NULL);
	
	//Starting a process to check correctness of data
	printf("Converting back data\n");
	if((pcPID = fork()) == 0){
		return execlp(
		"./apps/checker.exe", "checker", 
		pdes_argv[0], pdes_argv[1], 
		shm_argv[0], shm_argv[1], 
		argv[1], (char *)NULL
		);
	} 
	
	printf("FINISH\n\n");
	return 0;
};
