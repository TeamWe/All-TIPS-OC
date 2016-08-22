//
//  SomeClass.m
//  demo-for-getprivatemethod
//
//  Created by 徐纪光 on 16/7/29.
//  Copyright © 2016年 jiguang. All rights reserved.
//

#import "SomeClass.h"


@implementation SomeClass
-(void) msg
{
    printf("Inside msg()...\n");
    
    [self hiddenInstanceMethod];
    [SomeClass hiddenClassMethod];
}

+(void) classMsg
{
    printf("Inside classMsg()...\n");
}

+(void) hiddenClassMethod
{
    printf( "Hidden class method.\n" );
}

-(void) hiddenInstanceMethod
{
    printf( "Hidden instance method\n" );
}
@end
