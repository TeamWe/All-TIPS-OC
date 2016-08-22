//
//  main.m
//  demo-for-fatherandson
//
//  Created by 徐纪光 on 16/7/29.
//  Copyright © 2016年 jiguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGFather.h"
#import "JGSon.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        JGFather *f = [[JGFather alloc]init];
        [f printF];
        JGSon *s = [[JGSon alloc]init];
        [s printS];
        
    }
    return 0;
}
