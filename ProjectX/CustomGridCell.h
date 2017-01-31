//
//  CustomGridCell.h
//  ProjectX
//
//  Created by Justin Mathilde on 31/01/2017.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+AFNetworking.h>

@interface CustomGridCell : UITableViewCell
{
    IBOutlet UIImageView *imageView1;
    IBOutlet UIImageView *imageView2;
    IBOutlet UIImageView *imageView3;
    
    IBOutlet UIButton   *video1Play;
    IBOutlet UIButton   *video2Play;
    IBOutlet UIButton   *video3Play;
}

- (void)initCustomGridCell:(NSString*)url1 :(NSString*)url2 :(NSString*)url3;

- (IBAction)video1PlayClicked:(id)sender;
- (IBAction)video2PlayClicked:(id)sender;
- (IBAction)video3PlayClicked:(id)sender;

@end
