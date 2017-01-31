//
//  SideMenuRootVC.m
//  ProjectX
//
//  Created by Zaighum on 1/29/17.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import "SideMenuRootVC.h"

@implementation SideMenuRootVC

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
}

@end
