//
//  NewViewController.m
//  SegmentedControl + PageViewControl
//
//  Created by Jian Yao Ang on 12/27/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *theLabel;

@property (weak, nonatomic) IBOutlet UITableView *theTable;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"New VC";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = @"Hello";
    return cell;
}
@end
