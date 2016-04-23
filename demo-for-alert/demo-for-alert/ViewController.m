//
//  ViewController.m
//  demo-for-alert
//
//  Created by 谭嘉麒 on 16/4/23.
//  Copyright © 2016年 谭嘉麒. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertView+block.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *FirstButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    FirstButton.backgroundColor = [UIColor blackColor];
    [FirstButton setTitle:@"first" forState:UIControlStateNormal];
    [FirstButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [FirstButton addTarget:self action:@selector(firstClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FirstButton];
    
    
    
    
    UIButton *Sbutton = [[UIButton alloc]initWithFrame:CGRectMake(200, 100, 100, 100)];
    Sbutton.backgroundColor = [UIColor blackColor];
    [Sbutton setTitle:@"second" forState:UIControlStateNormal];
    [Sbutton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [Sbutton addTarget:self action:@selector(secondClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Sbutton];
}


- (void)firstClick{
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"first" message:@"ok" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"OK", nil];
    al.block = ^(UIAlertView *alert,NSUInteger index){
        if(index ==1)
            NSLog(@"001");
    };
    [al show];
}
- (void)secondClick{
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"second" message:@"ok" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"OK", nil];
    al.block = ^(UIAlertView *alert,NSUInteger index){
        if(index ==1)
            NSLog(@"002");
    };
    [al show];
}

@end
