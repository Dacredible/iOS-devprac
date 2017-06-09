//
//  CityListViewController.h
//  weather
//
//  Created by David on 6/7/17.
//  Copyright © 2017 Dacredible. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitySelectDelegate <NSObject>
-(void)citySelect:(NSDictionary *)dic;
@end

@interface CityListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *listData;
@property (nonatomic,assign) id<CitySelectDelegate>cityDelegate;

@end
