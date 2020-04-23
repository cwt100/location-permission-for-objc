//
//  ViewController.m
//  GPSPermission
//
//  Created by wanting_cheng on 2020/4/21.
//  Copyright © 2020 wanting_cheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    CLLocationManager *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (locationManager == nil) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
    }
    
    locationManager.distanceFilter = kCLHeadingFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied) {
        NSLog(@"viewDidLoad requestWhenInUseAuthorization");
        self.messageTextView.text = @"定位權限已關閉，如要取得更好的服務品質，請至 設定 > 隱私權 > 定位服務 開啟定位功能";
    }
    NSLog(@"viewDidLoad");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear");
    [self updateLocationStatus];
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        NSLog(@"viewDidAppear startUpdatingLocation");
        [locationManager startUpdatingLocation];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.latLabel.text = @"--";
    self.longLabel.text = @"--";
    self.locationStatusLabel.text = @"--";
    self.messageTextView.text = @"--";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"didChangeAuthorizationStatus: %d", status);
    
    self.messageTextView.text = @"";
    self.latLabel.text = @"--";
    self.longLabel.text = @"--";
    [self updateLocationStatus];
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
    }else if(status == kCLAuthorizationStatusDenied) {
        NSLog(@"viewDidLoad requestWhenInUseAuthorization");
        self.messageTextView.text = @"定位權限已關閉，如要取得更好的服務品質，請至 設定 > 隱私權 > 定位服務 開啟定位功能";
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    NSLog(@"didUpdateLocations: %f, %f, %@", location.coordinate.latitude, location.coordinate.longitude, manager);
    self.latLabel.text = [NSString stringWithFormat:@"%.6f", location.coordinate.latitude];
    self.longLabel.text = [NSString stringWithFormat:@"%.6f", location.coordinate.longitude];
    
    self.locationStatusLabel.text = [self getNowTime];
}

- (void)updateLocationStatus {
    if (locationManager == nil) {
        self.locationStatusLabel.text = @"--";
        return;
    }
    
    NSString *statusString = @"";
    self.locationStatusLabel.text = statusString;
    switch (CLLocationManager.authorizationStatus) {
        case kCLAuthorizationStatusNotDetermined:
            statusString = @"kCLAuthorizationStatusNotDetermined";
            break;
        case kCLAuthorizationStatusRestricted:
            statusString = @"kCLAuthorizationStatusRestricted";
            break;
        case kCLAuthorizationStatusDenied:
            statusString = @"kCLAuthorizationStatusDenied";
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            statusString = @"kCLAuthorizationStatusAuthorizedWhenInUse";
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            statusString = @"kCLAuthorizationStatusAuthorizedAlways";
            break;
        default:
            statusString = @"unknow";
            break;
    }
    NSLog(@"STATUS: %@", statusString);
}

- (NSString *)getNowTime {
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    NSString *currentDateString = [formatter stringFromDate:currentTime];
    return currentDateString;
}

@end
