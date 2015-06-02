//
//  LocationInfoCell.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationPhoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbsUpImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbsDownImageView;

@end
