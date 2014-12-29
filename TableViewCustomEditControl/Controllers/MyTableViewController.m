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

@interface MyTableViewController () <CustomTableViewCellDelegate>

@property (strong, nonatomic) NSArray *records;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, getter=isPseudoEditing) BOOL pseudoEdit;

@end

@implementation MyTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addEditButton];
    self.records = @[@"Title Record 1", @"Title Record 2", @"Title Record 3", @"Title Record 4"];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // Move this asignment to the method/action that
    // handles table editing for bulk operation.
    self.pseudoEdit = YES;

    [super setEditing:editing animated:animated];
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

    cell.delegate = self;

    NSDictionary *infoDictionary = @{ @"title":self.records[indexPath.row] };
    [cell configureCell:infoDictionary];

    [cell setEditing:self.isEditing];

    return cell;
}


#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


#pragma mark - CustomTableViewCellDelegate

- (void)selectCell:(CustomTableViewCell *)cell {
    NSIndexPath *indexPath =  [self.tableView indexPathForCell:cell];
    UITableView *tableView = self.tableView;

    if (!!cell.selected) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];

        // Above method will not call the below delegate methods
        if ([tableView.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
            [tableView.delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
        }
        if ([tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    } else {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

        // Above method will not call the below delegate methods
        if ([tableView.delegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
            [tableView.delegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
        }
        if ([tableView.delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
            [tableView.delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
        }
    }
}


#pragma mark - Private Method

- (void)addEditButton {
    UIBarButtonItem *editItem = self.editButtonItem;
    editItem.tintColor = [UIColor colorWithRed:134.0/255 green:184.0/255 blue:9.0/255 alpha:1];
    self.navigationItem.rightBarButtonItem = editItem;
}

@end
