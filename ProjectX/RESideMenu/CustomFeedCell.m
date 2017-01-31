//
//  CustomFeedCell.m
//  Snapgram
//
//  Created by GenghisKhan on 4/22/15.
//  Copyright (c) 2015 GenghisKhan. All rights reserved.
//

#import "CustomFeedCell.h"
#import "AppDelegate.h"

#import <FirebaseStorage/FirebaseStorage.h>
#import <UIImageView+AFNetworking.h>

@implementation CustomFeedCell

- (void)awakeFromNib
{
    // Initialization code
    
    [super awakeFromNib];
}

-(void)initCustomFeedCell:(NSDictionary*) dictData :(NSString*) strCategory
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[[[dictData objectForKey:@"location"] objectForKey:@"latitude"] floatValue] longitude:[[[dictData objectForKey:@"location"] objectForKey:@"longitude"] floatValue]];
    
    
    [lblTitle setText:[dictData objectForKey:@"name"]];
    [lblDistance setText:[NSString stringWithFormat:@"%.1fmi",[location distanceFromLocation:[AppDelegate sharedDelegate].location]/1609.344f]];
    [lblCategory setText:strCategory];
    
    NSString *imgPath = [NSString stringWithFormat:@"gs://my-awesome-project-f3c97.appspot.com/%@", [dictData objectForKey:@"photo"]];
    
    FIRStorageReference *storageRef = [[FIRStorage storage] referenceForURL:imgPath];
    
    [storageRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
       
        if(error != nil) {
            
            
        } else {
            
            [imgEvent setImageWithURL:URL placeholderImage:nil];
            
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
