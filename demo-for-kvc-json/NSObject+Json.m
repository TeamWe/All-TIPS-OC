//
//  NSObject+Json.m
//  demo-for-kvc-json
//
//  Created by 徐纪光 on 16/4/30.
//  Copyright © 2016年 谭嘉麒. All rights reserved.
//

#import "NSObject+Json.h"
#import <objc/runtime.h>
@implementation NSObject (Json)
-(void) serializationDataWith:(NSDictionary *)dic{
    
    Class c = self.class;
    while(c && c!=[NSObject class]){
        unsigned int count;
        Ivar *ivars = class_copyIvarList(c, &count);
        for (int i=0; i<count; i++) {
            Ivar ivar = ivars[i];
            NSString *name = [[NSString stringWithUTF8String:ivar_getName(ivar)]substringFromIndex:1] ;
            
            id value = dic[name];
            
            //多余的属性可以不管
            if (!value) {
                continue;
            }
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            type = [type substringWithRange:NSMakeRange(2, type.length-3)];
//            第一种情况得到的数据类型是另一个模型所以我们进行进一步解析
            if(![type hasPrefix:@"NS"]){
                Class class = NSClassFromString(type);
                value = [class objectWithDict:value];
            }
            
//            处理是数组的情况
            else if([type isEqualToString:@"NSArray"]){
                NSArray *arr = (NSArray *)value;
                NSMutableArray *marr = [[NSMutableArray alloc]init];
                id class;
                if([self respondsToSelector:@selector(arrayObjectClass)]){
//                    获取数组中的数据类型，这一步可以优化。可以考虑模型中出现多个array
                    
                    class = NSClassFromString([self arrayObjectClass]);
                }
//                 将数组中的所有模型进行字典转模型
                for (int i = 0; i < arr.count; i++) {
                    [marr addObject:[class objectWithDict:value[i]]];
                }
                value = marr;
            }
            
            
            NSLog(@"name:%@       type:%@",name,type);
            
            object_setIvar(self, ivar, dic[name]);
            
            //        [self setValue:dic[name] forKey:name];//也可以
                        NSLog(@"%@",object_getIvar(self, ivar));
        }
        free(ivars);
        c = [c superclass];
    }
}

//留给子类重写来返回必要的数组类型
- (NSString *)arrayObjectClass{
    return NULL;
}

+ (instancetype)objectWithDict:(NSDictionary *)dict{
    NSObject *obj = [[self alloc]init];
    [obj serializationDataWith:dict];
    return obj;
}

@end
