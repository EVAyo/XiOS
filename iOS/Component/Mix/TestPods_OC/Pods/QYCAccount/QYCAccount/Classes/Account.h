//
//  Account.h
//  Qiyeyun
//
//  Created by 钱立新 on 15/11/19.
//  Copyright © 2015年 钱立新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding,NSSecureCoding>
/**
 avatar = "<null>";
 departmentId = "";
 departmentName = "";
 entId = NanJingAnYuanKeJi;
 entName = "\U5357\U4eac\U5b89\U5143\U79d1\U6280\U6709\U9650\U516c\U53f8";
 isLogin = 1;
 isNavigation = 0;
 "login_user_id" = yuhuan;
 realName = "\U4f59\U6b22";
 roleId = "";
 roleName = "\U79fb\U52a8\U5e94\U7528\U7ec4";
 sex = 0;
 type = 0;
 userId = yuhuan;
 "verify_two" = 0;
 
 
 */
/**
 *  头像
 */
@property (nonatomic, copy) NSString *avatar;
/**
 *  部门id
 */
@property (nonatomic, copy) NSString *departmentId;
/**
 *  部门名称
 */
@property (nonatomic, copy) NSString *departmentName;
/**
 *  公司id
 */
@property (nonatomic, copy) NSString *entId;
/**
 *  公司名称
 */
@property (nonatomic, copy) NSString *entName;
/**
 *  登录名字
 */
@property (nonatomic, copy) NSString *login_user_id;
/**
 *  真实名字
 */
@property (nonatomic, copy) NSString *realName;
/**
 *  角色id
 */
@property (nonatomic, copy) NSString *roleId;
/**
 *  角色名字
 */
@property (nonatomic, copy) NSString *roleName;
/**
 *  用户id
 */
@property (nonatomic, copy) NSString *userId;

/**
 *  是否已经登录
 */
@property (nonatomic,assign) BOOL  isLogin;
/**
 *  
 */
@property (nonatomic,assign) NSNumber *isNavigation;
/**
 *  性别
 */
@property (nonatomic,assign) NSNumber *sex;
/**
 *  类型
 */
@property (nonatomic,assign) NSNumber *type;//type为6时，是管理员

/**
 *  两步验证
 */
@property (nonatomic,assign) NSNumber *verify_two;

/**
 *  生日类型
 */
@property (nonatomic,assign) NSNumber *birth_type;

/**
 *  生日
 */
@property (nonatomic,copy) NSString *birthday;
/**
 *  注册时间
 */
@property (nonatomic,copy) NSString *create_time;

/**
 *  email
 */
@property (nonatomic,copy) NSString *email;
/**
 *  上次登录时间
 */
@property (nonatomic,copy) NSString *last_login_time;
/**
 *  上次修改时间
 */
@property (nonatomic,copy) NSString *last_modified;

/**
 *  手机号
 */
@property (nonatomic,copy) NSString *phone;
/**
 *  名字拼音
 */
@property (nonatomic,copy) NSString *pinyin;
/**
 *  注册类型
 */
@property (nonatomic,assign) NSNumber *reg_type;
/**
 *  重置密码
 */
@property (nonatomic,assign) NSNumber *reset_pwd;
/**
 *  主题
 */
@property (nonatomic,copy) NSString *theme;

- (instancetype)initWithDic:(NSDictionary *)dict;
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
