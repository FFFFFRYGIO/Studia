#include <stdio.h>

__global__ void initWith(float num, float *xx, int N)
{
  // for(int i = 0; i < N; ++i)
  // {
  //   a[i] = num;
  // }
  int gid = threadIdx.x + blockIdx.x * blockDim.x;
  xx[gid] = num;
}

__global__ void addVectorsInto(float *result, float *a, float *b, int N)
{
  // for(int i = 0; i < N; ++i)
  // {
  //   result[i] = a[i] + b[i];
  // }
  int gid = threadIdx.x + blockIdx.x * blockDim.x;
  if (gid < N) {
    result[gid] = a[gid] + b[gid];
  }
}

void checkElementsAre(float target, float *array, int N)
{
  for(int i = 0; i < N; i++)
  {
    if(array[i] != target)
    {
      printf("FAIL: array[%d] - %0.0f does not equal %0.0f\n", i, array[i], target);
      exit(1);
    }
  }
  printf("SUCCESS! All values added correctly.\n");
}

/* async attempt
__global__ void checkElementsAre(float target, float *array, int N)
{
  // for(int i = 0; i < N; i++)
  // {
  //   if(array[i] != target)
  //   {
  //     printf("FAIL: array[%d] - %0.0f does not equal %0.0f\n", i, array[i], target);
  //     exit(1);
  //   }
  // }
  int gid = threadIdx.x + blockIdx.x * blockDim.x;
  if(array[gid] != target)
    {
      printf("FAIL: array[%d] - %0.0f does not equal %0.0f\n", gid, array[gid], target);
      // exit(1);  // an analogous instruction is needed to terminate GPU operations
    }
  
  // printf("SUCCESS! All values added correctly.\n");
}
*/


int main()
{
  const int N = 2<<20;
  size_t size = N * sizeof(float);

  float *a;
  float *b;
  float *c;

  cudaError_t err;
  err = cudaMallocManaged(&a, N);

  // a = (float *)malloc(size);
  // b = (float *)malloc(size);
  // c = (float *)malloc(size);

  cudaMallocManaged(&a, size);
  cudaMallocManaged(&b, size);
  cudaMallocManaged(&c, size);

  err = cudaGetLastError();
  if (err != cudaSuccess)                           // `cudaSuccess` is provided by CUDA.
  {
    printf("1 Error: %s\n", cudaGetErrorString(err)); // `cudaGetErrorString` is provided by CUDA.
  }

  size_t threads_per_block = 1024;
  size_t number_of_blocks = (N + threads_per_block - 1) / threads_per_block;;

  // initWith(3, a, N);
  // initWith(4, b, N);
  // initWith(0, c, N);

  initWith<<<number_of_blocks, threads_per_block>>>(3, a, N);
  initWith<<<number_of_blocks, threads_per_block>>>(4, b, N);
  initWith<<<number_of_blocks, threads_per_block>>>(0, c, N);

  err = cudaGetLastError();
  if (err != cudaSuccess)                           // `cudaSuccess` is provided by CUDA.
  {
    printf("2 Error: %s\n", cudaGetErrorString(err)); // `cudaGetErrorString` is provided by CUDA.
  }

  // addVectorsInto(c, a, b, N);
  addVectorsInto<<<number_of_blocks, threads_per_block>>>(c, a, b, N);
  cudaDeviceSynchronize();

  err = cudaGetLastError();
  if (err != cudaSuccess)                           // `cudaSuccess` is provided by CUDA.
  {
    printf("3 Error: %s\n", cudaGetErrorString(err)); // `cudaGetErrorString` is provided by CUDA.
  }

  checkElementsAre(7, c, N);

  /* async attempt
  checkElementsAre<<<number_of_blocks, threads_per_block>>>(7, c, N);
  printf("SUCCESS! All values added correctly.\n");
  */

  cudaFree(a);
  cudaFree(b);
  cudaFree(c);

  err = cudaGetLastError();
  if (err != cudaSuccess)                           // `cudaSuccess` is provided by CUDA.
  {
    printf("4 Error: %s\n", cudaGetErrorString(err)); // `cudaGetErrorString` is provided by CUDA.
  }
}
