/*
 sieves.c
 Written by by Sara Rydell and Lucas Lund.
 Last modified: 2022-09-20
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define COLUMNS 6
int columnnumber = 1; // global tracking number

int print_number(int number){
    printf("%10d ", number);
    if (columnnumber == COLUMNS) { // changes line if the row is full
        printf("\n");
        columnnumber = 1;
    }
    else {
        columnnumber++; // next number will be printed in the next column
    }
}

void print_sieves(int n){
    int *numbers = (int*) malloc(sizeof(int) * n);
    for(int i = 0; i <= n; i++){ // creates array elements
        numbers[i]=i;
    }
    numbers[1]=0; // base case one
    for(int j = 0; j*j < n; j++){
        if(numbers[j] != 0){
            int multiple = j + j; // first multiple of prime
            while(multiple <= n){
                numbers[multiple] = 0;
                multiple = multiple + j;
            }
        }
    }
    for(int i = 0; i <= n; i++){
        if(numbers[i]){
            print_number(numbers[i]);
        }
    }
    free(numbers);
}

int main(int argc, char *argv[]){
    clock_t tic = clock(); // starting timer
  if(argc == 2)
    print_sieves(atoi(argv[1]));
  else
    printf("Please state an interger number.\n");
    clock_t toc = clock(); //ending timer
    printf("\nTime elapsed: %f seconds\n", (double)(toc - tic) / CLOCKS_PER_SEC); // printing time
  return 0;
}

//print-primes.c
// within 2 seconds of computation: n = 131000 -> p = 130987
// within 10 seconds of computation: n = 307000 -> p = 306991

// sieves.c
// gets following error
// Segmentation fault (core dumped)
// this is because implementing this would need more memory than available
// max value is between n = 2 090 000 and n= 2 099 000, taking approximately 0.1s

// sieves-heap.c
// within 2 seconds of computation: n = 2 3000 000 -> p = 22999993
// within 10 seconds of computation: n = 11 000 0000 -> p = 109999993
