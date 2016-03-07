//
//  Work.h
//  HomeworkApp
//
//  Created by 林立 on 15/12/31.
//  Copyright © 2015年 ZweiL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Work : NSObject

//作业ID
@property (nonatomic,copy) NSString *wID;

//作业课程
@property (nonatomic,copy) NSString *wLesson;

//作业名称
@property (nonatomic,copy) NSString *wName;

//作业类型
@property (nonatomic,copy) NSString *wType;

//截止日期
@property (nonatomic,copy) NSString *wDeadline;

//提交文件
@property (nonatomic,copy) NSString *wSubDocument;

//提交状态
@property (nonatomic,copy) NSString *wSubState;

//提交时间
@property (nonatomic,copy) NSString *wSubTime;

//提交轨迹
@property (nonatomic,copy) NSString *wSubProcess;

//自评分数
@property (nonatomic,copy) NSString *wSelfScore;

//自评备注
@property (nonatomic,copy) NSString *wSelfRemark;

- (instancetype)initWithArray:(NSArray *)arr;
+ (instancetype)workWithArray:(NSArray *)arr;

@end
