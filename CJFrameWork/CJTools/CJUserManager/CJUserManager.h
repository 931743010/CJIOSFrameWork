//
//  CJUserManager.h
//  CJFrameWork
//
//  Created by 程健 on 16/3/11.
//  Copyright © 2016年 程健. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CJUSERMANAGE [CJUserManager sharedUserManager]

@interface CJUserManager : NSObject
{
    
    
}

//@property (nonatomic, retain) UserModel *userModel;

+ (id)sharedUserManager;
- (BOOL)isLogin;

// 登录了就返回userid，未登录就返回@“”
- (NSString *)getUserId;


//重新保存下_usermodel
- (void)storeUserModel;

//如果用户是二次登录，展开数据库
- (void)createDBAfterLogin;

//退出
- (void)clean;

//访问login或者reg接口成功
//- (void)loginRequiteSuccess:(UserModel *)userModel;

////更新动态数量
//-(void)resetDynamicCount:(NSNumber *)newDynamicCount;
//
////修改某项资料
//- (void)editInfoStart:(NSString*)content withEventKey:(NSString*)eventKey withSuccessBlock:(getBackBlock)emptyBlock andFailBlock:(getErrorBlock)errorBlock;
@end
