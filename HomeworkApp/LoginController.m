//
//  LoginController.m
//  HomeworkApp
//
//  Created by 林立 on 15/12/30.
//  Copyright © 2015年 ZweiL. All rights reserved.
//

#import "LoginController.h"
#import "Connect.h"
#import "DBManager.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *OfflineBtn;
@property (weak, nonatomic) IBOutlet UITextField *Xuehao;
@property (weak, nonatomic) IBOutlet UITextField *PassWord;
@property (weak, nonatomic) IBOutlet UIButton *Logo;
@property (weak, nonatomic) IBOutlet UIImageView *Textbackground;

@property (nonatomic,copy) NSString *usernumber;
@property (nonatomic,strong) NSArray *user;

- (IBAction)Login:(id)sender;
- (IBAction)btn:(id)sender;
- (IBAction)Offline:(id)sender;

@end
@implementation LoginController


//关闭状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听键盘弹出事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    User *model = [self.user firstObject];
    if (model == nil){
        self.OfflineBtn.enabled = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillChangeFrame:(NSNotification *)noteInfo{
    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y;
    if (keyboardY != self.view.frame.size.height){
        keyboardY = self.LoginBtn.frame.origin.y;
    }
    CGFloat tranformValue = keyboardY - self.view.frame.size.height;
    self.view.transform = CGAffineTransformMakeTranslation(0, tranformValue);
}

- (IBAction)Login:(id)sender {
    NSString *usernumber = self.Xuehao.text;
    self.usernumber = usernumber;
    NSString *password = self.PassWord.text;
    Connect *con = [[Connect alloc]initWithUsername:usernumber Withpassword:password];
    NSString *message;
    NSLog(@"返回%@",con.Session);
    NSArray *items = [NSArray arrayWithObjects:@"401", @"402", @"404", @"405", @"406", @"417", @"427", @"500",@"501", @"000",nil];
    NSInteger item = [items indexOfObject:con.Session];
    switch (item) {
        case 0:
            message = @"401:学号/工号长度必须为0或12位。";
            break;
        case 1:
            message = @"402:密码MD5长度必须为32位。";
            break;
        case 2:
            message = @"404:密码错误。";
            break;
        case 3:
            message = @"405:输入的客户端当前时间不正确。";
            break;
        case 4:
            message = @"406:服务器和客户端时间相差5分钟。";
            break;
        case 5:
            message = @"417:连续输入密码错误超过5次,锁定不能登录30分钟。";
            break;
        case 6:
            message = @"427:同一IP连续输入密码错误超过5次(计不同的账户),锁定此IP不能登录30分钟。";
            break;
        case 7:
            message = @"500:服务器内部故障。";
            break;
        case 8:
            message = @"501:未定义错误。";
            break;
        case 9:
            message = @"000:未连接网络。";
            break;
        default:
            message = @"登录成功。";
            break;
    }
    [self Message:message];
    [self.view endEditing:YES];
    if ([message isEqualToString:@"登录成功。"]){
        [self performSegueWithIdentifier:@"next" sender:self];
    }
}

- (IBAction)btn:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)Offline:(id)sender {
//    DBManager *manager = [[DBManager alloc]init];
//    NSArray *arr = [manager getLessonDBData];
    //新建一个动态数组保存模型
//    NSMutableArray *arrayModel = [NSMutableArray array];
//    //遍历把字典转模型
//    for (Lesson *bb in arr){
//        NSLog(@"%@",bb.lName);
//        NSLog(@"%@",bb);
        //传递给模型进行解析
//        Lesson *model = [Lesson lessonWithArray:bb];
        //保存生成的模型
//        [arrayModel addObject:model];
//    }
    [self performSegueWithIdentifier:@"next" sender:self];
}

- (void)Message:(NSString *)message{
    UILabel *lblMsg = [[UILabel alloc]init];
    lblMsg.text = message;
    lblMsg.textColor = [UIColor redColor];
    lblMsg.textAlignment = NSTextAlignmentCenter;
    lblMsg.font = [UIFont boldSystemFontOfSize:15];
    lblMsg.numberOfLines = 0;
    lblMsg.backgroundColor = [UIColor blackColor];
    lblMsg.frame = self.Textbackground.frame;
    lblMsg.alpha = 0.0;
    [self.view addSubview:lblMsg];
    [UIView animateWithDuration:1.5 animations:^{
        lblMsg.alpha = 0.8;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            lblMsg.alpha = 0.0;
        } completion:^(BOOL finished) {
            [lblMsg removeFromSuperview];
        }];
    }];
}

@end
