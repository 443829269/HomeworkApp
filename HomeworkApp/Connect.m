//
//  Connect.m
//  HomeworkApp
//
//  Created by 林立 on 15/12/31.
//  Copyright © 2015年 ZweiL. All rights reserved.
//

#import "Connect.h"
#import <CommonCrypto/CommonDigest.h>
#import "DBManager.h"
#import "User.h"
#import "Lesson.h"
#import "Work.h"

@interface Connect ()

//usernumber
@property (nonatomic,copy) NSString *Usernumber;

@end

@implementation Connect

- (instancetype)initWithUsername:(NSString *)usernumber Withpassword:(NSString *)password{
    self.Usernumber = usernumber;
    NSString *pw = [self md5:password];
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.dateString = [dateFormatter stringFromDate:currentDate];
    //post内容
    NSString *strURL = @"http://202.116.161.73:6391/query/Sys_UserLogin";
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strURL];
    NSString *post = [NSString stringWithFormat:@"strUserNumber=%@&strPassWordMd5=%@&strCurrentDate=%@",usernumber,pw,self.dateString];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSError *error;
    //同步方法
    NSData *datas = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error == nil){
        NSLog(@"登录请求完成");
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
        self.Session = dict[@"result"];
        if ([self.Session length] >= 30){
            [self updateUser];
            [self updateLesson];
            [self updateWork];
        }
    }else{
        NSLog(@"登录请求失败");
        self.Session = @"000";
    }
    //异步方法
//    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//    if (connection) {
//        self.datas = [NSMutableData new];
//    }else {
//        NSLog(@"POST失败");
//    }
    return self;
}

+ (instancetype)connectWithUsername:(NSString *)usernumber WithPassword:(NSString *)password{
    return [[self alloc]initWithUsername:usernumber Withpassword:password];
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//异步方法的代理实现
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    [self.datas appendData:data];
//}
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    NSLog(@"%@",[error localizedDescription]);
//}
//- (void)connectionDidFinishLoading: (NSURLConnection *)connection{
//    NSLog(@"请求完成");
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.datas options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"原字典：%@",dict);
//    self.Session = dict[@"result"];
//    NSLog(@"截取：%@",self.Session);
//}

//更新User
- (void)updateUser{
    DBManager *manager1 = [[DBManager alloc]init];
    [manager1 deleteUser];
    User *user = [[User alloc]initWithUser:self.Usernumber WithSession:self.Session WithLasttime:self.dateString];
    [manager1 insertUser:user];
}

//更新Lesson
- (void)updateLesson{
    //post内容
    NSString *strURL = @"http://202.116.161.73:6391/query/Sys_GetMyCourseDetail";
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strURL];
    NSString *post = [NSString stringWithFormat:@"strUserNumber=%@&strSession=%@",self.Usernumber,self.Session];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSError *error;
    NSData *datas = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error == nil){
        NSLog(@"课程请求完成");
        DBManager *manager2 = [[DBManager alloc]init];
        [manager2 deleteLesson];
        NSDictionary *arrayDict = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
        NSArray *dict = arrayDict[@"result"];
        for (NSArray *arr in dict){
            Lesson *lesson = [[Lesson alloc]initWithArray:arr];
            [manager2 insertLesson:lesson];
        }
    }else{
        NSLog(@"课程请求失败");
    }
}

//更新Work
- (void)updateWork{
    //post内容
    NSString *strURL = @"http://202.116.161.73:6391/query/Sys_GetMyHomeWorkDetails";
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strURL];
    NSString *post = [NSString stringWithFormat:@"strUserNumber=%@&strSession=%@",self.Usernumber,self.Session];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSError *error;
    NSData *datas = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error == nil){
        NSLog(@"作业请求完成");
        DBManager *manager3 = [[DBManager alloc]init];
        [manager3 deleteWork];
        NSDictionary *arrayDict = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
        NSArray *dict = arrayDict[@"result"];
        for (NSArray *arr in dict){
            Work *work = [[Work alloc]initWithArray:arr];
            [manager3 insertWork:work];
        }
    }else{
        NSLog(@"作业请求失败");
    }
}
@end
