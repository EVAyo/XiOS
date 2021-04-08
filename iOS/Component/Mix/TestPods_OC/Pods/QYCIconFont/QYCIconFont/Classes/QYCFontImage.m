
//
//  QYCFontImage.m
//  Qiyeyun
//
//  Created by dong on 2017/11/23.
//  Copyright © 2017年 安元. All rights reserved.
//

#import "QYCFontImage.h"

static NSDictionary *_iconDictionary;
static NSDictionary *_appIconDictionary;
static NSDictionary *_tabIconDictionary;

@implementation QYCFontImage

+ (NSDictionary *)bottomTabIconDictionary {
    if (!_tabIconDictionary) {
        _tabIconDictionary = @{
            @"tab-xiaoxizhongxin" : @"\U0000e97c",      // xiaoxizhongxin
            @"tab-xiaoxizhongxin01" : @"\U0000e979",    // xiaoxizhongxin01
            @"tab-earth" : @"\U0000e867",               // earth
            @"tab-mccart_normal" : @"\U0000e85a",       // mccart_normal
            @"tab-mccart_highlight" : @"\U0000e85b",    // mccart_highlight
            @"tab-mcmine_highlight" : @"\U0000e85c",    // mcmine_highlight
            @"tab-mcshop_normal" : @"\U0000e85d",       // mcshop_normal
            @"tab-mccollect_highlight" : @"\U0000e85e", // mccollect_highlight
            @"tab-mccollect_normal" : @"\U0000e85f",    // mccollect_normal
            @"tab-mcmine_normal" : @"\U0000e860",       // mcmine_normal
            @"tab-mcshop_highlight" : @"\U0000e861",    // mcshop_highlight
            @"tab-mcticket_highlight" : @"\U0000e862",  // mcticket_highlight
            @"tab-mcticket_normal" : @"\U0000e863",     // mcticket_normal
            @"tab-xuexi_highlight" : @"\U0000e6de",     // xuexi_highlight
            @"tab-xiezuo_highlight" : @"\U0000e6df",    // xiezuo_highlight
            @"tab-xuexi_normal" : @"\U0000e6e0",        // xuexi_normal
            @"tab-xiezuo_normal" : @"\U0000e6e1",       // xiezuo_normal
            @"tab-faxian_highlight" : @"\U0000e84e",    // faxian_highlight
            @"tab-faxian_normal" : @"\U0000e850",       // faxian_normal
            @"tab-menhu_highlight" : @"\U0000e852",     // menhu_highlight
            @"tab-qiliao_highlight" : @"\U0000e853",    // qiliao_highlight
            @"tab-menhu_normal" : @"\U0000e854",        // menhu_normal
            @"tab-qiliao_normal" : @"\U0000e855",       // qiliao_normal
            @"tab-yibiaopan_highlight" : @"\U0000e856", // yibiaopan_highlight
            @"tab-yingyong_highlight" : @"\U0000e857",  // yingyong_highlight
            @"tab-yibiaopan_normal" : @"\U0000e858",    // yibiaopan_normal
            @"tab-yingyong_normal" : @"\U0000e859",     // yingyong_normal
            @"tab-zoom_normal" : @"\U0000e84f",         // zoom_normal
            @"tab-tool_normal" : @"\U0000e851",         // tool_normal
            @"tab-bag_highlight" : @"\U0000e830",       // bag_highlight
            @"tab-bell_highlight" : @"\U0000e831",      // bell_highlight
            @"tab-bag_normal" : @"\U0000e832",          // bag_normal
            @"tab-bell_normal" : @"\U0000e833",         // bell_normal
            @"tab-book_highlight" : @"\U0000e834",      // book_highlight
            @"tab-bubble_highlight" : @"\U0000e835",    // bubble_highlight
            @"tab-book_normal" : @"\U0000e836",         // book_normal
            @"tab-camera_highlight" : @"\U0000e837",    // camera_highlight
            @"tab-bubble_normal" : @"\U0000e838",       // bubble_normal
            @"tab-camera_normal" : @"\U0000e839",       // camera_normal
            @"tab-crown_highlight" : @"\U0000e83a",     // crown_highlight
            @"tab-data_highlight" : @"\U0000e83b",      // data_highlight
            @"tab-crown_normal" : @"\U0000e83c",        // crown_normal
            @"tab-favorite_highlight" : @"\U0000e83d",  // favorite_highlight
            @"tab-handshake_highlight" : @"\U0000e83e", // handshake_highlight
            @"tab-favorite_normal" : @"\U0000e83f",     // favorite_normal
            @"tab-list_highlight" : @"\U0000e840",      // list_highlight
            @"tab-list_normal" : @"\U0000e841",         // list_normal
            @"tab-data_normal" : @"\U0000e842",         // data_normal
            @"tab-mail_normal" : @"\U0000e843",         // mail_normal
            @"tab-handshake_normal" : @"\U0000e844",    // handshake_normal
            @"tab-people_highlight" : @"\U0000e845",    // people_highlight
            @"tab-mail_highlight" : @"\U0000e846",      // mail_highlight
            @"tab-people_normal" : @"\U0000e847",       // people_normal
            @"tab-menu_normal" : @"\U0000e848",         // menu_normal
            @"tab-speak_highlight" : @"\U0000e849",     // speak_highlight
            @"tab-speak_normal" : @"\U0000e84a",        // speak_normal
            @"tab-menu_highlight" : @"\U0000e84b",      // menu_highlight
            @"tab-tool_highlight" : @"\U0000e84c",      // tool_highlight
            @"tab-zoom_highlight" : @"\U0000e84d",      // zoom_highlight
            @"" : @""
        };
    }
    return _tabIconDictionary;
}

