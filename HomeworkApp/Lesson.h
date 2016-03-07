//
//  Lesson.h
//  HomeworkApp
//
//  Created by 林立 on 15/12/31.
//  Copyright © 2015年 ZweiL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lesson : NSObject

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


- (instancetype)initWithArray:(NSArray *)arr;
+ (instancetype)lessonWithArray:(NSArray *)arr;

@end
