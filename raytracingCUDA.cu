#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include<cuda_profiler_api.h>


#define W  1200 /*****canvas Width*****/
#define H 1200 /*****canvas Height*****/
int C[100000], address[100000][2]; //buffers to store data for CUDA application
int count = 0;

struct vector {
    int x,y;
};

struct ray {
    struct vector origin;
    struct vector dest;
};



///////////////////////////////////// FUNCTIONS CODE ////////////////////////////////////////
void canvas_init (int canvas[H][W]){
    int x,y;

    //for each pixel
    //initializing the canvas to be black
    for( y =0; y < H; y++){
        for(x = 0; x < W; x++){
            canvas[y][x] = 0;
        }
    }

}


void circle(int x, int y ,int canvas[H][W]){
    // creates a circle on the blank canvas with a radius of 9 pixels
    int garbage = 0;
    if ( ((x - 9)<=0) || ((x + 9)>= W) )
    garbage =+ 1;//printf("Circle will not fit the width for given (%d,%d) coordinates",x,y);
    else
    {
        if( ((y - 9)<=0) || ((y + 9)>= H) )
        garbage = 0;//printf("Circle will not fit the Height for given (%d,%d) coordinates",x,y);
        else
        {
            //half circle to the right 0 to 90
            canvas[y][x+9] = 150;
            canvas[y-1][x+9] = 150;
            canvas[y-2][x+9] = 150;
            canvas[y-3][x+9-1] = 150;
            canvas[y-4][x+9-1] = 150;
            canvas[y-5][x+9-2] = 150;
            canvas[y-6][x+9-2] = 150;
            canvas[y-6][x+9-3] = 150;
            canvas[y-7][x+9-3] = 150;
            canvas[y-7][x+9-4] = 150;
            canvas[y-8][x+9-5] = 150;
            canvas[y-8][x+9-6] = 150;
            canvas[y-9][x+9-7] = 150;
            canvas[y-9][x+9-8] = 150;
            canvas[y-9][x] = 150;
            //////////////////////////////

            //half circle to the left 90 to 180
            canvas[y][x+9] = 150;
            canvas[y+1][x+9] = 150;
            canvas[y+2][x+9] = 150;
            canvas[y+3][x+9-1] = 150;
            canvas[y+4][x+9-1] = 150;
            canvas[y+5][x+9-2] = 150;
            canvas[y+6][x+9-2] = 150;
            canvas[y+6][x+9-3] = 150;
            canvas[y+7][x+9-3] = 150;
            canvas[y+7][x+9-4] = 150;
            canvas[y+8][x+9-5] = 150;
            canvas[y+8][x+9-6] = 150;
            canvas[y+9][x+9-7] = 150;
            canvas[y+9][x+9-8] = 150;
            canvas[y+9][x] = 150;
            //////////////////////////////

            //half circle to the left 270 to 360
            canvas[y][x-9] = 150;
            canvas[y-1][x-9] = 150;
            canvas[y-2][x-9] = 150;
            canvas[y-3][x-9+1] = 150;
            canvas[y-4][x-9+1] = 150;
            canvas[y-5][x-9+2] = 150;
            canvas[y-6][x-9+2] = 150;
            canvas[y-6][x-9+3] = 150;
            canvas[y-7][x-9+3] = 150;
            canvas[y-7][x-9+4] = 150;
            canvas[y-8][x-9+5] = 150;
            canvas[y-8][x-9+6] = 150;
            canvas[y-9][x-9+7] = 150;
            canvas[y-9][x-9+8] = 150;
            canvas[y-9][x] = 150;
            //////////////////////////////

            //half circle to the left 180 to 270
            canvas[y][x-9] = 150;
            canvas[y+1][x-9] = 150;
            canvas[y+2][x-9] = 150;
            canvas[y+3][x-9+1] = 150;
            canvas[y+4][x-9+1] = 150;
            canvas[y+5][x-9+2] = 150;
            canvas[y+6][x-9+2] = 150;
            canvas[y+6][x-9+3] = 150;
            canvas[y+7][x-9+3] = 150;
            canvas[y+7][x-9+4] = 150;
            canvas[y+8][x-9+5] = 150;
            canvas[y+8][x-9+6] = 150;
            canvas[y+9][x-9+7] = 150;
            canvas[y+9][x-9+8] = 150;
            canvas[y+9][x] = 150;
            //////////////////////////////
        }
    }
}


void brightness(int a, int b, int canvas[H][W]){
    if(canvas[a][b] <= 250){
        C[count] = canvas[a][b]; address[count][0] = a; address [count][1] = b;count++;
    }
}



void raytracing (struct ray temp_ray, int canvas[H][W]){
  //creating a equation
  int a,b;

  for(a = 0;a < H; a++){
      for(b = 0; b < W; b++){

          //detection of intersection
          // (y - y1) = m(x - x1)
          // m =(y2 - y1)/(x2 -x1)
          /////////////////////////
          int line_equation;
          //check for other points beside them
          line_equation = (temp_ray.dest.y - temp_ray.origin.y)*(b - temp_ray.origin.x)-(temp_ray.dest.x - temp_ray.origin.x)* (a - temp_ray.origin.y);

          if(line_equation == 0)
          {
              /*if(canvas[a][b] < 50) //if u want the ray to be visible
              canvas[a][b] =+ 50;*/
              for(int i = 0; i<9; i++){
                  for(int j = 0; j<9; j++){
                  if(canvas[a -4 +j][b -4 + i] > 100)
                  brightness(a -4 + j, b -4 + i, canvas);
                  }
              }
          }

      }
  }
  ///////////////////////////////////////////////////////////////////////////////////////
}




