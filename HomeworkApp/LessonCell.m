//
//  LessonCell.m
//  HomeworkApp
//
//  Created by 林立 on 16/1/3.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import "LessonCell.h"
#import "Lesson.h"

@interface LessonCell()
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Teacher;

@end

@implementation LessonCell

+ (instancetype)lessonCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"lesson_cell";
    LessonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LessonCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setLesson:(Lesson *)lesson{
    _lesson = lesson;
    self.ID.text = lesson.lID;
    self.Name.text = lesson.lName;
    self.Teacher.text = lesson.lTeacher;
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = bgView;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
