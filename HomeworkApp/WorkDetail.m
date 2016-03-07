//
//  WorkDetail.m
//  HomeworkApp
//
//  Created by 林立 on 16/1/4.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import "WorkDetail.h"
#import "Work.h"

@interface WorkDetail()

@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *lesson;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *deadline;
@property (weak, nonatomic) IBOutlet UILabel *subdocument;
@property (weak, nonatomic) IBOutlet UILabel *substate;
@property (weak, nonatomic) IBOutlet UIWebView *subtime;
@property (weak, nonatomic) IBOutlet UIWebView *subprocess;
@property (weak, nonatomic) IBOutlet UILabel *selfscore;
@property (weak, nonatomic) IBOutlet UITextView *selfremark;


- (IBAction)btn:(id)sender;

@end

@implementation WorkDetail

//重写work属性的set方法
- (void)setWork:(Work *)work{
    _work = work;
    self.ID.text = work.wID;
    self.lesson.text = work.wLesson;
    self.name.text = work.wName;
    self.type.text = work.wType;
    self.deadline.text = work.wDeadline;
    self.subdocument.text = work.wSubDocument;
    self.substate.text = work.wSubState;
    [self.subtime loadHTMLString:work.wSubTime baseURL:nil];
    [self.subprocess loadHTMLString:work.wSubProcess baseURL:nil];
    self.selfscore.text = work.wSelfScore;
    self.selfremark.text = work.wSelfRemark;
    [self bringSubviewToFront:self.subprocess];
    [self bringSubviewToFront:self.subtime];
    [self bringSubviewToFront:self.selfremark];
}

- (IBAction)btn:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(375, 0);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
