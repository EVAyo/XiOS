//
//  NSMutableArray+FilterElement.h
//  Category
//
//  Created by 钱立新 on 14/10/28.
//  Copyright © 2014年 钱立新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (FilterElement)
/**
 *   过滤掉相同的元素
 *
 *   @return 返回一个数组
 */
- (NSMutableArray *)filterTheSameElement;

/**
 *  获得两个数组中相同的元素
 *
 *  @param conditionArray 筛选条件数组
 *
 *  @return 存放该两个数组中相同元素的可变数组
 */
- (NSArray *)getSameElementWithArray:(NSArray *)conditionArray;

/**
 *  获得fromArrar数组中不包含conditionArray数组元素
 *
 *  @param conditionArray 筛选条件数组
 *
 *  @return 数组中不包含conditionArray中元素的可变数组
 */
- (NSArray *)getDifferElementWithArray:(NSArray *)conditionArray;

@end
