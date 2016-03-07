//
//  WorkController.m
//  HomeworkApp
//
//  Created by 林立 on 16/1/1.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import "WorkController.h"
#import "User.h"
#import "Lesson.h"
#import "DBManager.h"
#import "WorkCell.h"
#import "WorkDetail.h"

@interface WorkController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *usernumber;
@property (weak, nonatomic) IBOutlet UILabel *workcount;
@property (weak, nonatomic) IBOutlet UILabel *lasttime;

@property (weak, nonatomic) IBOutlet UIButton *Quit;
- (IBAction)QuitBtn:(id)sender;

//加载数据
@property (nonatomic,strong) NSArray *user;
@property (nonatomic,strong) NSArray *work;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WorkController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (NSArray *)user{
    if (_user == nil){
        //加载数据
        DBManager *manager = [[DBManager alloc]init];
        NSArray *arr = [manager getUserDBData];
        //新建一个动态数组保存模型
        NSMutableArray *arrayModel = [NSMutableArray array];
        //遍历把字典转模型
        for (User *aa in arr){
            //传递给模型进行解析
            User *model = [User userWithUser:aa.usernumber WithSession:aa.session WithLasttime:aa.lasttime];
            //保存生成的模型
            [arrayModel addObject:model];
        }
        _user = arrayModel;
    }
    return _user;
}

- (NSArray *)work{
    if (_work == nil){
        //加载数据
        DBManager *manager = [[DBManager alloc]init];
        NSArray *arr = [manager getWorkDBData];
        //新建一个动态数组保存模型
        NSMutableArray *arrayModel = [NSMutableArray array];
        //遍历把字典转模型
        for (Work *bb in arr){
            //传递给模型进行解析
            Work *model = bb;
            //保存生成的模型
            [arrayModel addObject:model];
        }
        _work = arrayModel;
    }
    return _work;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.work.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取模型数据
    Work *model = self.work[indexPath.row];
    //创建单元格
    WorkCell *cell = [WorkCell workCellWithTableView:tableView];
    //把模型数据设置给单元格
    cell.work = model;
    if (indexPath.row % 2 == 1){
        cell.backgroundColor = [UIColor colorWithRed:102.0/255 green:204.0/255 blue:255.0/255 alpha:1.0];
    }else{
        cell.backgroundColor = [UIColor colorWithRed:228.0/255 green:228.0/255 blue:228.0/255 alpha:1.0];
    }
    //返回单元格
    return cell;
}

//代理方法弹窗
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Work *model = self.work[indexPath.row];
    NSBundle *rootBundle = [NSBundle mainBundle];
    WorkDetail *detailview = [[rootBundle loadNibNamed:@"WorkDetail" owner:nil options:nil]lastObject];
    detailview.frame = CGRectMake(375.0, 140, 375.0, 478.0);
    detailview.contentSize = CGSizeMake(375, 900);
    [self.view addSubview:detailview];
    detailview.work = model;
    [UIView animateWithDuration:0.5 animations:^{
        detailview.transform = CGAffineTransformMakeTranslation(-375, 0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(140.0, 0, 0, 0);
    self.Quit.layer.cornerRadius = 10;
    self.Quit.clipsToBounds = YES;
    self.workcount.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.work.count];
    User *model = self.user[0];
    self.usernumber.text = model.usernumber;
    self.lasttime.text = model.lasttime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)QuitBtn:(id)sender {
    [self performSegueWithIdentifier:@"quit2" sender:self];
}

@end

