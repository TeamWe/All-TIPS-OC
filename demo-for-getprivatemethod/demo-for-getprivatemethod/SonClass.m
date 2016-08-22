//
//  SonClass.m
//  demo-for-getprivatemethod
//
//  Created by 徐纪光 on 16/7/29.
//  Copyright © 2016年 jiguang. All rights reserved.
//

#import "SonClass.h"

@implementation SonClass
- (void)sonPerform{
    [self performSelector:@selector(hiddenInstanceMethod) withObject:self];
}
@end
