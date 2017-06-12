//
//  CityListViewController.m
//  weather
//
//  Created by David on 6/7/17.
//  Copyright © 2017 Dacredible. All rights reserved.
//

#import "CityListViewController.h"

@interface CityListViewController ()

@property (strong,nonatomic) IBOutlet UITableView *citylist;

@end

@implementation CityListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _citylist.delegate = self;
    _citylist.dataSource = self;
    
    
    NSArray *array = [[NSArray alloc]initWithObjects:@{@"city":@"北京",@"cityid":@"101010100",@"weather":@"晴",@"temp1":@"25"},
                      @{@"city":@"西安",@"cityid":@"101110101",@"weather":@"雨",@"temp1":@"17"},
                      @{@"city":@"上海",@"cityid":@"101020100",@"weather":@"晴",@"temp1":@"27"},
                      @{@"city":@"南京",@"cityid":@"101190101",@"weather":@"阴",@"temp1":@"22"},
                      nil];
    
    self.listData = array;
    
}

#pragma mark - TableView Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.listData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    cell.textLabel.text = [[self.listData objectAtIndex:indexPath.row] objectForKey:@"city"];
    return cell;
}


#pragma mark - TableView onTouch

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idForCity = [[self.listData objectAtIndex:indexPath.row] objectForKey:@"cityid"];
    NSLog(@"%@",idForCity);
    [_cityDelegate citySelect:[self.listData objectAtIndex:indexPath.row] ];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
