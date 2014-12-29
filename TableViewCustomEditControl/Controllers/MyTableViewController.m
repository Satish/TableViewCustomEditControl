//
//  MyTableViewController.m
//  NavigationBarTesting
//
//  Created by Satish Chauhan on 11/12/14.
//  Copyright (c) 2014 Vinsol. All rights reserved.
//

#import "MyTableViewController.h"
#import "CustomTableViewCell.h"

static NSString *const kTableViewCellIdentifier = @"CustomTableViewCellIdentifier";

@interface MyTableViewController ()

@property (strong, nonatomic) NSArray *records;

@end

@implementation MyTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.records = @[@"Title Record 1", @"Title Record 2", @"Title Record 3", @"Title Record 4"];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.records.count;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier];
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewCellIdentifier];
    }

    NSDictionary *infoDictionary = @{ @"title":self.records[indexPath.row] };
    [cell configureCell:infoDictionary];

    [cell setEditing:self.isEditing];

    return cell;
}


#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
