//
//  EventDetailViewController.h
//  ProjectX
//
//  Created by Justin Mathilde on 31/01/2017.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FirebaseStorage/FirebaseStorage.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface EventDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UITableView *tblMedia;
    IBOutlet UILabel    *lblName;
    
    FIRStorageReference *storageRef;
    FIRDatabaseReference *dbRef;
    
    NSMutableArray  *lstMedia;
    NSDictionary    *dictData;
}

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnUploadClicked:(id)sender;

@property (nonatomic, retain) NSString      *strCategory;

@end
