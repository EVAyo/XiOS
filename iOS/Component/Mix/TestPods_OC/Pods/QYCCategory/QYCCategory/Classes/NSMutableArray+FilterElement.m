//
//  NSMutableArray+FilterElement.m
//  Category
//
//  Created by 钱立新 on 14/10/28.
//  Copyright © 2014年 钱立新. All rights reserved.
//

#import "NSMutableArray+FilterElement.h"

@implementation NSMutableArray (FilterElement)
/**
 *   过滤掉相同的元素
 *
 *   @return 返回一个数组
 */
- (NSMutableArray *)filterTheSameElement {
    NSMutableSet *set = [NSMutableSet set];
    for (NSObject *obj in self) {
        [set addObject:obj];
    }
    [self removeAllObjects];
    for (NSObject *obj in set) {
        [self addObject:obj];
    }
    return self;
}

/**
 *  获得两个数组中相同的元素
 *
 *  @param conditionArray 数组2
 *
 *  @return 存放该两个数组中相同元素的可变数组
 */
- (NSArray *)getSameElementWithArray:(NSArray *)conditionArray {
    if (!conditionArray.count)
        return nil;
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", conditionArray];
    //过滤数组
    NSArray *reslutFilteredArray = [self filteredArrayUsingPredicate:filterPredicate];

    return reslutFilteredArray;
}

/**
 *  获得数组中不包含conditionArray数组元素
 *
 *  @param conditionArray 筛选条件数组
 *
 *  @return 数组中不包含conditionArray中元素的可变数组
 */
- (NSArray *)getDifferElementWithArray:(NSArray *)conditionArray {
    //
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", conditionArray];
    //过滤数组
    NSArray *reslutFilteredArray = [self filteredArrayUsingPredicate:filterPredicate];

    return reslutFilteredArray;
}

@end
