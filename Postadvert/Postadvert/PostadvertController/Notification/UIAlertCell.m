//
//  UIAlertCell.m
//  Postadvert
//
//  Created by Mtk Ray on 6/27/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "UIAlertCell.h"

@interface  UIAlertCell ()
- (IBAction)btnConfirmClicked:(id)sender;
- (IBAction)btnNotNowClicked:(id)sender;
@end

@implementation UIAlertCell
@synthesize imageAvatar, userName, mutiFriends, btnNotNow, btnConfirm;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"UIAlertCell" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
    self = [topLevelObjects objectAtIndex:0];
    topLevelObjects = nil;
    if (!self) {
        // Initialization code
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - ACTION

-(IBAction)btnNotNowClicked:(id)sender
{
    
}
-(IBAction)btnConfirmClicked:(id)sender
{
    self.btnConfirm.hidden = YES;
    self.btnNotNow.hidden = YES;
    self.mutiFriends.text = @"You are friends now.";
}
@end
