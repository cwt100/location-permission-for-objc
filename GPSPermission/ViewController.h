//
//  ViewController.h
//  GPSPermission
//
//  Created by wanting_cheng on 2020/4/21.
//  Copyright © 2020 wanting_cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *longLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationStatusLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@end

