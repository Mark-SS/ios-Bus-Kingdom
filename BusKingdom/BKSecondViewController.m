//
//  BKSecondViewController.m
//  BusKingdom
//
//  Created by yy on 13-7-15.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKSecondViewController.h"
#import "BKLine.h"
#import "BKMapViewController.h"
#import "BKMapUtils.h"
#import "BKSelectLineViewController.h"
#import "BKBusStationInfo.h"

@interface BKSecondViewController ()

@property (nonatomic, strong) NSArray *buses;
@property (nonatomic, strong) NSArray *stationData;

@end

@implementation BKSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self
                            action:@selector(loadBusLine:)
                  forControlEvents:UIControlEventValueChanged];
    
    [[BKBusStationInfo new]file];
    
    _stationData = @[
                     @{@"name" : @"四惠", @"lat" : @39.90913, @"lng" : @116.49795},
                     @{@"name" : @"大郊亭桥", @"lat" : @39.89329, @"lng" : @116.48990},
                     @{@"name" : @"燕莎奥特莱斯", @"lat" : @39.8797, @"lng" : @116.4887},
                     @{@"name" : @"弘燕桥", @"lat" : @39.86680, @"lng" : @116.48788},
                     @{@"name" : @"肖村桥", @"lat" : @39.83265, @"lng" : @116.44782},
                     @{@"name" : @"大红门桥", @"lat" : @39.83177, @"lng" : @116.40147},
                     @{@"name" : @"公益东桥", @"lat" : @39.83220, @"lng" : @116.38851},
                     @{@"name" : @"公益西桥", @"lat" : @39.83168, @"lng" : @116.36948},
                     @{@"name" : @"总部基地", @"lat" : @39.8275, @"lng" : @116.2882}
                     ];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadBusLine:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//切换ViewController时调用方法
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"11");
    if ([segue.identifier isEqualToString:@"mapSegue"]) {
        UINavigationController *nav = segue.destinationViewController;
        BKMapViewController *ctrl = nav.viewControllers[0];
        ctrl.buses = _buses;
        ctrl.row = [sender intValue];
        ctrl.busStations = _stationData;
    }
    else if ([segue.identifier isEqualToString:@"lineSegue"])
    {
        UINavigationController *nav = segue.destinationViewController;
        BKSelectLineViewController *selectLine = nav.viewControllers[0];
        selectLine.returnBlock = ^(id object){
            NSDictionary *dic = (NSDictionary *)object;
            _stationData = [dic objectForKey:@"station"];
            [self.selectLineBtn setTitle:[dic objectForKey:@"title"]];
            [self.tableView reloadData];
        };
        
    }
}

#pragma mark -
#pragma mark tableView DataSoures Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"stationCell";
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    NSDictionary *row = _stationData[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d. %@", indexPath.row + 1, row[@"name"]];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", row[@"lat"], row[@"lng"]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_stationData count];
}

#pragma mark -
#pragma mark tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary * dic = @{@"row": [NSNumber numberWithInt:indexPath.row]};
    [self performSegueWithIdentifier:@"mapSegue" sender:@(indexPath.row + 1)];
}

#pragma mark - custom methods

- (IBAction)loadBusLine:(id)sender {
    BKLine *line = [[BKLine alloc] init];
    [line queryBusesForLine:@"2" completion:^(id response, NSError *error) {
        NIDPRINT(@"x %@", response);
        if (response[@"result"]) {
            _buses = response[@"result"];
        }
        
        NSMutableArray *points = [NSMutableArray array];
        for (NSDictionary *v in _stationData) {
            CLLocationDegrees lat = [v[@"lat"] floatValue];
            CLLocationDegrees lng = [v[@"lng"] floatValue];
            CLLocation *loc = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
            [points addObject:loc];
        }
        
        for (NSDictionary *v in _buses) {
            CLLocationDegrees lat = [v[@"lat"] floatValue];
            CLLocationDegrees lng = [v[@"lng"] floatValue];
            CLLocation *loc = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
            CLLocation *nearestPoint = [BKMapUtils findNearestLocationForPoint:loc withPoints:points];
            NSLog(@"p %@", nearestPoint);
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark -
#pragma mark IBAction
- (IBAction)modelMapView:(id)sender {
    
    [self performSegueWithIdentifier:@"mapSegue" sender:nil];
}


@end
