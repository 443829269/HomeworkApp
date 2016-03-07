//
//  WorkCell.m
//  HomeworkApp
//
//  Created by 林立 on 16/1/3.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import "WorkCell.h"
#import "Work.h"

@interface WorkCell()

@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *Lesson;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UIImageView *point;

@end

@implementation WorkCell

+ (instancetype)workCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"work_cell";
    WorkCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WorkCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setWork:(Work *)work{
    self.ID.text = work.wID;
    self.Name.text = work.wName;
    self.Lesson.text = work.wLesson;
    self.point.layer.cornerRadius = 5;
    self.point.clipsToBounds = YES;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *deadline=[dateFormatter dateFromString:work.wDeadline];
//    NSDate *subtime=[dateFormatter dateFromString:work.wSubTime];
//    NSLog(@"substate:%@",work.wSubState);
//    NSLog(@"subtime:%@",subtime);
//    NSLog(@"deadline:%@",deadline);
    NSDate *now = [NSDate date];
    NSDate *earlierDate = [deadline earlierDate:now];
    if ([work.wSubState isEqualToString:@"已提交"]){
        self.point.backgroundColor = [UIColor greenColor];
    }else if (earlierDate == now){
        self.point.backgroundColor = [UIColor yellowColor];
    }else {
        self.point.backgroundColor = [UIColor redColor];
    }
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
