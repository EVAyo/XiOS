//
//  QYCH5Config.m
//  Qiyeyun
//
//  Created by 启业云03 on 2020/12/2.
//  Copyright © 2020 安元. All rights reserved.
//

#import "QYCH5Config.h"

#pragma mark - ================ URL =================

/**
 * 根据长域名转换成短域名
 *
 * POST  :  根据长链接生成并保存短链接
 * GET    :  根据短链接获取长链接
 */
NSString *const API_H5_QYC_QRShortToLongURL     = @"api2/widget/shorturl/";
NSString *const API_H5_QYC_QRShortToLongURL_New = @"api2/widget/sysshorturl";

// 获取数据源信息
NSString *const API_H5_GetDataSource = @"api2/datacenter/datasource/";

// Get：拉取评论消息，Post：发送评论
NSString *const API_H5_InfoCentre_discussPosts = @"api/comments/msg";
