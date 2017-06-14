    //
//  WeatherViewController.m
//  weather
//
//  Created by David on 6/7/17.
//  Copyright © 2017 Dacredible. All rights reserved.
//

#import "WeatherViewController.h"
#import "CityListViewController.h"
#import "MJRefresh.h"

@interface WeatherViewController ()<CitySelectDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *weatherInfoTable;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *showList;
@property (strong, nonatomic) NSDictionary *weatherInfoDic;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    _weatherInfoTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _weatherInfoTable.dataSource = self;
    [self.view addSubview:_weatherInfoTable];
    _weatherInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _weatherInfoTable.tableFooterView = [UIView new];
    [self update:@"101020100"];
    
}

- (void)update:(NSString *)cityID{
    self.weatherInfoTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
            [self callJson:cityID];
    }];
    // Enter the refresh status immediately
    [self.weatherInfoTable.mj_header beginRefreshing];
}
- (void)viewDidAppear:(BOOL)animated
{
   
    [_showList setAction:@selector(pushMethod)];
    [_showList setTarget:self];

}


#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_weatherInfoDic) {
        return 0;
    }
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if(!_weatherInfoDic){
        cell.textLabel.text = @"请刷新";
    }
    else
        switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"城市：  ",[_weatherInfoDic objectForKey:@"city"]];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"天气：  ",[_weatherInfoDic objectForKey:@"weather"]];
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"温度：  ",[_weatherInfoDic objectForKey:@"temp1"]];
            break;
        default:
            break;
    }
    
    return cell;
}
- (void)pushMethod
{
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    
    
    CityListViewController *CityListViewController = [story instantiateViewControllerWithIdentifier:@"CityListViewController"];
    
    CityListViewController.cityDelegate =self;
    
    [self.navigationController pushViewController:CityListViewController animated:YES];
}

-(void)callJson:(NSString *)cityID
{
    NSString *urlString = [[NSString alloc]initWithFormat:(@"http://www.weather.com.cn/data/cityinfo/%@.html"),cityID];
    NSError *error;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    _weatherInfoDic = [[NSDictionary alloc]initWithDictionary: [weatherDic objectForKey:@"weatherinfo"]];
    [_weatherInfoTable reloadData];
    [_weatherInfoTable.mj_header endRefreshing];
}

-(void)citySelect:(NSDictionary *)dic
{
    NSString *cityID = [dic objectForKey:@"cityid"];
    [self update:cityID];
    NSLog(@"dic = %@",dic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
