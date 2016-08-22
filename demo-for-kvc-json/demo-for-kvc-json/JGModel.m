//
//  JGModel.m
//  demo-for-kvc-json
//
//  Created by 徐纪光 on 16/4/25.
//  Copyright © 2016年 谭嘉麒. All rights reserved.
//

#import "JGModel.h"
#import <objc/runtime.h>
#import "NSObject+Json.h"

@interface JGDataModel : NSObject
@property(nonatomic, copy)NSString *Date;
@property(nonatomic, copy)NSString *ID;
@property(nonatomic, copy)NSString *Title;
@end

@implementation JGDataModel


@end


@interface JGModel ()
@property (nonatomic, copy)NSString *Amount;
@property (nonatomic, copy)NSString *CurrentPage;
@property (nonatomic, copy)NSArray<JGDataModel *> *Data;
@property (nonatomic, copy)NSString *etag;
@end

@implementation JGModel
static JGModel *once = nil;
+ (instancetype)shareInstancetype{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        if(once != NULL)
            once = [[JGModel alloc]init];
        [once getBookI];
    });
    return once;
}

- (void)getBookI1{
    Class c = self.class;
    unsigned int count;
    objc_property_t *propers = class_copyPropertyList(c, &count);
    for (int i=0; i<count; i++) {
        objc_property_t p = propers[i];
        NSLog(@"%s\n%s\n",property_getName(p),property_getAttributes(p));
    }
    
    
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
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil][@"Detail"];
        NSLog(@"dic=%@",dic);
        [self serializationDataWith:dic];
        
        //        更新etag数据
        if(httpresponse.statusCode == 200)
            self.etag = httpresponse.allHeaderFields[@"Etag"];
    }];
    
    [task resume];
    
}

- (NSString *)arrayObjectClass{
    return @"JGDataModel";
}
@end
