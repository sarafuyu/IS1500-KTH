/*
 print-prime.c
 Written by Lucas Lund, reviewed by Sara Rydell
 Last modified: 2022-09-20
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define COLUMNS 6
int columnnumber = 1; // global tracking number

int is_prime(int n){
    if(n == 1){
        return 0; // one is not a prime number
    }

    for(int i = 2; i < n; i++){ // if n = 2 one will be returned now
        int rest = n % i; // calculates the remainder
        if(rest == 0){ // if the remainder is 0 the number is divisible, the number is not prime
            return 0;
            break;
        }
    }
    return 1; // else the number is prime
}

void print_number(int number){
    printf("%10d ", number);
    if (columnnumber == COLUMNS) { // changes line if the row is full
        printf("\n");
        columnnumber = 1;
    }
    else {
        columnnumber++; // next number will be printed in the next column
    }
}

void print_primes(int n){
    for(int i = 2; i < n; i++){
        if(is_prime(i)){
            print_number(i);
        }
    }
}

// 'argc' contains the number of program arguments, and
// 'argv' is an array of char pointers, where each
// char pointer points to a null-terminated string.
int main(int argc, char *argv[]){
    clock_t tic = clock(); // starting timer
  if(argc == 2)
    print_primes(atoi(argv[1]));
  else
    printf("Please state an interger number.\n");
    clock_t toc = clock(); //ending timer
    printf("\nTime elapsed: %f seconds\n", (double)(toc - tic) / CLOCKS_PER_SEC); // printing time
  return 0;
}

// within 2 seconds of computation: n = 131000 -> p = 130987
// within 10 seconds of computation: n = 307000 -> p = 306991
