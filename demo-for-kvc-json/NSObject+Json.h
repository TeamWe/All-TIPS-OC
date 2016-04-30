//
//  NSObject+Json.h
//  demo-for-kvc-json
//
//  Created by 徐纪光 on 16/4/30.
//  Copyright © 2016年 谭嘉麒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Json)
-(void) serializationDataWith:(NSDictionary *)dic;

- (NSString *)arrayObjectClass;

@end
