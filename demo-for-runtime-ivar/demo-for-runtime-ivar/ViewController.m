//
//  ViewController.m
//  demo-for-runtime-ivar
//
//  Created by 谭嘉麒 on 16/4/23.
//  Copyright © 2016年 谭嘉麒. All rights reserved.
//

#import "ViewController.h"
#import "objc/runtime.h"
//#import "objc/message"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    unsigned int count;
    Class c = [NSCache class];
    Ivar *ivars = class_copyIvarList(c, &count);
    
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s",ivar_getName(ivar));
    }
    
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory
                                                 valueOptions:NSMapTableWeakMemory];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
