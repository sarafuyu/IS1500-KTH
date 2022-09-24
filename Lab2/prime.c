/*
 prime.c
 Written by Sara Rydell, reviewed by Lucas Lund.
 Last modified: 2022-09-20
*/

#include <stdio.h>

int is_prime(int n){
    if(n == 1){
        return 0; // one is not a prime number
    }

    for(int i = 2; i < n; i++){ // if n = 2 one will be returned now
        int rest = n % i; // calculates the remainder
        if(rest == 0){ // if the remainder is 0 the number is not prime
            return 0;
            break;
        }
    }
    return 1; // else the number is prime
}

int main(void){
    // our tests
    //printf("%d\n", is_prime(1));    // 1 is not a prime.    Should print 0.
    //printf("%d\n", is_prime(2));    // 2 is a prime.        Should print 1.

    // given tests
    printf("%d\n", is_prime(11));   // 11 is a prime.       Should print 1.
    printf("%d\n", is_prime(383));  // 383 is a prime.      Should print 1.
    printf("%d\n", is_prime(987));  // 987 is not a prime.  Should print 0.
}
