#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <fcntl.h>
#include <dirent.h>
#include <sys/stat.h>
#include <string.h>

#define FIFO "my_fifo"
#define FIFO2 "my_fifo2"

int main(int argc, char **argv){
    FILE *input;
    FILE *out1, *out2;
    if(argc!=2){
        fprintf(stderr, "Wrong number of arguments, excpected: 2\n");
        return 1;
    }

    if((input=fopen(argv[1],"r")) == NULL){
        fprintf(stderr, "Can't open file \"%s\"\n", argv[1]);
        return 1;
    }
    
    if((out1=fopen("K1.txt","w"))==NULL){
        fprintf(stderr, "Can't open file \"K1.txt\"\n");
        return 1;
    }
    fclose(out1);
    if((out2=fopen("K2.txt","w"))==NULL){
        fprintf(stderr, "Can't open file \"K1.txt\"\n");
        return 1;
    }
    fclose(out2);
    
    umask(0);
    mkfifo(FIFO,0666);
    mkfifo(FIFO2,0666);
    char in[1], out[1];
    int fifo, fifo2, a, b, c, loop, i, l=1, k=0;

    if((a=fork())==0){
        printf("Parent process (PID: %d)\n", getpid());
        fifo=open(FIFO, O_WRONLY);
        fifo2=open(FIFO2, O_WRONLY);
        while(!feof(input)){
            if(feof(input))
                break;
            in[0]=getc(input);
            write(fifo, in, 1);
            write(fifo2, in, 1);
        }
        close(fifo);
        close(fifo2);
        unlink(FIFO);
        unlink(FIFO2);
    }
    else if((b=fork())==0){
        printf("Child process K1 (PID: %d)\n", getpid());
        fifo=open(FIFO, O_RDONLY);
        i=1;
        while(1){
            loop=read(fifo, out, 1);
            if((int)*out==-1)
                break;
            if(loop>0){
                out1=fopen("K1.txt","a");
                if(l){
                    fprintf(out1, "%d %c",i , *out);
                    l=0;
                    i++;
                }else fprintf(out1, "%c", *out);
                if(*out=='\n')
                    l=1;
                fclose(out1);
            }
        }
        close(fifo);
    }
    else if((c=fork())==0){
        printf("Child process K2 (PID: %d)\n", getpid());
        fifo2=open(FIFO2, O_RDONLY);
        i=1;
        l=1;
        while(1){
            loop=read(fifo2, out, 1);
            if((int)*out==-1)
                break;
            if(loop>0){
                k++;
                out2=fopen("K2.txt","a");
                if(l){
                    l=0;
                    i++;
                }else if(i%2!=0)
                    fprintf(out2, "%c", *out);
                if(*out=='\n') l=1;
                fclose(out2);
            }
        }
        out2=fopen("K2.txt","a");
        fprintf(out2, "Rows: %d\tChars: %d\n",i-1,k-(i-1));
        fclose(out2);
        close(fifo2);
    }
    fclose(input);
    return 0;
}
