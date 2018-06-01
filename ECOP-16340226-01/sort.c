#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
int main()
{
    uint32_t num = 10 ;
    uint32_t *arr = malloc(sizeof(uint32_t)*num);
    printf("Please input:");
    printf("%u",num);
    printf(" unsigned integer, with one integer in one line:\n");
    for(uint32_t i = 0 ; i < num ; i ++ )
    {
        scanf("%u",&arr[i] );
    }
    for(uint32_t i = 0 ; i < num ; i ++ )
    {    
        uint32_t max = i ;
        for( uint32_t j = i + 1 ; j < num ; j ++ )
        {
            if(arr[j] > arr[max])
            {
                max = j ;
            }
        }
        uint32_t temp = arr[i] ;
        arr[i] = arr[max];
        arr[max] = temp ;
    }
    printf("Result: ");
    for(uint32_t i = 0 ; i < num ; i ++ )
    {
        printf(" ");
        printf("%u",arr[i]);
    }
    printf("\n");
    free(arr);
}