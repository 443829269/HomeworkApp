//
//  Connect.h
//  HomeworkApp
//
//  Created by 林立 on 15/12/31.
//  Copyright © 2015年 ZweiL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connect : NSObject

//Session
@property (nonatomic,copy) NSString *Session;

//Time
@property (nonatomic,copy) NSString *dateString;

- (instancetype)initWithUsername:(NSString *)usernumber Withpassword:(NSString *)password;
+ (instancetype)connectWithUsername:(NSString *)usernumber WithPassword:(NSString *)password;
@end
