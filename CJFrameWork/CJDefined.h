
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "YYKit.h"
#import "CJUIButton.h"
#import "CJUserManager.h"
#import "CJController.h"
#import "CJExtensions.h"



#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;


#define CJHTTP_URL @"http://121.41.7.46/"


//应用程序版本号
#define CJBundleVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

// 返回 App 文件根目录下的 Documents 文件夹路径
#define CJAppDocuments      [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

// 返回 App 文件根目录下的 Library 文件夹路径
#define CJAppLibrarys [NSHomeDirectory() stringByAppendingPathComponent:@"Library"]


//返回设备物理高度/宽度
#define CJScreenHeight     [UIScreen mainScreen].bounds.size.height
#define CJScreenWidth      [UIScreen mainScreen].bounds.size.width


//常规字体大小
#define CJFontSize(fontSize)      [UIFont systemFontOfSize:fontSize]

//颜色
#define CJColorWhite            RGB(255, 255, 255)     //白色
#define CJColorBlack            RGB(68 ,68, 68)        //黑色
#define CJColorMotif            RGB(255, 150, 0)       //主题颜色
#define CJColorFont             RGB(255, 190, 163)     //字体颜色
#define CJColorBackGround       RGB(233 ,233, 233)     //背景颜色
#define CJColorLine             RGB(213 ,213, 213)     //线条颜色
#define CJColorTime             RGB(166 ,166, 166)     //时间颜色






typedef void (^getBackBlock)(id anything);
typedef void (^getBackDataBlock)(NSData* data);
typedef void (^getFailBlock)();
typedef void (^doBlock)();
typedef void (^getErrorBlock)(int code,NSString *message);



//开发版本/发布版本
#define APP_DEBUG_MEMORY            @"APP_DEBUG_MEMORY"
#define APP_DEBUG                   @"APP_DEBUG"



//调试
#ifdef APP_DEBUG
#define CJNSLog(format, ...) NSLog(format,##__VA_ARGS__)
#else
#define CJNSLog(format, ...)
#endif







