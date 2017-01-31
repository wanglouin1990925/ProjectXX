//
//  CustomFeedCell.h
//  ProjectX
//
//  Created by Justin Mathilde on 31/01/2017.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomFeedCell : UITableViewCell
{
    IBOutlet UIImageView    *imgEvent;
    IBOutlet UILabel        *lblDistance;
    IBOutlet UILabel        *lblTitle;
    IBOutlet UILabel        *lblCategory;
}

-(void)initCustomFeedCell:(NSDictionary*) dictData :(NSString*) strCategory;

@end
