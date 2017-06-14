//
//  MySearchResultViewController.m
//  weather
//
//  Created by David on 6/12/17.
//  Copyright © 2017 Dacredible. All rights reserved.
//

#import "MySearchResultViewController.h"
#import "CityListViewController.h"

@interface MySearchResultViewController ()

@end

static NSString *simpleTableIdentifier = @"CellReuseIdentifier";

@implementation MySearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    [_tableView registerClass:[UITableView class] forCellReuseIdentifier:simpleTableIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSDictionary *temp = _searchResults[indexPath.row];
    cell.textLabel.text = [temp objectForKey:@"cityname"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idForCity = [[self.searchResults objectAtIndex:indexPath.row] objectForKey:@"cityid"];
    NSLog(@"%@",idForCity);
    [_citySelect citySelect:[self.searchResults objectAtIndex:indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pop" object:nil];
    }];
}
@end
