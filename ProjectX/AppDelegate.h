//
//  AppDelegate.h
//  ProjectX
//
//  Created by Zaighum on 1/29/17.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

+(AppDelegate*)sharedDelegate;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) CLLocation *location;

@end

