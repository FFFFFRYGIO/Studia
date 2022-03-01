#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

int ppid0,pid01,pid02;
int b=1;

void SIGhandlerGET(int s){
	printf("\nI received input signal: %d\n",s);
	signal(s, SIG_IGN);
}

void SIGINThandlerSEND(int s){
	printf("\nI've send SIGTERM signal to parent process: %d\n",ppid0);
	kill(ppid0, SIGTERM);
}

void SIGTERMhandlerRECEIVE(int s){
	printf("\nParent process received SIGTERM signal\n", ppid0);
	kill(pid01, SIGKILL);
	kill(pid02, SIGKILL);
	b=0;
}

void SIGhandlerEND(int s){
	signal(s, SIG_IGN);
    b=0;
}

int main() {
	setbuf(stdout, NULL);
	ppid0=getpid();
    printf("PPID0: %d \n",ppid0);
    
	sigset_t m;
    sigemptyset(&m);
    sigaddset(&m, SIGILL);
    sigprocmask(SIG_SETMASK, &m, NULL);
    int i;
    if((pid01=fork())==0){
        printf("PID01: %d \n",getpid());
        sigemptyset(&m);
        sigprocmask(SIG_SETMASK, &m, NULL);
        while(b){
			for(i=1; i<=32; i++)
				signal(i*2, SIGhandlerGET);
			signal(SIGKILL, SIGhandlerEND);
		}
    }
	else
		if((pid02=fork())==0){
			printf("PID02: %d \n",getpid());
			sigemptyset(&m);
			sigprocmask(SIG_SETMASK, &m, NULL);
			while(b){
				printf(".");
				sleep(1);
				signal(SIGINT, SIGINThandlerSEND);
				signal(SIGKILL, SIGhandlerEND);
			}
    	}
    while(b)
		signal(SIGTERM, SIGTERMhandlerRECEIVE);
    return 0;
}
