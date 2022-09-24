/*
 pointers.c
 Written by Sara Rydell, reviewed by Lucas Lund.
 Last modified: 2022-09-21
*/

#include <stdio.h>

static void copycodes(char *text, int *list, int *count);

char* text1 = "This is a string.";
char* text2 = "Yet another thing.";

// added global variables
int list1[20];
int list2[20];
int count = 0;

void printlist(const int* lst){
  printf("ASCII codes and corresponding characters.\n");
  while(*lst != 0){
    printf("0x%03X '%c' ", *lst, (char)*lst);
    lst++;
  }
  printf("\n");
}

void endian_proof(const char* c){
  printf("\nEndian experiment: 0x%02x,0x%02x,0x%02x,0x%02x\n",
         (int)*c,(int)*(c+1), (int)*(c+2), (int)*(c+3));
}

void work(){
    copycodes(text1, list1, &count); // lines 35-38
    copycodes(text2, list2, &count); // lines 40-43
}

void copycodes(char *text, int *list, int *count){
    *list=*text; // lb $t0,0($a0)
    while(*text !=0){ // beq $t0,$0,done
        text = text + 1;
        list = list + 1;
        *count = *count + 1;
        *list = *text;
    }
}

int main(void){
  work();

  printf("\nlist1: ");
  printlist(list1);
  printf("\nlist2: ");
  printlist(list2);
  printf("\nCount = %d\n", count);

  endian_proof((char*) &count);
}
