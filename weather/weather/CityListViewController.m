//
//  CityListViewController.m
//  weather
//
//  Created by David on 6/7/17.
//  Copyright © 2017 Dacredible. All rights reserved.
//

#import "CityListViewController.h"
#import "MySearchResultViewController.h"
@interface CityListViewController ()

@property (strong,nonatomic) IBOutlet UITableView *cityList;
@property (strong,nonatomic) UISearchController *displayer;
@property (strong,nonatomic) MySearchResultViewController *mySearchResult;
@property (nonatomic) float widtheOfView;
@property (nonatomic) NSArray *array;
@end
static NSString *simpleTableIdentifier = @"SimpleTableIdentifier";
@implementation CityListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"UISearchController";
    self.cityList = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _cityList.delegate = self;
    _cityList.dataSource = self;
    [self.view addSubview:self.cityList];
    [self.cityList registerClass:[UITableViewCell class] forCellReuseIdentifier:simpleTableIdentifier];
    
    float widthOfView = self.view.frame.size.width;
    self.listData = [self getDataArray];
    
    _mySearchResult = [[MySearchResultViewController alloc]init];
    _mySearchResult.mainSearchController = self;
    
    
    _mySearchResult.citySelect = [self.navigationController.viewControllers firstObject];
    _displayer = [[UISearchController alloc]initWithSearchResultsController:_mySearchResult];
    
    [_displayer.searchBar sizeToFit];
    _cityList.tableHeaderView = _displayer.searchBar;
    
    _displayer.searchResultsUpdater = self;
    _displayer.searchBar.delegate = self;
    self.definesPresentationContext = YES;//北
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pop) name:@"pop" object:nil];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getData

- (NSArray *)getDataArray
{
    NSMutableArray *resultArray;
    NSArray *array = [[NSArray alloc]initWithObjects:@{@"cityname":@"北京",@"cityid":@"101010100"},
                      @{@"cityname":@"西安",@"cityid":@"101110101"},
                      @{@"cityname":@"上海",@"cityid":@"101020100"},
                      @{@"cityname":@"南京",@"cityid":@"101190101"},
                      nil];
    
    resultArray = array;
    return resultArray;
}
#pragma mark - setup searchbar
- (void)setUpSearchBar{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, _widtheOfView, 44)];
    
    _displayer = [[UISearchController alloc]initWithSearchResultsController:searchBar];
}
#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];

    cell.textLabel.text = [[self.listData objectAtIndex:indexPath.row] objectForKey:@"cityname"];
    return cell;
}

#pragma mark - TableView onTouch

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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

#pragma mark - UISearchResultUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResult = [[NSMutableArray alloc]init];
    NSDictionary *temp = [[NSDictionary alloc]init];
    for (temp in _listData){
        NSRange range = [[temp objectForKey:@"cityname"] rangeOfString:searchController.searchBar.text];
        if(range.length > 0){
            [searchResult addObject:temp];
        }
    }
    _mySearchResult.searchResults = searchResult;
    [_mySearchResult.tableView reloadData];
}

@end
