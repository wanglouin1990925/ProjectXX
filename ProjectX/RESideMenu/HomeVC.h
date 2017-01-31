//
//  HomeVC.h
//  ProjectX
//
//  Created by Zaighum on 1/29/17.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <FirebaseStorage/FirebaseStorage.h>

#import "CustomFeedCell.h"

@interface HomeVC : UIViewController<UITableViewDataSource, UITableViewDataSource>
{
    IBOutlet UITableView *tblHome;
    
    NSMutableArray  *lstEvent;
    NSMutableArray  *lstCategory;
}

@property (weak, nonatomic) IBOutlet UIButton *sideMenuBtn;

@end
