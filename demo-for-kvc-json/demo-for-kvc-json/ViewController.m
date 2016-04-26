//
//  ViewController.m
//  demo-for-kvc-json
//
//  Created by 徐纪光 on 16/4/24.
//  Copyright © 2016年 徐纪光. All rights reserved.
//

#import "ViewController.h"

#import "JGModel.h"
@interface ViewController ()
@property (nonatomic, copy)NSString *etag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [JGModel shareInstancetype];
}


@end
