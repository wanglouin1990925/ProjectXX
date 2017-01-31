//
//  CustomEventHeaderView.h
//  ProjectX
//
//  Created by Justin Mathilde on 31/01/2017.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomEventHeaderView : UIView
{
    IBOutlet UIImageView    *imgEvent;
    IBOutlet UILabel        *lblCategory;
    IBOutlet UILabel        *lblDescription;
    IBOutlet UILabel        *lblAddress;
    IBOutlet UILabel        *lblDistance;
}

-(void)initCustomEventHeaderView:(NSDictionary*) dictData :(NSString*) strCategory;
+(id)sharedView;

@end
