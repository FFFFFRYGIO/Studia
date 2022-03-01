#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <string.h>
#include <errno.h>

#define STREAM_SIZE 120

struct mymsgbuf {
  pid_t mtype;
  char value[STREAM_SIZE];
} queue;

struct mymsgbuf readbuffer;

int main (void) {
  int qid;
  key_t msgkey = ftok(".", 'm');
  if ((qid = msgget(msgkey, IPC_CREAT | 0660)) == -1) {
     fprintf(stderr, "Failed to open message queue\n");
     exit(EXIT_FAILURE);
  }
  readbuffer.mtype = getpid();
  while (msgrcv(qid, &readbuffer, sizeof(struct mymsgbuf) - sizeof(pid_t), readbuffer.mtype, IPC_NOWAIT) != -1) {
    printf("[K3] Odczytano: %s", readbuffer.value);
    sleep(1);
  };
  return EXIT_SUCCESS;
};
