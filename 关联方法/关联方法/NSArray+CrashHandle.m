//
//  NSArray+CrashHandle.m
//  关联方法
//
//  Created by mac on 2018/7/29.
//  Copyright © 2018年 Gooou. All rights reserved.
//

#import "NSArray+CrashHandle.h"
#import <objc/runtime.h>

@implementation NSArray (CrashHandle)

+(void)load
{
    Method fromMethod=class_getClassMethod(objc_getClass("_NSArrayI"), @selector(objectAtIndex:));
    Method toMethod=class_getInstanceMethod(objc_getClass("_NSArrayI"), @selector(cm_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}
//为了避免和系统的方法冲突，一般会在swizzling方法前面加上前缀
-(id)cm_objectAtIndex:(NSInteger)index
{
    //判断下标是否越界，如果越界就会进行异常拦截
    if (self.count-1<index) {
        @try{
            return [self cm_objectAtIndex:index];
        }
        @catch(NSException *exception)
        {
            //在崩溃后会打印崩溃信息。如果是线上，可以在这里将崩溃的信息发送到服务器上。
            NSLog(@"---------%s Crash Because Method %s --------\n",class_getName(self.class),__func__);
            NSLog(@"%@",[exception callStackSymbols]);
            return nil;
        }
        @finally{}
    }else{
        return [self cm_objectAtIndex:index];
    }
}
@end
