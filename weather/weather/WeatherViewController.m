//
//  WeatherViewController.m
//  weather
//
//  Created by David on 6/7/17.
//  Copyright © 2017 Dacredible. All rights reserved.
//

#import "WeatherViewController.h"
#import "CityListViewController.h"

@interface WeatherViewController ()<CitySelectDelegate>

@property (strong,nonatomic) IBOutlet UILabel *cityLable;
@property (strong,nonatomic) IBOutlet UILabel *weatherLable;
@property (strong, nonatomic) IBOutlet UILabel *cityTemp;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *showList;
@property (strong, nonatomic) NSDictionary *weatherInfoDic;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.

    
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString *urlString = @"http://www.weather.com.cn/data/cityinfo/101020100.html";
    UIButton *refreshBtn = [[UIButton alloc] initWithFrame: CGRectMake(100, 300, 100, 100)];

    [refreshBtn setTitle:@"Refresh" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:refreshBtn];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"citylist" forState:UIControlStateNormal];

    [_showList setAction:@selector(pushMethod)];
    [_showList setTarget:self];

    [refreshBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushMethod
{
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    
    
    CityListViewController *CityListViewController = [story instantiateViewControllerWithIdentifier:@"CityListViewController"];
    
    CityListViewController.cityDelegate =self;
    
    [self.navigationController pushViewController:CityListViewController animated:YES];
}

-(void)click
{
    [self callJson:@"http://www.weather.com.cn/data/cityinfo/101020100.html"];
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
    self.cityLable.text = [_weatherInfoDic objectForKey:@"city"];
    self.weatherLable.text = [_weatherInfoDic objectForKey:@"weather"];
    self.cityTemp.text = [_weatherInfoDic objectForKey:@"temp1"];

}

-(void)citySelect:(NSDictionary *)dic
{
    self.cityLable.text = [dic objectForKey:@"city"];
    self.weatherLable.text = [dic objectForKey:@"weather"];
    self.cityTemp.text = [dic objectForKey:@"temp1"];

    NSLog(@"dic = %@",dic);
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
