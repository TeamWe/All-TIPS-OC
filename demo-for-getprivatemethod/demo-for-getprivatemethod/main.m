//
//  main.m
//  demo-for-getprivatemethod
//
//  Created by 徐纪光 on 16/7/29.
//  Copyright © 2016年 jiguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SomeClass+hidden.h"
#import "SonClass.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*1.调用私有方法通过category*/
        SomeClass *ptr = [[SomeClass alloc] init];

        [ptr InstanceMethod];
        
        /*1.调用私有方法通过继承*/
        SonClass *son = [[SonClass alloc]init];
        
        [son sonPerform];

    }
    return 0;
}
