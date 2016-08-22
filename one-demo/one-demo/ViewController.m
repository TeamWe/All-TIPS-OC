//
//  ViewController.m
//  one-demo
//
//  Created by 徐纪光 on 16/5/24.
//  Copyright © 2016年 jiguang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>{
    
    NSURLSessionDataTask *ta;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    
    
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//    
//    
//    NSURL *url = [NSURL URLWithString:@"http://p1.pichost.me/i/40/1639665.png"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    
////    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
////        NSLog(@"%@",data);
////    }];
//    
//    ta = [session dataTaskWithRequest:request];
//    
//    [ta resume];
}
- (instancetype)init
{
    id suiyi = [super init];
    if (suiyi) {
//        suiyi
    }
    return suiyi;
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    
    completionHandler( NSURLSessionResponseBecomeDownload);
    NSLog(@"didReceiveResponse");
    // 告诉系统需要接收数据
    
    
    // 初始化文件总大小
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
        NSLog(@"didReceiveData");
//    // 累加已经下载的大小
//    self.currentLength += data.length;
//    
//    // 计算进度
//    self.progressView.progress = 1.0 * self.currentLength / self.totalLength;
//    
//    // 写入数据
//    [self.outputStream write:data.bytes maxLength:data.length];
}



- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    NSLog(@"1");
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler{
    NSLog(@"1");
//    completionHandler( NSURLSessionResponseBecomeDownload);

}



- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * __nullable bodyStream))completionHandler{
    NSLog(@"1");
//    completionHandler(NSURLSessionResponseBecomeDownload);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    NSLog(@"1");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
