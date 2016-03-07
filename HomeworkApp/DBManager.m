//
//  DBManager.m
//  HomeworkApp
//
//  Created by 林立 on 16/1/1.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import "DBManager.h"
#import "AppDelegate.h"
#import "User.h"
#import "Lesson.h"
#import "Work.h"
#import "UserDataObject.h"
#import "LessonDataObject.h"
#import "WorkDataObject.h"

@implementation DBManager


+ (instancetype) shareManager
{
    
    static DBManager *instance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        instance  = [[DBManager alloc]init];
    });
    
    return  instance;
    
}

//User数据插入
- (BOOL) insertUser:(User *)vo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //1.获取上下文
    NSManagedObjectContext *managedObjectContext =  delegate.managedObjectContext;
    //2.插入数据
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
    [obj setValue:vo.usernumber forKey:@"usernumber"];
    [obj setValue:vo.session forKey:@"session"];
    [obj setValue:vo.lasttime forKey:@"lasttime"];
    NSError *error = nil;
    if ([managedObjectContext save:&error])
    {
        return  YES;
    }
    return NO;
}

//Lesson数据插入
- (BOOL) insertLesson:(Lesson *)vo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //1.获取上下文
    NSManagedObjectContext *managedObjectContext =  delegate.managedObjectContext;
    //2.插入数据
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Lesson" inManagedObjectContext:managedObjectContext];
    [obj setValue:vo.lID forKey:@"lID"];
    [obj setValue:vo.lName forKey:@"lName"];
    [obj setValue:vo.lTeacher forKey:@"lTeacher"];
    [obj setValue:vo.lNotice forKey:@"lNotice"];
    [obj setValue:vo.lRefreshtime forKey:@"lRefreshtime"];
    NSError *error = nil;
    if ([managedObjectContext save:&error])
    {
        return  YES;
    }
    return NO;
}

//Work数据插入
- (BOOL) insertWork:(Work *) vo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //1.获取上下文
    NSManagedObjectContext *managedObjectContext =  delegate.managedObjectContext;
    //2.插入数据
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Work" inManagedObjectContext:managedObjectContext];
    [obj setValue:vo.wID forKey:@"wID"];
    [obj setValue:vo.wLesson forKey:@"wLesson"];
    [obj setValue:vo.wName forKey:@"wName"];
    [obj setValue:vo.wType forKey:@"wType"];
    [obj setValue:vo.wDeadline forKey:@"wDeadline"];
    [obj setValue:vo.wSubDocument forKey:@"wSubDocument"];
    [obj setValue:vo.wSubState forKey:@"wSubState"];
    [obj setValue:vo.wSubTime forKey:@"wSubTime"];
    [obj setValue:vo.wSubProcess forKey:@"wSubTime"];
    [obj setValue:vo.wSelfScore forKey:@"wSelfScore"];
    [obj setValue:vo.wSelfRemark forKey:@"wSelfRemark"];
    NSError *error = nil;
    if ([managedObjectContext save:&error])
    {
        return  YES;
    }
    return NO;
}

//删除User所有数据
- (BOOL) deleteUser
{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //1.获取上下文
    NSManagedObjectContext *managedObjectContext =  delegate.managedObjectContext;
    //2.获取表
    NSEntityDescription *description  = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    //3.请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = description;
    //4.执行调度
    NSError *error = nil;
    NSArray *listData  = [managedObjectContext executeFetchRequest:request error:&error];
    if ([listData count] >0)
    {
        for (NSManagedObject *obj in listData)
        {
            [managedObjectContext deleteObject:obj];
        }
        NSError *saveError = nil;
        if ([managedObjectContext save:&saveError])
        {
            return YES;
        }
    }
    return  NO;
}

//删除Lesson所有数据
- (BOOL) deleteLesson
{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //1.获取上下文
    NSManagedObjectContext *managedObjectContext =  delegate.managedObjectContext;
    //2.获取表
    NSEntityDescription *description  = [NSEntityDescription entityForName:@"Lesson" inManagedObjectContext:managedObjectContext];
    //3.请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = description;
    //4.执行调度
    NSError *error = nil;
    NSArray *listData  = [managedObjectContext executeFetchRequest:request error:&error];
    if ([listData count] >0)
    {
        for (NSManagedObject *obj in listData)
        {
            [managedObjectContext deleteObject:obj];
        }
        NSError *saveError = nil;
        if ([managedObjectContext save:&saveError])
        {
            return YES;
        }
    }
    return  NO;
}

