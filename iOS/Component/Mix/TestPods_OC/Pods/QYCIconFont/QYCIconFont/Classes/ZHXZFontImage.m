//
//  ZHXZFontImage.m
//  Qiyeyun
//
//  Created by 张伟 on 2019/9/17.
//  Copyright © 2019 安元. All rights reserved.
//

#import "ZHXZFontImage.h"

static NSDictionary *_zhzxIconDictionary;


@implementation ZHXZFontImage

+ (NSDictionary *)zhzxIconDictionary{
    if (!_zhzxIconDictionary) {
        _zhzxIconDictionary = @{
                                @"LETS":@"\U0000e8b4", // LETS
                                @"企小秘":@"\U0000e8af", // 企小秘
                                @"待办事项":@"\U0000e602", // 待办事项
                                @"二维码":@"\U0000e6d6", // 二维码
                                @"设置":@"\U0000e8ae", // 设置
                                @"关于":@"\U0000e8ad", // 关于
                                @"收藏":@"\U0000e8ab", // 收藏
                                @"yingyong_normal":@"\U0000e859", // 应用
                                @"yingyong_highlight":@"\U0000e857", // 应用高亮
                                @"menhu_normal":@"\U0000e854", //  门户
                                @"menhu_highlight":@"\U0000e852", // 门户高亮
                                @"people_normal":@"\U0000e847", // 我的
                                @"people_highlight":@"\U0000e845", // 我的高亮
                                @"bubble_normal":@"\U0000e838", // 消息
                                @"book_normal":@"\U0000e836", // 消息高亮
                                @"bubble_highlight":@"\U0000e835", // 信息
                                @"book_highlight":@"\U0000e834", // 信息高亮
                                @"":@""
                                
                                };
    }
    return _zhzxIconDictionary;
}

+ (NSString *)fontName{
    return @"zhxz";
}

+(NSString*)nameToUnicode:(NSString*)name{
    NSString *code = [self imageCodeWithImageName:name];
    return code ?: name;
}

+ (NSString *) imageCodeWithImageName:(NSString*)imageName{

    NSDictionary *nameToUnicode = [self zhzxIconDictionary];
    
    NSString *code = nameToUnicode[imageName];
    if (code == nil || code.length == 0) {
        return nil;
    }
    return code;
}



+ (NSMutableAttributedString*)attributedStringIconWithName:(NSString*)name fontSize:(CGFloat)size color:(UIColor*)color {
    NSString *fontName = [self fontName];
    UIFont *iconfont =  [TBCityIconFont fontWithSize:size withFontName:fontName];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[self nameToUnicode:name] attributes:@{NSFontAttributeName:iconfont?:[UIFont systemFontOfSize:size],NSForegroundColorAttributeName:color}];
    return text;
}




@end
