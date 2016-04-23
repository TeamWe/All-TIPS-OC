

#import "ViewController.h"
#import "UIGestureRecognizer+block.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    原始调用
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(demo:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    
    
    
//    简单调用
    [self.view addGestureRecognizer:[UITapGestureRecognizer xjg_gestureRecognizerWithActionBlcok:^(id sender) {
        NSLog(@"1");
    }]];

}

- (void)demo:(id)sender{
    NSLog(@"2");
}


@end