+ (NSDictionary*)IconDictionary
{
    return @{
    @"应用代理": @"\U0000ea25",
    @"qianming":@"\U0000ea1e", // qianming
    @"xuanzhong-01":@"\U0000ea15", // xuanzhong-01
    @"toupiao1":@"\U0000ea13", // toupiao1
    @"gonggaotixin":@"\U0000ea11", // gonggaotixin
    @"fenxiang01-01":@"\U0000ea0f", // fenxiang01-01
    @"fenzu":@"\U0000ea01", // fenzu
    @"juese1":@"\U0000ea00", // juese1
    @"qchat-wenjian":@"\U0000e9f7", // qchat-wenjian
    @"qchat-zhibo":@"\U0000e9f6", // qchat-zhibo
    @"guanli":@"\U0000e9f3", // guanli
    @"jieshoutixin":@"\U0000e9f2", // jieshoutixin
    @"xitongmiaoshu":@"\U0000e9f1", // xitongmiaoshu
    @"suoyouren":@"\U0000e717", // suoyouren
    @"zuzhi":@"\U0000e716", // zuzhi
    @"juese":@"\U0000e6e7", // juese
    @"taolun":@"\U0000e715", // taolun
    @"men":@"\U0000e6e6", // men
    @"xitong":@"\U0000e9bb", // xitong
    @"yewutixing":@"\U0000e9ba", // yewutixing
    @"qiehuanjiuban":@"\U0000e9b9", // qiehuanjiuban
    @"dianzan1":@"\U0000e9b6", // dianzan1
    @"lpinlun1":@"\U0000e9b5", // lpinlun1
    @"dianzan":@"\U0000e9b3", // dianzan
    @"pinlun":@"\U0000e9b2", // pinlun
    @"fasong":@"\U0000e9b1", // fasong
    @"gongsi":@"\U0000e9ab", // gongsi
    @"paixuxia":@"\U0000e6e4", // paixuxia
    @"paixushang":@"\U0000e6e5", // paixushang
    @"suoyu":@"\U0000e69e", // suoyu
    @"jiaqian":@"\U0000e9a2", // jiaqian
    @"at":@"\U0000e99f", // at
    @"emoji":@"\U0000e9a0", // emoji
    @"zoom":@"\U0000e9a1", // zoom
    @"tuichuzhibo":@"\U0000e989", // tuichuzhibo
    @"miandarao":@"\U0000e988", // miandarao
    @"zhiding":@"\U0000e987", // zhiding
    @"shoucang-":@"\U0000e986", // shoucang-
    @"weituozhong":@"\U0000e97d", // weituozhong
    @"fanzhuanjingtou":@"\U0000e978", // fanzhuanjingtou
    @"bufenxuanzhong":@"\U0000e96e", // bufenxuanzhong
    @"check":@"\U0000e965", // check
    @"zhanghaoguanli":@"\U0000e960", // zhanghaoguanli
    @"xitonngtongzhi":@"\U0000e95e", // xitonngtongzhi
    @"digyue":@"\U0000e95d", // digyue
    @"quxiaodingyue":@"\U0000e95c", // quxiaodingyue
    @"icon-tianjiatupian":@"\U0000e958", // icon-tianjiatupian
    @"jiazaishibai":@"\U0000e956", // jiazaishibai
    @"lianjie":@"\U0000e940", // lianjie
    @"people_highlight":@"\U0000e93b", // people_highlight
    @"weixuanzhong":@"\U0000e93a", // weixuanzhong
    @"xuanzhong":@"\U0000e939", // xuanzhong
    @"chuanshuzhushou":@"\U0000e937", // chuanshuzhushou
    @"light-on":@"\U0000e933", // light-on
    @"light-off":@"\U0000e934", // light-off
    @"zhaopian":@"\U0000e935", // zhaopian
    @"yichu":@"\U0000e930", // yichu
    @"tianjia":@"\U0000e92f", // tianjia
    @"toupiao":@"\U0000e92d", // toupiao
    @"fuchuang-01":@"\U0000e922", // fuchuang-01
    @"zhuanfa-01":@"\U0000e91d", // zhuanfa-01
    @"shoucang2-01-01":@"\U0000e91c", // shoucang2-01-01
    @"yingyongyc":@"\U0000e915", // yingyongyc
    @"kognzhi":@"\U0000e711", // kognzhi
    @"zizh":@"\U0000e714", // zizh
    @"business":@"\U0000e64c", // business
    @"campaign_members":@"\U0000e707", // campaign_members
    @"CPU":@"\U0000e708", // CPU
    @"custoi":@"\U0000e709", // custoi
    @"houduantuozhan":@"\U0000e70a", // houduantuozhan
    @"custom":@"\U0000e70b", // custom
    @"qianduan":@"\U0000e70c", // qianduan
    @"custos":@"\U0000e70d", // custos
    @"service_territory":@"\U0000e70e", // service_territory
    @"xiangmu":@"\U0000e70f", // xiangmu
    @"yingsi":@"\U0000e710", // yingsi
    @"data_integration":@"\U0000e712", // data_integration
    @"wangguanzhong":@"\U0000e713", // wangguanzhong
    @"zuofei":@"\U0000e90e", // zuofei
    @"工作圈":@"\U0000e90a", // 工作圈
    @"拍照":@"\U0000e905", // 拍照
    @"表情":@"\U0000e906", // 表情
    @"图片":@"\U0000e907", // 图片
    @"艾特":@"\U0000e908", // 艾特
    @"文件":@"\U0000e909", // 文件
    @"定位":@"\U0000e8ec", // 定位
    @"传感器":@"\U0000e8ed", // 传感器
    @"监控视频":@"\U0000e8ee", // 监控视频
    @"日期":@"\U0000e8ef", // 日期
    @"已选中":@"\U0000e8e9", // 已选中
    @"SUPERADMINROLLBACK":@"\U0000e8de", // SUPERADMINROLLBACK
    @"SUPERADMINEDIT":@"\U0000e8df", // SUPERADMINEDIT
    @"bofang":@"\U0000e8d9", // bofang
    @"shanchu":@"\U0000e8d8", // shanchu
    @"zhuanfa":@"\U0000e8d7", // zhuanfa
    @"quxiao":@"\U0000e8d4", // quxiao
    @"zhuanwenzi":@"\U0000e8d5", // zhuanwenzi
    @"全部":@"\U0000e8c6", // 全部
    @"业务数据":@"\U0000e8c7", // 业务数据
    @"应用":@"\U0000e8c8", // 应用
    @"同事":@"\U0000e8c9", // 同事
    @"分析图表":@"\U0000e8ca", // 分析图表
    @"文档":@"\U0000e8cb", // 文档
    @"语音":@"\U0000e8cc", // 语音
    @"消息":@"\U0000e8cd", // 消息
    @"电话":@"\U0000e8ce", // 电话
    @"搜索历史":@"\U0000e8cf", // 搜索历史
    @"saoma":@"\U0000e8c5", // saoma
    @"gouwuche":@"\U0000e8c4", // gouwuche
    @"切换":@"\U0000e706", // 切换
    @"名片":@"\U0000e8a4", // 名片
    @"加入容器":@"\U0000e705", // 加入容器
    @"群文件":@"\U0000e89f", // 群文件
    @"tuozhuai":@"\U0000e620", // tuozhuai
    @"提交":@"\U0000e880", // 提交
    @"保存":@"\U0000e61f", // 保存
    @"待办工作2":@"\U0000e876", // 待办工作2
    @"快捷入口2":@"\U0000e877", // 快捷入口2
    @"图表组件2":@"\U0000e879", // 图表组件2
    @"消息提醒2":@"\U0000e87a", // 消息提醒2
    @"我的工作2":@"\U0000e87b", // 我的工作2
    @"应用组件2":@"\U0000e87c", // 应用组件2
    @"页头应用中心":@"\U0000e868", // 页头应用中心
    @"toast-error":@"\U0000e747", // toast-error
    @"toast-success":@"\U0000e748", // toast-success
    @"toast-base":@"\U0000e749", // toast-base
    @"toast-down":@"\U0000e74a", // toast-down
    @"toast-warn":@"\U0000e74b", // toast-warn
    @"群公告":@"\U0000e743", // 群公告
    @"paixu":@"\U0000e61e", // paixu
    @"shaixuan":@"\U0000e61d", // shaixuan
    @"biaoqian":@"\U0000e61c", // biaoqian
    @"暂无数据":@"\U0000e865", // 暂无数据
    @"手电筒":@"\U0000e856", // 手电筒
    @"群资料":@"\U0000e703", // 群资料
    @"其他":@"\U0000e832", // 其他
    @"视频":@"\U0000e833", // 视频
    @"图片":@"\U0000e834", // 图片
    @"音频":@"\U0000e835", // 音频
    @"压缩":@"\U0000e836", // 压缩
    @"EXCEL":@"\U0000e837", // EXCEL
    @"PPT":@"\U0000e838", // PPT
    @"TXT":@"\U0000e839", // TXT
    @"WORD":@"\U0000e83a", // WORD
    @"PDF":@"\U0000e83b", // PDF
    @"切换门户":@"\U0000e850", // 切换门户
    @"个人":@"\U0000e6b8", // 个人
    @"明文":@"\U0000e81e", // 明文
    @"暗文":@"\U0000e81f", // 暗文
    @"注册成功-01":@"\U0000e84f", // 注册成功-01
    @"qq":@"\U0000e84c", // qq
    @"微信":@"\U0000e84d", // 微信
    @"微博":@"\U0000e84e", // 微博
    @"图表组件":@"\U0000e704", // 图表组件
    @"邮箱":@"\U0000e849", // 邮箱
    @"待办工作":@"\U0000e848", // 待办工作
    @"拨打电话":@"\U0000e845", // 拨打电话
    @"切换企业":@"\U0000e843", // 切换企业
    @"应用市场":@"\U0000e83e", // 应用市场
    @"ASSOCIATED":@"\U0000e618", // ASSOCIATED
    @"下载":@"\U0000e702", // 下载
    @"服务条款及隐私":@"\U0000e820", // 服务条款及隐私
    @"加载中":@"\U0000e615", // 加载中
    @"形状 1":@"\U0000e613", // 形状 1
    @"失败":@"\U0000e614", // 失败
    @"右侧箭头":@"\U0000e701", // 右侧箭头
    @"search_bold":@"\U0000e81d", // search_bold
    @"直接编辑":@"\U0000e700", // 直接编辑
    @"通讯录":@"\U0000e815", // 通讯录
    @"分应用_全部":@"\U0000e814", // 分应用_全部
    @"今日":@"\U0000e601", // 今日
    @"消息提醒":@"\U0000e6f4", // 消息提醒
    @"appstore":@"\U0000e6ff", // appstore
    @"数据内容":@"\U0000e6fc", // 数据内容
    @"关闭全屏":@"\U0000e6fb", // 关闭全屏
    @"清空":@"\U0000e6fa", // 清空
    @"系统权限":@"\U0000e6f9", // 系统权限
    @"编辑字段":@"\U0000e6f8", // 编辑字段
    @"配置":@"\U0000e8dd", // 配置
    @"圆":@"\U0000e6f7", // 圆
    @"我的工作":@"\U0000e6f5", // 我的工作
    @"快捷入口":@"\U0000e6f6", // 快捷入口
    @"展开小":@"\U0000e6f3", // 展开小
    @"密码安全":@"\U0000e6f2", // 密码安全
    @"定位":@"\U0000e6f1", // 定位
    @"被委托":@"\U0000e6ef", // 被委托
    @"委托":@"\U0000e6f0", // 委托
    @"火箭":@"\U0000e6eb", // 火箭
    @"门户x":@"\U0000e6ec", // 门户x
    @"门户+":@"\U0000e6ed", // 门户+
    @"门户搜索":@"\U0000e6ee", // 门户搜索
    @"暂无订单":@"\U0000e6ea", // 暂无订单
    @"取消默认":@"\U0000e6e8", // 取消默认
    @"设为默认":@"\U0000e6e9", // 设为默认
    @"工作提醒":@"\U0000e699", // 工作提醒
    @"链接":@"\U0000e694", // 链接
    @"liebiao":@"\U0000e6dd", // liebiao
    @"kanban":@"\U0000e6e3", // kanban
    @"编辑3":@"\U0000e66b", // 编辑3
    @"flash_on":@"\U0000e6df", // flash_on
    @"toggle":@"\U0000e6e0", // toggle
    @"flash_off":@"\U0000e6e1", // flash_off
    @"flash_auto":@"\U0000e6e2", // flash_auto
    @"分享":@"\U0000e6de", // 分享
    @"uorder":@"\U0000e6dc", // uorder
    @"向下展开":@"\U0000e6ba", // 向下展开
    @"来电智能识别":@"\U0000e683", // 来电智能识别
    @"左侧展开":@"\U0000e67f", // 左侧展开
    @"右侧展开":@"\U0000e6db", // 右侧展开
    @"退出讨论组":@"\U0000e67d", // 退出讨论组
    @"降序":@"\U0000e676", // 降序
    @"升序":@"\U0000e678", // 升序
    @"REFUSEENTRUST":@"\U0000e6d9", // REFUSEENTRUST
    @"RECIEVEENTRUST":@"\U0000e6da", // RECIEVEENTRUST
    @"H2":@"\U0000e66c", // H2
    @"色块":@"\U0000e66d", // 色块
    @"H3":@"\U0000e66f", // H3
    @"TEXT":@"\U0000e671", // TEXT
    @"H1":@"\U0000e672", // H1
    @"RENAME":@"\U0000e6d8", // RENAME
    @"重命名":@"\U0000e6d7", // 重命名
    @"bianji":@"\U0000e666", // bianji
    @"kongzhi":@"\U0000e66a", // kongzhi
    @"duihao":@"\U0000e663", // duihao
    @"chakan1":@"\U0000e6d5", // chakan1
    @"向右展开":@"\U0000e6d4", // 向右展开
    @"dot":@"\U0000e654", // dot
    @"A":@"\U0000e655", // A
    @"bold":@"\U0000e65a", // bold
    @"strike":@"\U0000e65b", // strike
    @"number":@"\U0000e65c", // number
    @"pic":@"\U0000e65d", // pic
    @"text":@"\U0000e65e", // text
    @"underline":@"\U0000e65f", // underline
    @"组织架构_用户":@"\U0000e612", // 组织架构_用户
    @"企业icon":@"\U0000e653", // 企业icon
    @"EDIT":@"\U0000e651", // EDIT
    @"PRINT":@"\U0000e652", // PRINT
    @"新建":@"\U0000e650", // 新建
    @"门户加载失败":@"\U0000e64f", // 门户加载失败
    @"全屏":@"\U0000e64e", // 全屏
    @"退出全屏":@"\U0000e64d", // 退出全屏
    @"催办":@"\U0000e6c9", // 催办
    @"超时":@"\U0000e6d3", // 超时
    @"zhengque":@"\U0000e64b", // zhengque
    @"bingtu":@"\U0000e640", // bingtu
    @"rili":@"\U0000e641", // rili
    @"lianjie1":@"\U0000e642", // lianjie1
    @"fujian":@"\U0000e643", // fujian
    @"shijian":@"\U0000e644", // shijian
    @"guanbi":@"\U0000e645", // guanbi
    @"shujufenxi":@"\U0000e646", // shujufenxi
    @"wenjianjia":@"\U0000e647", // wenjianjia
    @"tuandui":@"\U0000e648", // tuandui
    @"xinjian":@"\U0000e649", // xinjian
    @"chakan":@"\U0000e64a", // chakan
    @"READED":@"\U0000e636", // READED
    @"HISTORY":@"\U0000e637", // HISTORY
    @"GETBACK":@"\U0000e638", // GETBACK
    @"RECOVERWORKFLOW":@"\U0000e639", // RECOVERWORKFLOW
    @"UNFOLLOW":@"\U0000e63a", // UNFOLLOW
    @"TRANSFER":@"\U0000e63b", // TRANSFER
    @"SHARE":@"\U0000e63c", // SHARE
    @"RIGHT":@"\U0000e63d", // RIGHT
    @"URGE":@"\U0000e63e", // URGE
    @"ENTRUST":@"\U0000e63f", // ENTRUST
    @"BEYONDTIME":@"\U0000e62b", // BEYONDTIME
    @"BREAKWORKFOLW":@"\U0000e62c", // BREAKWORKFOLW
    @"BACKSPACE":@"\U0000e62d", // BACKSPACE
    @"DELETE":@"\U0000e62e", // DELETE
    @"CCWORKFLOW":@"\U0000e62f", // CCWORKFLOW
    @"CANCELENTRUST":@"\U0000e630", // CANCELENTRUST
    @"FOLLOW":@"\U0000e633", // FOLLOW
    @"DELETEWORKFLOW":@"\U0000e634", // DELETEWORKFLOW
    @"EXPORT":@"\U0000e635", // EXPORT
    @"滤镜":@"\U0000e62a", // 滤镜
    @"警告":@"\U0000e629", // 警告
    @"URL图标":@"\U0000e6fd", // URL图标
    @"图表图标":@"\U0000e6fe", // 图表图标
    @"门户highlight":@"\U0000e627", // 门户highlight
    @"门户normal":@"\U0000e628", // 门户normal
    @"清除缓存":@"\U0000e626", // 清除缓存
    @"垂直镜像":@"\U0000e6ca", // 垂直镜像
    @"涂改":@"\U0000e6cb", // 涂改
    @"旋转":@"\U0000e6cc", // 旋转
    @"水平镜像":@"\U0000e6cd", // 水平镜像
    @"马赛克":@"\U0000e6ce", // 马赛克
    @"向右旋转":@"\U0000e6cf", // 向右旋转
    @"向左旋转":@"\U0000e6d0", // 向左旋转
    @"文字":@"\U0000e6d1", // 文字
    @"裁剪":@"\U0000e6d2", // 裁剪
    @"已拒绝":@"\U0000e624", // 已拒绝
    @"已接受":@"\U0000e625", // 已接受
    @"启小秘":@"\U0000e61b", // 启小秘
    @"工作动态":@"\U0000e6c3", // 工作动态
    @"提到我的":@"\U0000e6c4", // 提到我的
    @"我评价的":@"\U0000e6c5", // 我评价的
    @"组织架构变动":@"\U0000e6c6", // 组织架构变动
    @"系统消息":@"\U0000e6c7", // 系统消息
    @"工作交办":@"\U0000e6c8", // 工作交办
    @"二维码":@"\U0000e6d6", // 二维码
    @"文件":@"\U0000e6bb", // 文件
    @"查看":@"\U0000e6bc", // 查看
    @"正确":@"\U0000e6bd", // 正确
    @"日历":@"\U0000e6be", // 日历
    @"视图分析":@"\U0000e6bf", // 视图分析
    @"user":@"\U0000e6c0", // user
    @"附件":@"\U0000e6c1", // 附件
    @"连接":@"\U0000e6c2", // 连接
    @"即时消息":@"\U0000e6b7", // 即时消息
    @"语音输入":@"\U0000e6b9", // 语音输入
    @"批量操作":@"\U0000e6a1", // 批量操作
    @"后退一步":@"\U0000e6a6", // 后退一步
    @"前进一步":@"\U0000e6a7", // 前进一步
    @"排序":@"\U0000e6a8", // 排序
    @"搜索应用":@"\U0000e6a9", // 搜索应用
    @"启聊normal":@"\U0000e6aa", // 启聊normal
    @"仪表盘normal":@"\U0000e6ab", // 仪表盘normal
    @"启聊hightlighted":@"\U0000e6ac", // 启聊hightlighted
    @"筛选":@"\U0000e6ad", // 筛选
    @"仪表盘hightlighted":@"\U0000e6ae", // 仪表盘hightlighted
    @"同事":@"\U0000e6af", // 同事
    @"应用hightlighted":@"\U0000e6b0", // 应用hightlighted
    @"发现hightlighted":@"\U0000e6b1", // 发现hightlighted
    @"工作hightlighted":@"\U0000e6b2", // 工作hightlighted
    @"应用normal":@"\U0000e6b3", // 应用normal
    @"发现normal":@"\U0000e6b4", // 发现normal
    @"工作":@"\U0000e6b5", // 工作
    @"工作normal":@"\U0000e6b6", // 工作normal
    @"关于企业云":@"\U0000e688", // 关于企业云
    @"喇叭":@"\U0000e689", // 喇叭
    @"蓝牙":@"\U0000e68a", // 蓝牙
    @"评论":@"\U0000e68b", // 评论
    @"扫码":@"\U0000e68c", // 扫码
    @"密码修改":@"\U0000e68d", // 密码修改
    @"返回":@"\U0000e68e", // 返回
    @"上传附件":@"\U0000e68f", // 上传附件
    @"企业切换":@"\U0000e690", // 企业切换
    @"搜索历史":@"\U0000e691", // 搜索历史
    @"讨论":@"\U0000e692", // 讨论
    @"搜索":@"\U0000e693", // 搜索
    @"添加":@"\U0000e695", // 添加
    @"添加评论":@"\U0000e696", // 添加评论
    @"我的钱包":@"\U0000e697", // 我的钱包
    @"我评论的":@"\U0000e698", // 我评论的
    @"消息中心":@"\U0000e69a", // 消息中心
    @"下载附件":@"\U0000e69b", // 下载附件
    @"数据分析":@"\U0000e69c", // 数据分析
    @"账号切换":@"\U0000e69d", // 账号切换
    @"组织架构":@"\U0000e69f", // 组织架构
    @"最新动态":@"\U0000e6a0", // 最新动态
    @"账号安全":@"\U0000e6a2", // 账号安全
    @"绑定手机":@"\U0000e6a3", // 绑定手机
    @"账号托管":@"\U0000e6a4", // 账号托管
    @"指纹验证":@"\U0000e6a5", // 指纹验证
    @"更多":@"\U0000e685", // 更多
    @"反馈帮助":@"\U0000e686", // 反馈帮助
    @"绑定邮箱":@"\U0000e687", // 绑定邮箱
    @"报表":@"\U0000e656", // 报表
    @"饼状图":@"\U0000e657", // 饼状图
    @"编辑2":@"\U0000e658", // 编辑2
    @"编辑":@"\U0000e659", // 编辑
    @"堆积图":@"\U0000e660", // 堆积图
    @"复制":@"\U0000e661", // 复制
    @"更多横":@"\U0000e662", // 更多横
    @"关闭":@"\U0000e664", // 关闭
    @"更多竖":@"\U0000e665", // 更多竖
    @"地图":@"\U0000e667", // 地图
    @"控制图":@"\U0000e668", // 控制图
    @"雷达图":@"\U0000e669", // 雷达图
    @"计量图":@"\U0000e66e", // 计量图
    @"散点图":@"\U0000e670", // 散点图
    @"收起":@"\U0000e673", // 收起
    @"条形图":@"\U0000e674", // 条形图
    @"提示":@"\U0000e675", // 提示
    @"选中":@"\U0000e677", // 选中
    @"未选中":@"\U0000e679", // 未选中
    @"展开":@"\U0000e67a", // 展开
    @"下拉":@"\U0000e67b", // 下拉
    @"展开大":@"\U0000e67c", // 展开大
    @"折线图":@"\U0000e67e", // 折线图
    @"柱状图":@"\U0000e680", // 柱状图
    @"圆环图":@"\U0000e681", // 圆环图
    @"总值图":@"\U0000e682", // 总值图
    @"直方图":@"\U0000e684", // 直方图
    @"APP指标-01":@"\U0000e631", // APP指标-01
    @"APP计量-01":@"\U0000e632", // APP计量-01
    @"":@""};
}

