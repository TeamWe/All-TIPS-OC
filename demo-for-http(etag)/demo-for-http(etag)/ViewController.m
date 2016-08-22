//
//  ViewController.m
//  demo-for-http(etag)
//
//  Created by 谭嘉麒 on 16/4/24.
//  Copyright © 2016年 徐纪光. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, copy)NSString *etag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.etag = @"\"-966914176\"";
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSMutableDictionary *glossary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              @"A class defined so other class can inherit from it.",@"abstract class",
                              @"To implement all the methods defined in a protocol.",@"adopt",
                              @"Storing an object for later use.",@"archiving",
                              nil
                              ];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"ta.archiver"]];
    [NSKeyedArchiver archiveRootObject:glossary toFile:filePath];
    
    //将文件glossary.archive中的数据读到字典对象并显示出来
    NSDictionary *readglossary = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    for(NSString *key in readglossary)
        NSLog(@"***************%@: %@",key,[readglossary objectForKey:key]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    NSString *str = [NSString stringWithFormat:@"http://www.varpm.com:3002/v1/article/getDetail/%@",@"100318734"];
//    NSString *str = @"http://api.xiyoumobile.com/xiyoulibv2/news/getList/news/1";
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    //    设置request的etag用于和服务器相比较，这个值可以考虑存储在本地
    if(self.etag.length > 0)
        [request setValue:_etag forHTTPHeaderField:@"If-None-Match"];
    
//    NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse *)response;
//    NSCachedURLResponse *cacheResponse = [[NSURLCache sharedURLCache]cachedResponseForRequest:request];
//    NSData * data = [NSData dataWithData:cacheResponse.data];
    NSURLSession *session = [NSURLSession sharedSession];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"dic=%@",dic);
    
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
        {
            self.etag = httpresponse.allHeaderFields[@"Etag"];
            [[NSURLCache sharedURLCache] storeCachedResponse:[[NSCachedURLResponse alloc]initWithResponse:response data:data] forRequest:request];
            
        }
    }];
    
    
    [task resume];
    
}

@end
