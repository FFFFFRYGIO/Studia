#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>

int main(int argc, char* argv[]){
    FILE *input, *output;
    printf("START");
    if(argc!=2){
        fprintf(stderr, "Wrong number of arguments\n");
        return 1;
    }
    if((input = fopen("/etc/passwd","r")) == NULL){
        fprintf(stderr, "Can't open file /etc/passwd\n");
        return 1;
    }
    if((output = fopen(argv[1],"w")) == NULL){
        fprintf(stderr, "Can't open file %s\n", argv[1]);
        return 1;
    }
    char uinfo[200], *p;
    int i=1;
    while(fgets(uinfo,200,input)!=NULL){
        p = strtok(uinfo,":");
        while (p!=NULL){
            printf("%d. ", i);
            fprintf(output,"%d. ",i++);
            int n=0;
            while(n<7){
                if(n==0){
                    printf("Name: %s | ",p);
                    fprintf(output,"Name: %s | ",p);
                }
                else if(n==2){
                    printf("UID: %s | ",p);
                    fprintf(output,"UID: %s | ",p);
                }
                else if(n==5){
                    printf("Dir: %s\n",p);
                    fprintf(output,"Dir: %s\n",p);
                }
                n++;
                p=strtok(NULL,":");
            }
        }
    }
    fclose(input);
    fprintf(output,"Author: xxxxx");
    fclose(output);
    return 1;
}
