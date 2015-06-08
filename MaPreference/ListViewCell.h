//
//  ListViewCell.h
//  MaPreference
//
//  Created by Abegael Jackson & Oliver Andrews on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson & Oliver Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *listNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *listAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *listDistanceLabel;


@end
