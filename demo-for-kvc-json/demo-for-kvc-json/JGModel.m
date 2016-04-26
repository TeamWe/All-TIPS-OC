//
//  JGModel.m
//  demo-for-kvc-json
//
//  Created by 徐纪光 on 16/4/25.
//  Copyright © 2016年 谭嘉麒. All rights reserved.
//

#import "JGModel.h"
#import <objc/runtime.h>

@interface JGModel ()
@property (nonatomic, copy)NSString *Amount;
@property (nonatomic, copy)NSString *CurrentPage;

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
-(void) serializationDataWith:(NSDictionary *)dic{
    Class c = self.class;
    unsigned int count;
    Ivar *ivars = class_copyIvarList(c, &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        NSString *name = [[NSString stringWithUTF8String:ivar_getName(ivar)]substringFromIndex:1] ;
        NSLog(@"%@",name);
        id value = dic[name];
        if (!value) {//多余的属性可以不管kv
            continue;
        }
        object_setIvar(self, ivar, dic[name]);
//        [self setValue:dic[name] forKey:name];//也可以
        NSLog(@"12");
    }
    free(ivars);
    c = [c superclass];
}
@end
