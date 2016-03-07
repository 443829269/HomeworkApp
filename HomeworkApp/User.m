//
//  User.m
//  HomeworkApp
//
//  Created by 林立 on 15/12/31.
//  Copyright © 2015年 ZweiL. All rights reserved.
//

#import "User.h"
#import "Lesson.h"
#import "Work.h"

@implementation User

- (instancetype)initWithUser:(NSString *)usernumber WithSession:(NSString *)session WithLasttime:(NSString *)lasttime{
    if (self = [super init]){
        self.usernumber = usernumber;
        self.session = session;
        self.lasttime = lasttime;
    }
    return self;
}

+ (instancetype)userWithUser:(NSString *)usernumber WithSession:(NSString *)session WithLasttime:(NSString *)lasttime{
    return [[self alloc]initWithUser:usernumber WithSession:session WithLasttime:lasttime];
}

@end
