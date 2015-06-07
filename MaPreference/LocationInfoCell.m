//
//  LocationInfoCell.m
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "LocationInfoCell.h"

@implementation LocationInfoCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    
    CGRect newCellSubViewsFrame = self.bounds;
    CGRect newCellViewFrame = self.frame;
    
    self.contentView.frame = self.contentView.bounds = self.backgroundView.frame = self.accessoryView.frame = newCellSubViewsFrame;
    self.frame = newCellViewFrame;
    
    [super layoutSubviews];
}

@end
