//
//  CustomTableViewCell.m
//  TableViewCustomEditControl
//
//  Created by Satish Chauhan on 29/12/14.
//  Copyright (c) 2014 Vinsol. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CustomTableViewCell

- (void)configureCell:(NSDictionary *)infoDictionary {
    self.titleLabel.text = infoDictionary[@"title"];
}

@end