void printcanvas (int canvas[H][W]){
    int x,y;
    //for each pixel
    for( y =0; y < H; y++){
      for(x = 0; x < W; x++){
          //priting the image
          printf("%d, ",canvas[x][y]);
      }
      printf("\n");
    }
}

///////////// Forward declaration of the device multiplication function/////////////////////
__global__ void VectorAddCuda(int*, int);



__global__ void VectorAddCuda(int* C, int width)
{
 // Block index
int bx = blockIdx.x;
 // Thread index
int tx = threadIdx.x;
 // Index of the vector  processed by the block

int index = bx*blockDim.x + tx;

 // each thread adds corresponding  elements  matrix C
 C[index] = C[index] + 100;

}




///////////////////////////////////// MAIN CODE ////////////////////////////////////////
int main (int argc, char *argv[]){

  //parameters initialization
  int canvas[H][W];
  srand(time(0));
  struct ray ray[10]; //for creating a ray out of two points origin and dest
      ray[0].origin.x = H;
      ray[0].origin.y = H;
      ray[0].dest.x = 0;
      ray[0].dest.y = 0;
  for(int z = 1; z <10; z++)
  {
      ray[z].origin.x = H - z*100;
      ray[z].origin.y = H;
      ray[z].dest.x = z*100;
      ray[z].dest.y = 0;
  }

  //initializing the canvas to be black
  canvas_init(canvas);

  ///creating circles on the canvas

  for(int i = 0; i <200; i++){
      int number = rand()% H;
      int number2 = rand()% H;
      circle (number + 1,number2,canvas);
  }


  //raytracing
  for(int z = 0;z < 10; z++){ ///loop for multiple rays
      raytracing (ray[z],canvas);
  }
/////////////////////////////////////////////////////////CUDA PART OF THE PROGRAM//////////////////////////////////
  //incase you want to see manual timestamps then remove //*** after here and comment out the printcanvas at the end.//

int N = count;
int Cserial[N];
// initialize the input matrices

srand(time(NULL));   // Initialization, should only be called once.


clock_t before_init = clock();
for (int i = 0; i < N; i++){
	Cserial[i] = C[i];
}

clock_t after_init = clock();

int width = N;


cudaProfilerStart();
int size=width*sizeof(int);
 // Allocate device memory for  C matrix
int* d_C;
cudaError_t err = cudaMalloc((void**)&d_C, size);
//***printf("CUDA malloc d_C: %s\n",cudaGetErrorString(err));


 // Copy Matrix data from host memory to device memory
cudaEvent_t start_memcpyh2d,stop_memcpyh2d;
cudaEventCreate(&start_memcpyh2d);
cudaEventCreate(&stop_memcpyh2d);

cudaEventRecord(start_memcpyh2d);
err = cudaMemcpy(d_C, C, size, cudaMemcpyHostToDevice);
//***printf("CUDA Memcpy C->Cd: %s\n",cudaGetErrorString(err));
cudaEventRecord(stop_memcpyh2d);
float ms1 = 0;

cudaEventElapsedTime(&ms1,start_memcpyh2d,stop_memcpyh2d);

//***printf("Time of the MEMCPY of %d bytes: %2.3f ms\n",size,ms1);


cudaEvent_t start_kernel,stop_kernel;
cudaEventCreate(&start_kernel);
cudaEventCreate(&stop_kernel);
// Specify the execution configuration

//dim3 dimBlock(,);
//dim3 dimGrid(,);

// Launch the CUDA kernel on the device


cudaEventRecord(start_kernel);
VectorAddCuda<<<N/1000, 1000>>>(d_C,width);
cudaEventRecord(stop_kernel);
cudaError_t errk = cudaDeviceSynchronize();
cudaEventSynchronize(stop_kernel);


//***printf("CUDA kernel launch: %s\n",cudaGetErrorString(errk));
 // Read C from the device
cudaEvent_t start_memcpyd2h,stop_memcpyd2h;
cudaEventCreate(&start_memcpyd2h);
cudaEventCreate(&stop_memcpyd2h);
cudaEventRecord(start_memcpyd2h);
err = cudaMemcpy(&C, d_C, size, cudaMemcpyDeviceToHost);
cudaEventRecord(stop_memcpyd2h);
//***printf("CUDA Memcpy d_C->C: %s\n",cudaGetErrorString(err));
float ms2 = 0;
cudaEventElapsedTime(&ms2,start_memcpyd2h,stop_memcpyd2h);
//***printf("Time of the MEMCPY of %d bytes : %2.3f ms\n",size,ms2);
 // Free device memory
cudaFree(d_C);

float milliseconds = 0;
cudaEventElapsedTime(&milliseconds,start_kernel,stop_kernel);
//***printf("Time to complete CUDA Vector addition kernel of %d size: %2.3f ms\n",width,milliseconds);

cudaProfilerStop();

clock_t before_serial = clock();
for (int k=0; k < N; k++) {
	Cserial[k] += 50;
}


clock_t after_serial = clock();

float serial_totaltime = ((after_serial-before_serial)*1000)/CLOCKS_PER_SEC;
float speedup = serial_totaltime/milliseconds;
//***printf("Execution time for initialization(msec) = %d\n",(((after_init-before_init)*1000)/CLOCKS_PER_SEC));
//***printf("Execution time for CUDA Vector addition(msec)= %2.3f\n",milliseconds);
//***printf("Execution time for serial execution(msec)  %d\n",(((after_serial-after_init)*1000)/CLOCKS_PER_SEC));
//***printf("Speedup obtained by CUDA for %d size Vector addition: %f\n",N,speedup);
//***printf("Ccount = %d, address[count][1] = %d \n", count, address[count][1]);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



  //printing the canvas

  for(count;count>=0;count--){
  canvas[address[count][0]][address[count][1]] =+ 100;
  }

  printcanvas (canvas);

  return 0;
}
