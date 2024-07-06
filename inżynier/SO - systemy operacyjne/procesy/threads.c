#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
void* square(void* x)
{
    int *num = (int *)x;
    int num2=(int)num*(int)num;
    void* result=(int *)num2;
    pthread_exit(result);
}

int main(int argc, char* argv[])
{
    int params[3]={atoi(argv[1]), atoi(argv[2]), atoi(argv[3])};
    void * result[3];
    int n=3, i;
    pthread_t thread_id[3];

    //Calling threads
    for(i=0;i<n;i++)
        pthread_create(&thread_id[i], 0, &square, (void *)params[i]);

    //Running threads
    for(i=0;i<n;i++)
        pthread_join(thread_id[i], &result[i]);

    //Printing threads results
    printf("\n");
    for(i=0;i<n;i++){
        printf("Thread %d\n",i+1);
    printf("\tSquare of %d equals %d\n", (int)params[i],(int)result[i]);
    }

    //Answear
    int squares_sum = 0;
    for(i=0;i<n;i++)
    squares_sum=squares_sum+(int)result[i];
    printf("\nSum of squares equals %d\n\n", squares_sum);

    return 0;
}
