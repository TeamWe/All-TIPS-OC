//
//  JGModel.m
//  demo-for-kvc-json
//
//  Created by 徐纪光 on 16/4/25.
//  Copyright © 2016年 谭嘉麒. All rights reserved.
//

#import "JGModel.h"


@interface JGModel ()
@property (nonatomic, copy)NSString *etag;
@end

@implementation JGModel
static JGModel *once = nil;
+ (instancetype)shareInstancetype{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(once != NULL)
            once = [[JGModel alloc]init];
    });
    return once;
}

- (void)getBookI{
    
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
