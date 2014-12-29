//
//  CustomTableViewCell.h
//  TableViewCustomEditControl
//
//  Created by Satish Chauhan on 29/12/14.
//  Copyright (c) 2014 Vinsol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableViewCell;

@protocol CustomTableViewCellDelegate

@optional

- (void)selectCell:(CustomTableViewCell *)cell;

@end

@interface CustomTableViewCell : UITableViewCell

- (void)configureCell:(NSDictionary *)infoDictionary;
@property (nonatomic, assign) id <CustomTableViewCellDelegate> delegate;

@end
