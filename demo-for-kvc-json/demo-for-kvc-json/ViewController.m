//
//  ViewController.m
//  demo-for-kvc-json
//
//  Created by 徐纪光 on 16/4/24.
//  Copyright © 2016年 徐纪光. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, copy)NSString *etag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    NSString *str = @"http://api.xiyoumobile.com/xiyoulibv2/news/getList/news/1";
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    //    设置request的etag用于和服务器相比较，这个值可以考虑存储在本地
    if(self.etag.length > 0)
        [request setValue:_etag forHTTPHeaderField:@"If-None-Match"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task= [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse *)response;
        NSLog(@"status == %@",@(httpresponse.statusCode));
        if(httpresponse.statusCode == 304){//可以使用缓存
            NSCachedURLResponse *cacheResponse = [[NSURLCache sharedURLCache]cachedResponseForRequest:request];
            data = [NSData dataWithData:cacheResponse.data];
            //            在缓存中取出数据
        }
        //        简单解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"dic=%@",dic);
        //        更新etag数据
        if(httpresponse.statusCode == 200)
            self.etag = httpresponse.allHeaderFields[@"Etag"];
    }];
    
    
    [task resume];
    
}

@end
