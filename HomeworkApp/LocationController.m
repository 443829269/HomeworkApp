//
//  LocationController.m
//  HomeworkApp
//
//  Created by 林立 on 16/1/1.
//  Copyright © 2016年 ZweiL. All rights reserved.
//

#import "LocationController.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <MapKit/MapKit.h>
#import "DBManager.h"

@interface LocationController ()<CLLocationManagerDelegate,MKMapViewDelegate>
//经度
@property (weak, nonatomic) IBOutlet UILabel *txtLng;
//纬度
@property (weak, nonatomic) IBOutlet UILabel *txtLat;
//高度
@property (weak, nonatomic) IBOutlet UILabel *txtAlt;
//地理信息
@property (weak, nonatomic) IBOutlet UITextView *txtView;
//地图
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//最后更新日期
@property (weak, nonatomic) IBOutlet UILabel *lastlocationtime;
//三个按钮
@property (weak, nonatomic) IBOutlet UIButton *upload;
@property (weak, nonatomic) IBOutlet UIButton *download;
@property (weak, nonatomic) IBOutlet UIButton *relocation;
//按钮单击事件
- (IBAction)uploadbtn:(id)sender;
- (IBAction)downloadbtn:(id)sender;
- (IBAction)relocationbtn:(id)sender;

@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)CLLocation *currLocation;

@property (nonatomic,strong) NSArray *user;

@property (nonatomic,copy)NSString *message;

@end

@implementation LocationController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置按钮圆角
    self.upload.layer.cornerRadius = 10;
    self.upload.clipsToBounds = YES;
    self.download.layer.cornerRadius = 10;
    self.download.clipsToBounds = YES;
    self.relocation.layer.cornerRadius = 10;
    self.relocation.clipsToBounds = YES;
    //定位初始化
    if ([CLLocationManager locationServicesEnabled]){
        self.mapView.mapType = MKMapTypeStandard;
        self.mapView.delegate = self;
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1000.0f;
        
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//视图出现时调用
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开始定位服务
    [self.locationManager startUpdatingLocation];
    
}

//视图关闭时调用
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //停止定位服务
    [self.locationManager stopUpdatingLocation];
}

//获取定位成功信息的代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.currLocation = [locations lastObject];
    self.txtLng.text = [NSString stringWithFormat:@"%3.5f",self.currLocation.coordinate.longitude];
    self.txtLat.text = [NSString stringWithFormat:@"%3.5f",self.currLocation.coordinate.latitude];
    self.txtAlt.text = [NSString stringWithFormat:@"%3.5f",self.currLocation.altitude];
    [self locationmessage];
}

//获取定位失败信息的代理
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error:%@",error);
}

//获取授权信息的代理
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedAlways){
        NSLog(@"Authorized");
    }else if (status == kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"AuthorizedWhenInUse");
    }else if (status == kCLAuthorizationStatusDenied){
        NSLog(@"Denied");
    }else if (status == kCLAuthorizationStatusRestricted){
        NSLog(@"Restricted");
    }else if (status == kCLAuthorizationStatusNotDetermined){
        NSLog(@"NotDetermined");
    }
}

- (void)locationmessage {
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:self.currLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if ([placemarks count] > 0){
            CLPlacemark *placemark = placemarks[0];
            NSDictionary *addressDictionary = placemark.addressDictionary;
            NSString *address = [addressDictionary objectForKey:(NSString *)kABPersonAddressStreetKey];
            address = address == nil ? @"" : address;
            NSString *state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
            state = state == nil ? @"" : state;
            NSString *city = [addressDictionary objectForKey:(NSString*)kABPersonAddressCityKey];
            city = city == nil ? @"" :city;
            self.txtView.text = [NSString stringWithFormat:@"%@%@%@",state,address,city];
            
        }
    }];
}


- (IBAction)uploadbtn:(id)sender {
    if (self.txtView.text != nil){
        [self.locationManager stopUpdatingLocation];
        User *model = [self.user firstObject];
        //post内容
        NSString *strURL = @"http://202.116.161.73:6391/query/Ext_LBS_SaveMyPosition";
        strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:strURL];
        NSString *post = [NSString stringWithFormat:@"strUserNumber=%@&strSession=%@&Longitude=%@&Latitude=%@&strRemark=%@",model.usernumber,model.session,self.txtLng.text,self.txtLat.text,self.txtView.text];
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
        NSError *error;
        NSData *datas = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        if (error == nil){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dict);
            NSString *result = dict[@"result"];
            int intString = [result intValue];
            NSLog(@"%d",intString);
            if (intString == 1){
                self.message = @"定位信息上传完成！";
            }else{
                self.message = @"登录信息过期\n请重新登录。";
            }
        }else{
            self.message = @"定位信息上传失败！";
        }
        [self Message:self.message];
    }
}

- (IBAction)downloadbtn:(id)sender {
    [self.locationManager stopUpdatingLocation];
    User *model = [self.user firstObject];
    //post内容
    NSString *strURL = @"http://202.116.161.73:6391/query/Ext_LBS_GetMyLastPosition";
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strURL];
    NSString *post = [NSString stringWithFormat:@"strUserNumber=%@&strSession=%@",model.usernumber,model.session];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSError *error;
    NSData *datas = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error == nil){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
        NSArray *result = dict[@"result"];
//        for (NSString * aa in result){
//            NSLog(@"%@",aa);
//        }
        NSString *first = [result firstObject];
        if ([first length] == 12){
            self.message = @"定位信息下载完成！";
            self.lastlocationtime.text = [NSString stringWithFormat:@"最后上传时间：\n%@",result[1]];
            self.txtLng.text = result[2];
            self.txtLat.text = result[3];
            self.txtAlt.text = nil;
            self.txtView.text = result[4];
        }else{
            self.message = @"登录信息过期\n请重新登录。";
        }
    }else{
        self.message = @"定位信息下载失败！";
    }
    [self Message:self.message];
}

- (IBAction)relocationbtn:(id)sender {
    [self.locationManager startUpdatingLocation];
}

- (void)Message:(NSString *)message{
    UILabel *lblMsg = [[UILabel alloc]init];
    lblMsg.text = message;
    lblMsg.textColor = [UIColor redColor];
    lblMsg.layer.cornerRadius = 8;
    lblMsg.clipsToBounds = YES;
    lblMsg.textAlignment = NSTextAlignmentCenter;
    lblMsg.font = [UIFont boldSystemFontOfSize:20];
    lblMsg.numberOfLines = 0;
    lblMsg.backgroundColor = [UIColor blackColor];
    CGFloat msgH = 80.0;
    CGFloat msgW = 200.0;
    CGFloat msgX = (self.view.frame.size.width - msgW)/2;
    CGFloat msgY = (self.view.frame.size.height - msgH)/2;
    lblMsg.frame = CGRectMake(msgX, msgY, msgW, msgH);
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