//删除Work所有数据
- (BOOL) deleteWork
{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //1.获取上下文
    NSManagedObjectContext *managedObjectContext =  delegate.managedObjectContext;
    //2.获取表
    NSEntityDescription *description  = [NSEntityDescription entityForName:@"Work" inManagedObjectContext:managedObjectContext];
    //3.请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = description;
    //4.执行调度
    NSError *error = nil;
    NSArray *listData  = [managedObjectContext executeFetchRequest:request error:&error];
    if ([listData count] >0)
    {
        for (NSManagedObject *obj in listData)
        {
            [managedObjectContext deleteObject:obj];
        }
        NSError *saveError = nil;
        if ([managedObjectContext save:&saveError])
        {
            return YES;
        }
    }
    return  NO;
}

//获取User所有数据
-(NSArray *) getUserDBData
{
    NSMutableArray *array =[[NSMutableArray alloc]init];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //1.获取上下文
    NSManagedObjectContext *managedObjectContext =  delegate.managedObjectContext;
    //2.获取表
    NSEntityDescription *description  = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    //3.请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = description;
    //4.执行调度
    NSError *error = nil;
    NSArray *listData  = [managedObjectContext executeFetchRequest:request error:&error];
    if ([listData count] >0)
    {
        for (UserDataObject *curObj in listData)
        {
            User *vo = [[User alloc]init];
            vo.usernumber = curObj.usernumber;
            vo.session = curObj.session;
            vo.lasttime = curObj.lasttime;
            [array addObject:vo];
        }
    }
    return array;
}

//获取Lesson所有数据
-(NSArray *) getLessonDBData
{
    NSMutableArray *array =[[NSMutableArray alloc]init];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //1.获取上下文
    NSManagedObjectContext *managedObjectContext =  delegate.managedObjectContext;
    //2.获取表
    NSEntityDescription *description  = [NSEntityDescription entityForName:@"Lesson" inManagedObjectContext:managedObjectContext];
    //3.请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = description;
    //4.执行调度
    NSError *error = nil;
    NSArray *listData  = [managedObjectContext executeFetchRequest:request error:&error];
    if ([listData count] >0)
    {
        for (LessonDataObject *curObj in listData)
        {
            Lesson *vo = [[Lesson alloc]init];
            vo.lID = curObj.lID;
            vo.lName = curObj.lName;
            vo.lTeacher = curObj.lTeacher;
            vo.lNotice = curObj.lNotice;
            vo.lRefreshtime = curObj.lRefreshtime;
            [array addObject:vo];
        }
    }
    return array;
}

//获取Work所有数据
-(NSArray *) getWorkDBData
{
    NSMutableArray *array =[[NSMutableArray alloc]init];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //1.获取上下文
    NSManagedObjectContext *managedObjectContext =  delegate.managedObjectContext;
    //2.获取表
    NSEntityDescription *description  = [NSEntityDescription entityForName:@"Work" inManagedObjectContext:managedObjectContext];
    //3.请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = description;
    //4.执行调度
    NSError *error = nil;
    NSArray *listData  = [managedObjectContext executeFetchRequest:request error:&error];
    if ([listData count] >0)
    {
        for (WorkDataObject *curObj in listData)
        {
            Work *vo = [[Work alloc]init];
            vo.wID = curObj.wID;
            vo.wLesson = curObj.wLesson;
            vo.wName = curObj.wName;
            vo.wType = curObj.wType;
            vo.wDeadline = curObj.wDeadline;
            vo.wSubDocument = curObj.wSubDocument;
            vo.wSubState = curObj.wSubState;
            vo.wSubTime = curObj.wSubTime;
            vo.wSubProcess = curObj.wSubProcess;
            vo.wSelfScore = curObj.wSelfScore;
            vo.wSelfRemark = curObj.wSelfRemark;
            [array addObject:vo];
        }
    }
    return array;
}
@end
