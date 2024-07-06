#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/sem.h>

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

int main(int argc, char *argv[]){
	printf("First process (PID%d: %d)\n", 1, getpid());
	
	//Capturing PIPE
	int pdes[2] = {atoi(argv[1]), atoi(argv[2])};
	close(pdes[0]);
	//Capturing shared memory
	int semID = atoi(argv[3]);
	int shmID = atoi(argv[4]);
  
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
  
	//Loading characters
	char in[1];
	while(1){
		if(!stop_working){
			//printf("P1: Input character ");
			scanf("%c", in);
			//printf("\n");
		}
		write(pdes[1], in, sizeof(in));
	}

	return 0;
}
