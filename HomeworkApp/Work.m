//
//  Work.m
//  HomeworkApp
//
//  Created by 林立 on 15/12/31.
//  Copyright © 2015年 ZweiL. All rights reserved.
//

#import "Work.h"

@implementation Work

- (instancetype)initWithArray:(NSArray *)arr{
    if (self = [super init]){
        self.wID = arr[0];
        self.wLesson= arr[1];
        self.wName = arr[2];
        self.wType = arr[3];
        self.wDeadline = arr[4];
        self.wSubDocument = arr[5];
        self.wSubState = arr[6];
        self.wSubTime = arr[7];
        self.wSubProcess = arr[8];
        self.wSelfScore = arr[9];
        self.wSelfRemark = arr[10];
    }
    return self;
}

+ (instancetype)workWithArray:(NSArray *)arr{
    return [[self alloc]initWithArray:arr];
}

@end
