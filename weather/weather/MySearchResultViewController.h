//
//  MySearchResultViewController.h
//  weather
//
//  Created by David on 6/12/17.
//  Copyright © 2017 Dacredible. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListViewController.h"

@interface MySearchResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic,assign) id<CitySelectDelegate> citySelect;
//在MySearchResultViewController添加一个指向展示页的【弱】引用属性。
@property (nonatomic, weak) UIViewController *mainSearchController;

@end
