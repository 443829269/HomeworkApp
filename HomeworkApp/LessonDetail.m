//
//  LessonDetail.m
//  HomeworkApp
//
//  Created by 林立 on 16/1/4.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import "LessonDetail.h"
#import "Lesson.h"

@interface LessonDetail()

@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *teacher;
@property (weak, nonatomic) IBOutlet UILabel *refreshtime;
@property (weak, nonatomic) IBOutlet UIWebView *notice;

- (IBAction)btn:(id)sender;

@end

@implementation LessonDetail

//重写lesson属性的set方法
- (void)setLesson:(Lesson *)lesson{
    _lesson = lesson;
    self.ID.text = lesson.lID;
    self.name.text = lesson.lName;
    self.teacher.text = lesson.lTeacher;
    self.refreshtime.text = lesson.lRefreshtime;
    [self.notice loadHTMLString:lesson.lNotice baseURL:nil];
    [self bringSubviewToFront:self.notice];
}

- (IBAction)btn:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(-375, 0);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
