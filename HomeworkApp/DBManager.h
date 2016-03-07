//
//  DBManager.h
//  HomeworkApp
//
//  Created by 林立 on 16/1/1.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Lesson.h"
#import "Work.h"

@interface DBManager : NSObject

+ (instancetype) shareManager;

//插入数据
- (BOOL) insertUser:(User *) vo;
- (BOOL) insertLesson:(Lesson *) vo;
- (BOOL) insertWork:(Work *) vo;

//删除数据
- (BOOL) deleteUser;
- (BOOL) deleteLesson;
- (BOOL) deleteWork;

//获取所有数据
-(NSArray *) getUserDBData;
-(NSArray *) getLessonDBData;
-(NSArray *) getWorkDBData;


@end
