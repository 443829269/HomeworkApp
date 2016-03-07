//
//  LessonCell.h
//  HomeworkApp
//
//  Created by 林立 on 16/1/3.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Lesson;
@interface LessonCell : UITableViewCell

@property (nonatomic,strong) Lesson *lesson;

//封装一个自定义lessonCell的方法
+ (instancetype)lessonCellWithTableView:(UITableView *)tableView;

@end
