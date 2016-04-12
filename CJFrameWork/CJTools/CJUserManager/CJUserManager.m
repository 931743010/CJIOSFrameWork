//
//  CJUserManager.m
//  CJFrameWork
//
//  Created by 程健 on 16/3/11.
//  Copyright © 2016年 程健. All rights reserved.
//

#import "CJUserManager.h"

@implementation CJUserManager
//-(void)setUserModel:(UserModel *)userModel
//{
//    _userModel = userModel;
//    
//    [[NSUserDefaults standardUserDefaults]setObject:[_userModel toJSONString] forKey:@"user"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_CHANGE object:_userModel];
//}
//
//- (void)storeUserModel
//{
//    [[NSUserDefaults standardUserDefaults]setObject:[_userModel toJSONString] forKey:@"user"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (BOOL)isLogin
//{
//    return _userModel && _userModel.userid;
//}


- (void)clean
{
//    _userModel = nil;
//    [DBHELPER loginOut];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"user"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

////访问login或者reg网络成功
//- (void)loginRequiteSuccess:(UserModel *)userModel
//{
//    [self setUserModel:userModel];
//    //根据账号新建数据库
//    [self createDBAfterLogin];
//}

//#pragma mark - common
//- (id)init{
//    self=[super init];
//    if (self) {
//        _userModel = [JsonParser parseUserModel:[[NSUserDefaults standardUserDefaults]objectForKey:@"user"]];
//    }
//    return self;
//}
//
//// 登录了就返回userid，未登录就返回@“”
//- (NSString *)getUserId
//{
//    return _userModel?_userModel.userid:@"";
//}
//
//
//
////如果用户是二次登录，展开数据库
//- (void)createDBAfterLogin
//{
//    //记住账号了，展开数据库
//    DBHELPER;
//}
//
//+ (id)sharedUserManager{
//    static UserManager *_sharedUserManager=nil;
//    static dispatch_once_t predUser;
//    dispatch_once(&predUser, ^{
//        _sharedUserManager=[[UserManager alloc] init];
//    });
//    return _sharedUserManager;
//}

////修改某项资料
//- (void)editInfoStart:(NSString*)content withEventKey:(NSString*)eventKey withSuccessBlock:(getBackBlock)emptyBlock andFailBlock:(getErrorBlock)errorBlock
//{
//    [WEBSERVES editInfo:content withEventKey:eventKey withSuccessBlock:^(NSData *data){
//        UserResponse *tempResponse = [JsonParser parseUserResponse:data];
//        if (tempResponse.isSuccess) {
//            UserModel *tempModel =  tempResponse.data;
//            
//            [_userModel setAge:tempModel.age];
//            [_userModel setAvatar:tempModel.avatar];
//            [_userModel setSex:tempModel.sex];
//            [_userModel setIntro:tempModel.intro];
//            [_userModel setPersonalTags:tempModel.personalTags];
//            [_userModel setName:tempModel.name];
//            [_userModel setBackground:tempModel.background];
//            
//            [self setUserModel:_userModel];
//            if (emptyBlock) {
//                emptyBlock(nil);
//            }
//        } else if (errorBlock) {
//            errorBlock(0,tempResponse.message);
//        }
//    } andFailBlock:^{
//        if (errorBlock) {
//            errorBlock(-1,@"网络访问失败");
//        }
//    }];
//}
//
//
//
//-(void)resetDynamicCount:(NSNumber *)newDynamicCount
//{
//    if (newDynamicCount && [newDynamicCount intValue]>=0) {
//        [USERMANAGE userModel].topicCount = newDynamicCount;
//        [USERMANAGE storeUserModel];
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ACTION_COUNT_CHANGE object:nil];
//    }
//}
@end
