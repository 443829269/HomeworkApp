//
//  Lesson.m
//  HomeworkApp
//
//  Created by 林立 on 15/12/31.
//  Copyright © 2015年 ZweiL. All rights reserved.
//

#import "Lesson.h"

@implementation Lesson

- (instancetype) initWithArray:(NSArray *)arr{
    if (self = [super init]){
        self.lID = arr[0];
        self.lName= arr[1];
        self.lTeacher= arr[2];
        self.lNotice = arr[3];
        self.lRefreshtime = arr[4];
    }
    return self;
}

+ (instancetype) lessonWithArray:(NSArray *)arr{
    return [[self alloc]initWithArray:arr];
}

@end
