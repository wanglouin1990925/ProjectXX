//
//  CustomEventHeaderView.m
//  ProjectX
//
//  Created by Justin Mathilde on 31/01/2017.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import "CustomEventHeaderView.h"
#import "AppDelegate.h"

#import <FirebaseStorage/FirebaseStorage.h>
#import <UIImageView+AFNetworking.h>

@implementation CustomEventHeaderView

+(id)sharedView {
    
    CustomEventHeaderView *customView = [[[NSBundle mainBundle] loadNibNamed:@"CustomEventHeaderView" owner:nil options:nil] lastObject];
    
    // make sure customView is not nil or the wrong class!
    if ([customView isKindOfClass:[CustomEventHeaderView class]])
        return customView;
    else
        return nil;
}

-(void)initCustomEventHeaderView:(NSDictionary*) dictData :(NSString*) strCategory {
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[[[dictData objectForKey:@"location"] objectForKey:@"latitude"] floatValue] longitude:[[[dictData objectForKey:@"location"] objectForKey:@"longitude"] floatValue]];
    
    [lblDistance    setText:[NSString stringWithFormat:@"%.1fmi away",[location distanceFromLocation:[AppDelegate sharedDelegate].location]/1609.344f]];
    [lblCategory    setText:strCategory];
    [lblDescription setText:[dictData objectForKey:@"description"]];
    [lblAddress      setText:[[dictData objectForKey:@"location"] objectForKey:@"place"]];
    
    NSString *imgPath = [NSString stringWithFormat:@"gs://my-awesome-project-f3c97.appspot.com/%@", [dictData objectForKey:@"photo"]];
    
    FIRStorageReference *storageRef = [[FIRStorage storage] referenceForURL:imgPath];
    
    [storageRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
        
        if(error != nil) {
            
            
        } else {
            
            [imgEvent setImageWithURL:URL placeholderImage:nil];
        }
    }];
}

@end