+ (NSDictionary *)appIconDictionary { //
    if (!_appIconDictionary) {
        _appIconDictionary = @{
            @"qy-basis-001" : @"\U0000e9bb",            // basis-001
            @"qy-basis-008" : @"\U0000e9bc",            // basis-008
            @"qy-basis-009" : @"\U0000e9bd",            // basis-009
            @"qy-basis-013" : @"\U0000e9be",            // basis-013
            @"qy-basis-010" : @"\U0000e9bf",            // basis-010
            @"qy-basis-011" : @"\U0000e9c0",            // basis-011
            @"qy-basis-002" : @"\U0000e9c1",            // basis-002
            @"qy-basis-004" : @"\U0000e9c2",            // basis-004
            @"qy-basis-006" : @"\U0000e9c3",            // basis-006
            @"qy-basis-005" : @"\U0000e9c4",            // basis-005
            @"qy-basis-012" : @"\U0000e9c5",            // basis-012
            @"qy-basis-003" : @"\U0000e9c6",            // basis-003
            @"qy-basis-007" : @"\U0000e9c7",            // basis-007
            @"qy-business-1" : @"\U0000e99e",           // business-1
            @"qy-business-4" : @"\U0000e99f",           // business-4
            @"qy-business-2" : @"\U0000e9a0",           // business-2
            @"qy-business-13" : @"\U0000e9a1",          // business-13
            @"qy-business-7" : @"\U0000e9a2",           // business-7
            @"qy-business-10" : @"\U0000e9a3",          // business-10
            @"qy-business-5" : @"\U0000e9a4",           // business-5
            @"qy-business-6" : @"\U0000e9a5",           // business-6
            @"qy-business-3" : @"\U0000e9a6",           // business-3
            @"qy-business-8" : @"\U0000e9a7",           // business-8
            @"qy-business-16" : @"\U0000e9a8",          // business-16
            @"qy-business-15" : @"\U0000e9a9",          // business-15
            @"qy-business-12" : @"\U0000e9aa",          // business-12
            @"qy-business-14" : @"\U0000e9ab",          // business-14
            @"qy-business-19" : @"\U0000e9ac",          // business-19
            @"qy-business-22" : @"\U0000e9ad",          // business-22
            @"qy-business-20" : @"\U0000e9ae",          // business-20
            @"qy-business-9" : @"\U0000e9af",           // business-9
            @"qy-business-28" : @"\U0000e9b0",          // business-28
            @"qy-business-23" : @"\U0000e9b1",          // business-23
            @"qy-business-25" : @"\U0000e9b2",          // business-25
            @"qy-business-21" : @"\U0000e9b3",          // business-21
            @"qy-business-18" : @"\U0000e9b4",          // business-18
            @"qy-business-29" : @"\U0000e9b5",          // business-29
            @"qy-business-27" : @"\U0000e9b6",          // business-27
            @"qy-business-24" : @"\U0000e9b7",          // business-24
            @"qy-business-26" : @"\U0000e9b8",          // business-26
            @"qy-business-11" : @"\U0000e9b9",          // business-11
            @"qy-business-17" : @"\U0000e9ba",          // business-17
            @"qy-basis-1" : @"\U0000e991",              // basis-1
            @"qy-basis-2" : @"\U0000e992",              // basis-2
            @"qy-basis-8" : @"\U0000e993",              // basis-8
            @"qy-basis-5" : @"\U0000e994",              // basis-5
            @"qy-basis-10" : @"\U0000e995",             // basis-10
            @"qy-basis-13" : @"\U0000e996",             // basis-13
            @"qy-basis-11" : @"\U0000e997",             // basis-11
            @"qy-basis-7" : @"\U0000e998",              // basis-7
            @"qy-basis-6" : @"\U0000e999",              // basis-6
            @"qy-basis-3" : @"\U0000e99a",              // basis-3
            @"qy-basis-9" : @"\U0000e99b",              // basis-9
            @"qy-basis-4" : @"\U0000e99c",              // basis-4
            @"qy-basis-12" : @"\U0000e99d",             // basis-12
            @"qy-wuyou-01" : @"\U0000e94c",             // wuyou-01
            @"qy-wuyou-02" : @"\U0000e94d",             // wuyou-02
            @"qy-wuyou-04" : @"\U0000e94e",             // wuyou-04
            @"qy-wuyou-13" : @"\U0000e94f",             // wuyou-13
            @"qy-wuyou-07" : @"\U0000e950",             // wuyou-07
            @"qy-wuyou-06" : @"\U0000e951",             // wuyou-06
            @"qy-wuyou-03" : @"\U0000e952",             // wuyou-03
            @"qy-wuyou-08" : @"\U0000e953",             // wuyou-08
            @"qy-wuyou-09" : @"\U0000e954",             // wuyou-09
            @"qy-wuyou-16" : @"\U0000e955",             // wuyou-16
            @"qy-wuyou-18" : @"\U0000e956",             // wuyou-18
            @"qy-wuyou-12" : @"\U0000e957",             // wuyou-12
            @"qy-wuyou-20" : @"\U0000e958",             // wuyou-20
            @"qy-wuyou-05" : @"\U0000e959",             // wuyou-05
            @"qy-wuyou-10" : @"\U0000e95a",             // wuyou-10
            @"qy-wuyou-29" : @"\U0000e95b",             // wuyou-29
            @"qy-wuyou-28" : @"\U0000e95c",             // wuyou-28
            @"qy-wuyou-17" : @"\U0000e95d",             // wuyou-17
            @"qy-wuyou-24" : @"\U0000e95e",             // wuyou-24
            @"qy-wuyou-30" : @"\U0000e95f",             // wuyou-30
            @"qy-wuyou-21" : @"\U0000e960",             // wuyou-21
            @"qy-wuyou-32" : @"\U0000e961",             // wuyou-32
            @"qy-wuyou-14" : @"\U0000e962",             // wuyou-14
            @"qy-wuyou-42" : @"\U0000e963",             // wuyou-42
            @"qy-wuyou-36" : @"\U0000e964",             // wuyou-36
            @"qy-wuyou-40" : @"\U0000e965",             // wuyou-40
            @"qy-wuyou-15" : @"\U0000e966",             // wuyou-15
            @"qy-wuyou-25" : @"\U0000e967",             // wuyou-25
            @"qy-wuyou-43" : @"\U0000e968",             // wuyou-43
            @"qy-wuyou-26" : @"\U0000e969",             // wuyou-26
            @"qy-wuyou-34" : @"\U0000e96a",             // wuyou-34
            @"qy-wuyou-11" : @"\U0000e96b",             // wuyou-11
            @"qy-wuyou-37" : @"\U0000e96c",             // wuyou-37
            @"qy-wuyou-48" : @"\U0000e96d",             // wuyou-48
            @"qy-wuyou-45" : @"\U0000e96e",             // wuyou-45
            @"qy-wuyou-52" : @"\U0000e96f",             // wuyou-52
            @"qy-wuyou-41" : @"\U0000e970",             // wuyou-41
            @"qy-wuyou-31" : @"\U0000e971",             // wuyou-31
            @"qy-wuyou-46" : @"\U0000e972",             // wuyou-46
            @"qy-wuyou-38" : @"\U0000e973",             // wuyou-38
            @"qy-wuyou-56" : @"\U0000e974",             // wuyou-56
            @"qy-wuyou-39" : @"\U0000e975",             // wuyou-39
            @"qy-wuyou-60" : @"\U0000e976",             // wuyou-60
            @"qy-wuyou-49" : @"\U0000e977",             // wuyou-49
            @"qy-wuyou-50" : @"\U0000e978",             // wuyou-50
            @"qy-wuyou-27" : @"\U0000e979",             // wuyou-27
            @"qy-wuyou-58" : @"\U0000e97a",             // wuyou-58
            @"qy-wuyou-57" : @"\U0000e97b",             // wuyou-57
            @"qy-wuyou-22" : @"\U0000e97c",             // wuyou-22
            @"qy-wuyou-19" : @"\U0000e97d",             // wuyou-19
            @"qy-wuyou-35" : @"\U0000e97e",             // wuyou-35
            @"qy-wuyou-54" : @"\U0000e97f",             // wuyou-54
            @"qy-wuyou-47" : @"\U0000e980",             // wuyou-47
            @"qy-wuyou-51" : @"\U0000e981",             // wuyou-51
            @"qy-wuyou-44" : @"\U0000e982",             // wuyou-44
            @"qy-wuyou-23" : @"\U0000e983",             // wuyou-23
            @"qy-wuyou-33" : @"\U0000e984",             // wuyou-33
            @"qy-wuyou-55" : @"\U0000e985",             // wuyou-55
            @"qy-wuyou-53" : @"\U0000e986",             // wuyou-53
            @"qy-wuyou-59" : @"\U0000e987",             // wuyou-59
            @"qy-gongzuotai" : @"\U0000e90b",           // gongzuotai
            @"qy-shujudaping" : @"\U0000e90c",          // shujudaping
            @"qy-yingyongzhongxin" : @"\U0000e90d",     // yingyongzhongxin
            @"qy-qiliao" : @"\U0000e90e",               // qiliao
            @"qy-yibiaopan" : @"\U0000e90f",            // yibiaopan
            @"qy-zhonghua-4" : @"\U0000e8ca",           // zhonghua-4
            @"qy-zhonghua-0" : @"\U0000e8c7",           // zhonghua-0
            @"qy-zhonghua-1" : @"\U0000e8c8",           // zhonghua-1
            @"qy-zhonghua-6" : @"\U0000e8c9",           // zhonghua-6
            @"qy-zhonghua-8" : @"\U0000e8cb",           // zhonghua-8
            @"qy-zhonghua-5" : @"\U0000e8cc",           // zhonghua-5
            @"qy-zhonghua-3" : @"\U0000e8cd",           // zhonghua-3
            @"qy-zhonghua-7" : @"\U0000e8ce",           // zhonghua-7
            @"qy-zhonghua-2" : @"\U0000e8cf",           // zhonghua-2
            @"qy-人脸识别" : @"\U0000e8c6",             // 人脸识别
            @"qy-custom100" : @"\U0000e6e3",            // custom100
            @"qy-gongzuoquan" : @"\U0000e88b",          // gongzuoquan
            @"qy-saoyisao" : @"\U0000e888",             // saoyisao
            @"qy-souyisou" : @"\U0000e889",             // souyisou
            @"qy-announcement" : @"\U0000e789",         // announcement
            @"qy-work_order" : @"\U0000e841",           // work_order
            @"qy-custom65" : @"\U0000e882",             // custom65
            @"qy-custom15" : @"\U0000e850",             // custom15
            @"qy-custom17" : @"\U0000e852",             // custom17
            @"qy-custom19" : @"\U0000e854",             // custom19
            @"qy-custom21" : @"\U0000e855",             // custom21
            @"qy-custom30" : @"\U0000e860",             // custom30
            @"qy-custom43" : @"\U0000e86c",             // custom43
            @"qy-custom71" : @"\U0000e876",             // custom71
            @"qy-custom55" : @"\U0000e879",             // custom55
            @"qy-custom60" : @"\U0000e87e",             // custom60
            @"qy-custom62" : @"\U0000e880",             // custom62
            @"qy-custom67" : @"\U0000e885",             // custom67
            @"qy-custom74" : @"\U0000e88a",             // custom74
            @"qy-custom82" : @"\U0000e894",             // custom82
            @"qy-custom88" : @"\U0000e89a",             // custom88
            @"qy-custom90" : @"\U0000e89c",             // custom90
            @"qy-custom91" : @"\U0000e89d",             // custom91
            @"qy-custom93" : @"\U0000e89f",             // custom93
            @"qy-custom94" : @"\U0000e8a1",             // custom94
            @"qy-custom98" : @"\U0000e8a6",             // custom98
            @"qy-custom101" : @"\U0000e8a7",            // custom101
            @"qy-custom102" : @"\U0000e8a8",            // custom102
            @"qy-custom103" : @"\U0000e8a9",            // custom103
            @"qy-custom108" : @"\U0000e8ae",            // custom108
            @"qy-custom110" : @"\U0000e8af",            // custom110
            @"qy-custom111" : @"\U0000e8b0",            // custom111
            @"qy-custom112" : @"\U0000e8b1",            // custom112
            @"qy-custom113" : @"\U0000e8b2",            // custom113
            @"qy-earth" : @"\U0000e8b3",                // earth
            @"qy-work_order_item" : @"\U0000e785",      // work_order_item
            @"qy-work_type" : @"\U0000e786",            // work_type
            @"qy-account" : @"\U0000e787",              // account
            @"qy-action_list_componen" : @"\U0000e788", // action_list_componen
            @"qy-answer_best" : @"\U0000e78a",          // answer_best
            @"qy-address" : @"\U0000e78b",              // address
            @"qy-approval" : @"\U0000e78c",             // approval
            @"qy-answer_public" : @"\U0000e78d",        // answer_public
            @"qy-answer_private" : @"\U0000e78e",       // answer_private
            @"qy-apps_admin" : @"\U0000e78f",           // apps_admin
            @"qy-apps" : @"\U0000e790",                 // apps
            @"qy-asset_relationship" : @"\U0000e791",   // asset_relationship
            @"qy-article" : @"\U0000e792",              // article
            @"qy-avatar" : @"\U0000e793",               // avatar
            @"qy-assigned_resource" : @"\U0000e794",    // assigned_resource
            @"qy-avatar_loading" : @"\U0000e795",       // avatar_loading
            @"qy-bot" : @"\U0000e796",                  // bot
            @"qy-business_hours" : @"\U0000e797",       // business_hours
            @"qy-call" : @"\U0000e798",                 // call
            @"qy-call_history" : @"\U0000e799",         // call_history
            @"qy-campaign_members" : @"\U0000e79a",     // campaign_members
            @"qy-canvas" : @"\U0000e79c",               // canvas
            @"qy-channel_programs" : @"\U0000e79d",     // channel_programs
            @"qy-carousel" : @"\U0000e79e",             // carousel
            @"qy-case" : @"\U0000e79f",                 // case
            @"qy-case_change_status" : @"\U0000e7a0",   // case_change_status
            @"qy-case_comment" : @"\U0000e7a1",         // case_comment
            @"qy-case_email" : @"\U0000e7a2",           // case_email
            @"qy-calibration" : @"\U0000e7a5",          // calibration
            @"qy-case_transcript" : @"\U0000e7a6",      // case_transcript
            @"qy-channel_program_hist" : @"\U0000e7a7", // channel_program_hist
            @"qy-channel_program_leve" : @"\U0000e7a8", // channel_program_leve
            @"qy-cms" : @"\U0000e7a9",                  // cms
            @"qy-channel_program_memb" : @"\U0000e7aa", // channel_program_memb
            @"qy-client" : @"\U0000e7ab",               // client
            @"qy-coaching" : @"\U0000e7ac",             // coaching
            @"qy-connected_apps" : @"\U0000e7ad",       // connected_apps
            @"qy-contact" : @"\U0000e7ae",              // contact
            @"qy-contract_line_item" : @"\U0000e7af",   // contract_line_item
            @"qy-contact_list" : @"\U0000e7b0",         // contact_list
            @"qy-custom" : @"\U0000e7b1",               // custom
            @"qy-contract" : @"\U0000e7b2",             // contract
            @"qy-custom_notification" : @"\U0000e7b3",  // custom_notification
            @"qy-customers" : @"\U0000e7b4",            // customers
            @"qy-event" : @"\U0000e7b5",                // event
            @"qy-dashboard" : @"\U0000e7b6",            // dashboard
            @"qy-data_integration_hub" : @"\U0000e7b7", // data_integration_hub
            @"qy-default" : @"\U0000e7b8",              // default
            @"qy-datadotcom" : @"\U0000e7b9",           // datadotcom
            @"qy-document" : @"\U0000e7ba",             // document
            @"qy-drafts" : @"\U0000e7bb",               // drafts
            @"qy-email_chatter" : @"\U0000e7bd",        // email_chatter
            @"qy-empty" : @"\U0000e7be",                // empty
            @"qy-endorsement" : @"\U0000e7bf",          // endorsement
            @"qy-entitlement" : @"\U0000e7c0",          // entitlement
            @"qy-entitlement_template" : @"\U0000e7c2", // entitlement_template
            @"qy-environment_hub" : @"\U0000e7c4",      // environment_hub
            @"qy-feed" : @"\U0000e7c6",                 // feed
            @"qy-feedback" : @"\U0000e7c7",             // feedback
            @"qy-file" : @"\U0000e7c8",                 // file
            @"qy-forecasts" : @"\U0000e7ca",            // forecasts
            @"qy-flow" : @"\U0000e7cb",                 // flow
            @"qy-goals" : @"\U0000e7cc",                // goals
            @"qy-group_loading" : @"\U0000e7cd",        // group_loading
            @"qy-generic_loading" : @"\U0000e7ce",      // generic_loading
            @"qy-home" : @"\U0000e7cf",                 // home
            @"qy-hierarchy" : @"\U0000e7d0",            // hierarchy
            @"qy-groups" : @"\U0000e7d1",               // groups
            @"qy-individual" : @"\U0000e7d2",           // individual
            @"qy-household" : @"\U0000e7d3",            // household
            @"qy-investment_account" : @"\U0000e7d4",   // investment_account
            @"qy-lead" : @"\U0000e7d7",                 // lead
            @"qy-knowledge" : @"\U0000e7d8",            // knowledge
            @"qy-link" : @"\U0000e7da",                 // link
            @"qy-list_email" : @"\U0000e7db",           // list_email
            @"qy-live_chat" : @"\U0000e7dc",            // live_chat
            @"qy-live_chat_visitor" : @"\U0000e7dd",    // live_chat_visitor
            @"qy-log_a_call" : @"\U0000e7e0",           // log_a_call
            @"qy-lead_list" : @"\U0000e7e1",            // lead_list
            @"qy-maintenance_asset" : @"\U0000e7e3",    // maintenance_asset
            @"qy-maintenance_plan" : @"\U0000e7e4",     // maintenance_plan
            @"qy-marketing_actions" : @"\U0000e7e5",    // marketing_actions
            @"qy-merge" : @"\U0000e7e6",                // merge
            @"qy-metrics" : @"\U0000e7ea",              // metrics
            @"qy-note" : @"\U0000e7ec",                 // note
            @"qy-omni_supervisor" : @"\U0000e7ed",      // omni_supervisor
            @"qy-orders" : @"\U0000e7f1",               // orders
            @"qy-partner_fund_request" : @"\U0000e7f3", // partner_fund_request
            @"qy-partners" : @"\U0000e7f6",             // partners
            @"qy-people" : @"\U0000e7f8",               // people
            @"qy-performance" : @"\U0000e7f9",          // performance
            @"qy-poll" : @"\U0000e7fb",                 // poll
            @"qy-person_account" : @"\U0000e7fd",       // person_account
            @"qy-pricebook" : @"\U0000e7ff",            // pricebook
            @"qy-product_item" : @"\U0000e801",         // product_item
            @"qy-product_transfer" : @"\U0000e807",     // product_transfer
            @"qy-product_required" : @"\U0000e808",     // product_required
            @"qy-question_best" : @"\U0000e809",        // question_best
            @"qy-recent" : @"\U0000e810",               // recent
            @"qy-read_receipts" : @"\U0000e811",        // read_receipts
            @"qy-report" : @"\U0000e814",               // report
            @"qy-record" : @"\U0000e819",               // record
            @"qy-reward" : @"\U0000e81c",               // reward
            @"qy-search" : @"\U0000e820",               // search
            @"qy-service_contract" : @"\U0000e821",     // service_contract
            @"qy-service_appointment" : @"\U0000e822",  // service_appointment
            @"qy-service_crew_member" : @"\U0000e823",  // service_crew_member
            @"qy-service_crew" : @"\U0000e824",         // service_crew
            @"qy-service_resource" : @"\U0000e826",     // service_resource
            @"qy-service_territory_lo" : @"\U0000e828", // service_territory_lo
            @"qy-shipment" : @"\U0000e82a",             // shipment
            @"qy-skill" : @"\U0000e82c",                // skill
            @"qy-skill_requirement" : @"\U0000e82d",    // skill_requirement
            @"qy-social" : @"\U0000e82e",               // social
            @"qy-task" : @"\U0000e834",                 // task
            @"qy-team_member" : @"\U0000e836",          // team_member
            @"qy-topic" : @"\U0000e83c",                // topic
            @"qy-timesheet" : @"\U0000e83f",            // timesheet
            @"qy-user" : @"\U0000e840",                 // user
            @"qy-custom2" : @"\U0000e842",              // custom2
            @"qy-custom5" : @"\U0000e845",              // custom5
            @"qy-custom1" : @"\U0000e848",              // custom1
            @"qy-custom9" : @"\U0000e84b",              // custom9
            @"qy-custom11" : @"\U0000e84c",             // custom11
            @"" : @""
        };
    }
    return _appIconDictionary;
}

