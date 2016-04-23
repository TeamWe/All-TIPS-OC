//
//  UIAlertView+block.m
//  demo-for-alert
//
//  Created by 谭嘉麒 on 16/4/23.
//  Copyright © 2016年 谭嘉麒. All rights reserved.
//

#import "UIAlertView+block.h"
#import <objc/runtime.h>
#import <objc/message.h>


@interface UIAlertView ()<UIAlertViewDelegate>

@end
@implementation UIAlertView (block)

- (void)setBlock:(JGAlertBlock)block{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.delegate = self;
}

- (JGAlertBlock)block{
    return objc_getAssociatedObject(self, @selector(block));
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(self.block)
        self.block(alertView,buttonIndex);
}

@end
