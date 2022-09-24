/*
 sieves-heap.c
 Written by Lucas Lund, reviewed by Sara Rydell.
 Last modified: 2022-09-20
*/

#include <stdio.h>
#include <stdlib.h>

#define COLUMNS 6
int columnnumber = 1; // global tracking number

int distancesincelast = 0; // has to go through 0 and 1 first
float totaldistance = 0; // total distance
int primenumbers = 0; // number of prime numbers

int print_number(int number){
    printf("%10d ", number);
    if(columnnumber == COLUMNS){ // changes line if the row is full
        printf("\n");
        columnnumber = 1;
    }
    else {
        columnnumber++; // next number will be printed in the next column
    }
}

void print_sieves(int n){
    int *allnumbers;
    allnumbers = malloc(sizeof(int) * n);
    for(int i = 0; i <= n; i++){ // creates array elements
        allnumbers[i] = i;
    }
    allnumbers[1] = 0; // base case one
    for(int j = 0; j*j < n; j++){
        if(allnumbers[j] != 0){
            int multiple = j + j; // first multiple of prime
            while(multiple <= n){
                allnumbers[multiple] = 0;
                multiple = multiple + j;
            }
        }
    }
    for(int i = 2; i <= n; i++){ // Go through array extract non-zeros
        if(allnumbers[i]){
            print_number(allnumbers[i]);
            totaldistance = totaldistance + distancesincelast;
            primenumbers = primenumbers + 1;
            distancesincelast = 1;
        }
        else{
            distancesincelast = distancesincelast + 1;
        }
    }
    printf("\nTotal distance = %f\n",totaldistance);
    printf("Number of Primes = %d\n",primenumbers);
    printf("Therefore average distance = %f\n", totaldistance/primenumbers);
    free(allnumbers);
}

int main(int argc, char *argv[]){
    if(argc == 2)
        print_sieves(atoi(argv[1]));
    else
        printf("Please state an interger number.\n");
    return 0;
}
