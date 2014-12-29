//
//  CustomTableViewCell.m
//  TableViewCustomEditControl
//
//  Created by Satish Chauhan on 29/12/14.
//  Copyright (c) 2014 Vinsol. All rights reserved.
//

#import "CustomTableViewCell.h"

static NSInteger const kCustomEditControlWidth=42;

@interface CustomTableViewCell ()

@property (nonatomic, getter=isPseudoEditing) BOOL pseudoEdit;
@property (nonatomic, getter=isDeleting) BOOL deleting;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *customEditControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingSpaceMainViewConstraint;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CustomTableViewCell

#pragma mark - Life Cycle

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    if ([self.delegate isPseudoEditing]) {
        self.pseudoEdit = editing;
        [self beginEditMode];
    } else {
        [super setEditing:editing animated:animated];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.customEditControl.selected = selected;
}

//- (void)willTransitionToState:(UITableViewCellStateMask)state {
//    if(state & UITableViewCellStateShowingDeleteConfirmationMask) {
//        self.deleting = YES;
//    } else if(!(state & UITableViewCellStateShowingDeleteConfirmationMask)) {
//        self.deleting = NO;
//    }
//
//    //[super willTransitionToState:state];
//}


#pragma mark - Public API
- (void)configureCell:(NSDictionary *)infoDictionary {
    self.titleLabel.text = infoDictionary[@"title"];
}

#pragma mark - Cell custom edit control Action

- (IBAction)customEditControlPressed:(id)sender {
    // [self setSelected:YES animated:YES];
    [self.delegate selectCell:self];
}


#pragma mark - Private Method

// Animate view to show/hide custom edit control/button
- (void)beginEditMode {
    self.leadingSpaceMainViewConstraint.constant = self.isPseudoEditing ? 0 : -kCustomEditControlWidth;

    [UIView animateWithDuration:0.3 animations:^{
        [self.mainView.superview layoutIfNeeded];
    }];
}

@end
