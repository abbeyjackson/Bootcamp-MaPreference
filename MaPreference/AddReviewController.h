//
//  AddReviewController.h
//  MaPreference
//
//  Created by Abegael Jackson on 2015-06-02.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddReviewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *addReviewNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addReviewAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *addReviewPhoneLabel;
@property (weak, nonatomic) IBOutlet UITextView *addReviewTextField;
@property (weak, nonatomic) IBOutlet UIButton *addReviewCancelButton;
@property (weak, nonatomic) IBOutlet UIButton *addReviewDoneButton;


@end
