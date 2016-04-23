//
//  UIAlertView+block.h
//  demo-for-alert
//
//  Created by 谭嘉麒 on 16/4/23.
//  Copyright © 2016年 谭嘉麒. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^JGAlertBlock)(UIAlertView *,NSUInteger);

@interface UIAlertView (block)
@property(nonatomic, copy)JGAlertBlock block;
@end
