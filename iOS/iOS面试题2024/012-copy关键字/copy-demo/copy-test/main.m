//
//  main.m
//  copy-test
//
//  Created by 启业云03 on 2024/7/18.
//

#import <Foundation/Foundation.h>
#import "AA.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        AA *a = [[AA alloc] init];
        [a string_strong];
        [a string_copy];
    }
    return 0;
}
