//
//  WorkCell.h
//  HomeworkApp
//
//  Created by 林立 on 16/1/3.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Work;
@interface WorkCell : UITableViewCell

@property (nonatomic,strong) Work *work;

//封装一个自定义workCell的方法
+ (instancetype)workCellWithTableView:(UITableView *)tableView;

@end
