//
//  WeatherViewController.m
//  weather
//
//  Created by David on 6/7/17.
//  Copyright © 2017 Dacredible. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@property (strong,nonatomic) IBOutlet UILabel *citylable;
@property (strong,nonatomic) IBOutlet UILabel *weatherlable;
@property (strong, nonatomic) IBOutlet UILabel *citytemp;
@property (strong, nonatomic) NSDictionary *weatherInfoDic;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
//    self.weatherlable.text = @"6";
//    [_btn addTarget:self action:@selector(actionfun:) forControlEvents:UIControlEventTouchUpInside];
//    [self callJson];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    UIButton *refreshBtn = [[UIButton alloc] initWithFrame: CGRectMake(100, 300, 100, 100)];
//    [refreshBtn buttonType];
    [refreshBtn setTitle:@"Refresh" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:refreshBtn];
    
    [refreshBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

-(void)click
{
    [self callJson:@"http://www.weather.com.cn/data/cityinfo/101010100.html"];
}
-(void)callJson:(NSString *)urlString
{
    NSError *error;
//    NSString *urlString = @"http://www.weather.com.cn/data/cityinfo/101010100.html";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    _weatherInfoDic = [[NSDictionary alloc]initWithDictionary: [weatherDic objectForKey:@"weatherinfo"]];
    self.citylable.text = [_weatherInfoDic objectForKey:@"city"];
    self.weatherlable.text = [_weatherInfoDic objectForKey:@"weather"];
    self.citytemp.text = [_weatherInfoDic objectForKey:@"temp1"];

}

//-(IBAction)json:(id)sender{
//    
//    [self callJson];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
