//
//  CustomGridCell.m
//  ProjectX
//
//  Created by Justin Mathilde on 31/01/2017.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import "CustomGridCell.h"

#import <AVFoundation/AVFoundation.h>

@implementation CustomGridCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
}

- (void)initCustomGridCell:(NSString*)url1 :(NSString*)url2 :(NSString*)url3 {
    
    if ([url1 containsString:@".mov"]) {
        
        [imageView1 setImage:[self getThumbnailFromVideo:url1]];
        [video1Play setHidden:false];
        
    } else{
        
        [imageView1 setImageWithURL:[NSURL URLWithString:url1] placeholderImage:nil];
        [video1Play setHidden:true];
    }
    
    if ([url2 containsString:@".mov"]) {
        
        [imageView2 setImage:[self getThumbnailFromVideo:url2]];
        [video2Play setHidden:false];
        
    } else{
        
        [imageView2 setImageWithURL:[NSURL URLWithString:url2] placeholderImage:nil];
        [video2Play setHidden:true];
    }
    
    if ([url3 containsString:@".mov"]) {
        
        [imageView3 setImage:[self getThumbnailFromVideo:url3]];
        [video3Play setHidden:false];
        
    } else{
        
        [imageView3 setImageWithURL:[NSURL URLWithString:url3] placeholderImage:nil];
        [video3Play setHidden:true];
    }
}

- (IBAction)video1PlayClicked:(id)sender {
    
}

- (IBAction)video2PlayClicked:(id)sender {
    
}

- (IBAction)video3PlayClicked:(id)sender {
    
}

- (UIImage*)getThumbnailFromVideo:(NSString*)path
{
    NSURL *partOneUrl = [NSURL URLWithString:path];
    AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:partOneUrl options:nil];
    AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
    generate1.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 2);
    CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
    
    return [[UIImage alloc] initWithCGImage:oneRef];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