+ (NSString *)fontName {
    return @"qycloudiconfont";
}

+ (NSString *)appFontName {
    return @"qycloud";
}

+ (NSString *)bottomTabFontName {
    return @"tabicon";
}

+ (NSString *)nameToUnicode:(NSString *)name {
    NSString *code = [self imageCodeWithImageName:name];
    return code ?: name;
}

+ (NSString *)imageCodeWithImageName:(NSString *)imageName {
    NSDictionary *nameToUnicode = nil;
    if ([imageName hasPrefix:@"qy-"]) {
        nameToUnicode = [self appIconDictionary];
    }
    else if ([imageName hasPrefix:@"tab-"]) {
        nameToUnicode = [self bottomTabIconDictionary];
    }
    else {
        nameToUnicode = [self IconDictionary];
    }

    NSString *code = nameToUnicode[imageName];
    if (code == nil || code.length == 0) {
        return nil;
    }
    return code;
}

+ (NSString *)fontNameSourceWithIconName:(NSString *)iconName {
    NSString *fontName = nil;
    if ([iconName hasPrefix:@"qy-"]) {
        fontName = [self appFontName];
    }
    else if ([iconName hasPrefix:@"tab-"]) {
        fontName = [self bottomTabFontName];
    }
    else {
        fontName = [self fontName];
    }

    return fontName ?: iconName;
}

//主方法
+ (UIImage *)iconWithName:(NSString *)name fontSize:(CGFloat)size color:(UIColor *)color inset:(UIEdgeInsets)inset withBackgroundColor:(UIColor *)backgroundColor {
    NSString *code       = [self nameToUnicode:name];
    TBCityIconInfo *info = [TBCityIconInfo iconInfoWithText:code size:size color:color inset:inset];
    if (backgroundColor) {
        info.backgroundColor = backgroundColor;
    }
    NSString *fontName = [self fontNameSourceWithIconName:name];
    info.fontName      = fontName ?: nil;
    return [UIImage iconWithInfo:info];
}

+ (NSMutableAttributedString *)attributedStringIconWithName:(NSString *)name fontSize:(CGFloat)size color:(UIColor *)color {
    NSString *fontName              = [self fontNameSourceWithIconName:name];
    UIFont *iconfont                = [TBCityIconFont fontWithSize:size withFontName:fontName];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[self nameToUnicode:name] attributes:@{NSFontAttributeName : iconfont ?: [UIFont systemFontOfSize:size], NSForegroundColorAttributeName : color}];
    return text;
}

@end
