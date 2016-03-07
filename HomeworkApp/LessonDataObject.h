//
//  LessonDataObject.h
//  HomeworkApp
//
//  Created by 林立 on 16/1/1.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface LessonDataObject : NSManagedObject

//课程ID
@property (nonatomic,copy) NSString *lID;

//课程名称
@property (nonatomic,copy) NSString *lName;

//科任老师
@property (nonatomic,copy) NSString *lTeacher;

//课程通知
@property (nonatomic,copy) NSString *lNotice;

//更新时间
@property (nonatomic,copy) NSString *lRefreshtime;

@end
