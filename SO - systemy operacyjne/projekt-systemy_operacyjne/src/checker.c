#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

int hex_to_int(char c){
	int first = c / 16 - 3;
	int second = c % 16;
	int result = first*10 + second;
	if(result > 9) result--;
	return result;
}

int hex_to_ascii(char c, char d){
	int high = hex_to_int(c) * 16;
	int low = hex_to_int(d);
	return high+low;
}

int main(int argc, char *argv[]){
	printf("\nChecker process (PID%c: %d)\n", 'c', getpid());
	printf("Capturing hex characters and converting them back");
	FILE *file;
	if ((file=fopen("data/output.txt", "r"))==NULL) {
		printf("Can't open file!\n");
		exit(1);
    }
    char *line = NULL;
    size_t lineL = 1;
    ssize_t lineS = 1;
    while(lineS >= 0){
		lineS = getline(&line, &lineL, file);
		printf("\nCaptured character: %s", line);
		printf("This character in ASCII is: %c", hex_to_ascii(line[2], line[3]));
	}
	printf("\nAll characters converted\n");
	exit(0);
	return 0;
}
