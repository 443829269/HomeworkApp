//
//  UserDataObject.h
//  HomeworkApp
//
//  Created by 林立 on 16/1/1.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface UserDataObject : NSManagedObject

//学号
@property (nonatomic,copy) NSString *usernumber;

//Session
@property (nonatomic,copy) NSString *session;

//最后登录时间
@property (nonatomic,copy) NSString *lasttime;

@end
