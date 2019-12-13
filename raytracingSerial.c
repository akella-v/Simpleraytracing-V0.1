#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

int W = 1000; /*****canvas Width*****/
int H = 1000; /*****canvas Height*****/

int b_filter[5][5] = {{1,1,1,1,1},{1,2,2,2,1},{1,2,3,2,1},{1,2,2,2,1},{1,1,1,1,1}};

struct vector {
    int x,y;
};

struct ray {
    struct vector origin;
    struct vector dest;
};



///////////////////////////////////// FUNCTIONS CODE //////////////////////////////////////// 
int canvas_init (int canvas[H][W]){
    int x,y;
    //for each pixel
    //initializing the canvas to be black
    for(int y =0; y < H; y++){
        for(x = 0; x < W; x++){
            canvas[y][x] = 0;
        }
    }
}


int circle(int x, int y ,int canvas[H][W]){
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


int brightness(int a, int b, int canvas[H][W]){
    if(canvas[a][b] <= 250)
    canvas[a][b] = 249;    
    int i,j;
    /*for( i = 0; i <4; i++){
        for(j = 0; j< 4; j++){
            if(canvas[a-2+i][b-2+i] <= 250)
            canvas[a-2+i][b-2+i] = canvas[a-2+i][b-2+i] + 50;
            //canvas[a-2+i][b-2+i] = b_filter[i][i]*canvas[a][b]/b_filter[3][3];
        }
    }*/
}



int raytracing (struct ray temp_ray, int canvas[H][W]){
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
              if(canvas[a][b] < 50) //if u want the ray to be visible
              canvas[a][b] =+ 50;
              for(int i = 0; i<9; i++){
                  for(int j = 0; j<9; j++){
                  if(canvas[a -4 +j][b -4 + i] > 100)
                  brightness(a -4 + j, b -4 + i, canvas);
                  }
              }
          }

      }    
  }  
  /////////////////////////////////////////////////////////  
}




int printcanvas (int canvas[H][W]){
    int x,y;
    //for each pixel
    for(int y =0; y < H; y++){
      for(x = 0; x < W; x++){
          //priting the image
          printf("%d, ",canvas[x][y]);
      }
      printf("\n");
    }
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
  //test case for checking the rays
  /*for(int z = 0; z < 5; z++){
      printf("%d", ray[z].origin.x  );
      printf("%d", ray[z].origin.y  );
      printf("%d", ray[z].dest.x );
      printf("%d",ray[z].dest.y  );
      printf("\n");
  }  */
  
  
  //initializing the canvas to be black
  canvas_init(canvas);
  
  ///creating circles on the canvas

  for(int i = 0; i <100; i++){
      int number = rand()% H;
      int number2 = rand()% H;
      circle (number + 1,number2,canvas);
  }


  //raytracing
  for(int z = 0;z < 10; z++){ ///loop for multiple rays
      raytracing (ray[z],canvas);
  }

  
  
  //printing the canvas
  printcanvas (canvas);

  
}