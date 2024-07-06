#include<stdio.h>
#include<unistd.h>

int main(void)
{
    int x,y,z;
    char p[20];
    sprintf(p,"%d",getpid());

    printf("P0: %d PPID: %d\n", getpid(),getppid());

    if((x=fork())==0){
        printf("P1: %d PPID: %d\n", getpid(),getppid());
        if(fork()==0){
            printf("P1.1: %d PPID: %d\n", getpid(),getppid());
            if(fork()==0){
            printf("P1.1.1: %d PPID: %d\n", getpid(),getppid());
            }
        }

        else if(fork()==0){
            printf("P1.2: %d PPID: %d\n", getpid(),getppid());
            sleep(1);
            execlp("pstree","pstree","-cp",p,(char*)NULL);
        }
    }

    else if((y=fork())==0){
        printf("P2: %d PPID: %d\n", getpid(),getppid());
        if(fork()==0){
            printf("P2.1: %d PPID: %d\n", getpid(),getppid());
        }

        else if(fork()==0){
            printf("P2.2: %d PPID: %d\n", getpid(),getppid());
            if(fork()==0){
            printf("P2.2.1: %d PPID: %d\n", getpid(),getppid());
            }
        }
    }

    else if((z=fork())==0){
        printf("P3: %d PPID: %d\n", getpid(),getppid());
        if(fork()==0){
            printf("P3.1: %d PPID: %d\n", getpid(),getppid());
        }

        else if(fork()==0){
            printf("P3.2: %d PPID: %d\n", getpid(),getppid());
        }

        else if(fork()==0){
            printf("P3.2: %d PPID: %d\n", getpid(),getppid());
        }
    }
    pause();
    return 0;
}
