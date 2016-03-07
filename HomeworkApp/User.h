//
//  User.h
//  HomeworkApp
//
//  Created by 林立 on 15/12/31.
//  Copyright © 2015年 ZweiL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

//学号
@property (nonatomic,copy) NSString *usernumber;

//Session
@property (nonatomic,copy) NSString *session;

//最后登录时间
@property (nonatomic,copy) NSString *lasttime;


- (instancetype)initWithUser:(NSString *)usernumber WithSession:(NSString *)session WithLasttime:(NSString *)lasttime;

+ (instancetype)userWithUser:(NSString *)usernumber WithSession:(NSString *)session WithLasttime:(NSString *)lasttime;

@end
