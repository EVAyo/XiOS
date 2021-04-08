//
//  NSString+Regular.m
//  Category
//
//  Created by 钱立新 on 14/10/28.
//  Copyright © 2014年 钱立新. All rights reserved.
//

#import "NSDate+Format.h"
#import "NSString+HTML.h"
#import "NSString+Regular.h"

@implementation NSString (Regular)

- (BOOL)isValidateEmail {
    //    NSString *regex        = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isNumber {
    NSString *regex        = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)containNumber {
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count                    = [numberRegular numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    // count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    if (count > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isEnglishWords {
    NSString *regex        = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)containEnglishWords {
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count                    = [numberRegular numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    // count是str中包含[A-z]英文的个数，只要count>0，说明str中包含字符
    if (count > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)containSpecialChar {
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[^A-Za-z0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count                    = [numberRegular numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    if (count > 0) {
        return YES;
    }
    return NO;
}

//字母数字下划线，8－16位
- (BOOL)isValidatePassword {
    NSString *regex        = @"^[\\w\\d_]{8,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isChineseWords {
    NSString *regex        = @"^[\u4e00-\u9fa5],{0,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)containChineseWords {
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5],{0,}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count                    = [numberRegular numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    if (count > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isInternetUrl {
    //        NSString *regex        = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    //和安卓保持一致
    NSString *regex        = @"(http://|ftp://|https://|www)[^\u4e00-\u9fa5\\s]*?\\.([a-zA-Z]{2,3})?[^\u4e00-\u9fa5\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)containsInternetUrl:(NSString *)str {
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr        = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];
    if (arrayOfAllMatches.count == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isPhoneNumber {
    NSString *regex        = @"^(\(\\d{{3,4}\\)|\\d{3,4}-)?\\d{7,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidateMobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    //    NSLog(@"phoneTest is %@",phoneTest);
    //    return [phoneTest evaluateWithObject:self];
    //@"^(\\d{11})$|^((\\d{7,8})|(\\d{3,4})-(\\d{7,8})|(\\d{3,4})-(\\d{7,8})-(\\d{1,4}))$"
    NSString *phoneRegex   = @"^((1+[3-9]+[0-9])\\d{8})";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isElevenDigitNum {
    NSString *regex = @"^[0-9]*$";

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result            = [predicate evaluateWithObject:self];

    if (result && self.length == 11)
        return YES;

    return NO;
}

- (BOOL)isIdentifyCardNumber {
    NSString *regex        = @"^\\d{15}|\\d{}18$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isMobileNumberClassification {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700
     */
    //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])//d{7}$";//总况

    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     12         */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])//d|705)//d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,1709
     17         */
    NSString *CU = @"^1((3[0-2]|5[256]|8[56])//d|709)//d{7}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,1700
     22         */
    NSString *CT = @"^1((33|53|8[09])//d|349|700)//d{7}$";

    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString *PHS = @"^0(10|2[0-5789]|//d{3})//d{7,8}$";

    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];

    if (([regextestcm evaluateWithObject:self] == YES) || ([regextestct evaluateWithObject:self] == YES) || ([regextestcu evaluateWithObject:self] == YES) || ([regextestphs evaluateWithObject:self] == YES)) {
        return YES;
    }
    else {
        return NO;
    }
}

/*
 *  处理成想要的格式日期
 */
+ (NSString *)timeStringToString:(NSString *)string {
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat       = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *date         = [fmt dateFromString:string];

    if ([date isThisYear]) { // 今年

        if ([date isToday]) { // 今天

            // 计算跟当前时间差距
            NSDateComponents *cmp = [date deltaWithNow];

            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前", cmp.hour];
            }
            else if (cmp.minute > 1) {
                return [NSString stringWithFormat:@"%ld分钟之前", cmp.minute];
            }
            else {
                return @"刚刚";
            }
        }
        else if ([date isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:date];
        }
        else { // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:date];
        }
    }
    else { // 不是今年

        fmt.dateFormat = @"yyyy-MM-dd HH:mm";

        return [fmt stringFromDate:date];
    }

    return string;
}

// @"@\\[(.+?)\\]\\(at:(.+?)\\)\\(type:(.+?)\\)"
+ (NSMutableString *)removeSpecificStringWithRegular:(NSString *)regular from:(NSMutableString *)text {
    NSArray *atResults = [[NSRegularExpression regularExpressionWithPattern:regular options:kNilOptions error:NULL] matchesInString:text options:kNilOptions range:NSMakeRange(0, text.length)];

    NSUInteger clipLength = 0;
    for (NSTextCheckingResult *at in atResults) {
        if (at.range.location == NSNotFound && at.range.length <= 1)
            continue;

        NSRange range1 = at.range;
        range1.location -= clipLength;
        [text replaceCharactersInRange:range1 withString:@""];

        range1 = NSMakeRange(range1.location, 0);
        clipLength += at.range.length;
    }
    return text;
}

+ (NSArray *)urlFromString:(NSString *)string {
    if (string.length == 0) {
        return @[];
    }
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr        = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    if (arrayOfAllMatches.count == 0) {
        return nil;
    }

    NSMutableArray *urls = [NSMutableArray new];

    for (NSTextCheckingResult *http in arrayOfAllMatches) {
        if (http.range.location == NSNotFound && http.range.length <= 1)
            continue;
        NSString *substringForMatch = [string substringWithRange:http.range];
        if (![substringForMatch hasPrefix:@"http"]) {
            substringForMatch = [NSString stringWithFormat:@"http://%@", substringForMatch];
        }
        [urls addObject:substringForMatch];
    }
    return urls;
}
@end
