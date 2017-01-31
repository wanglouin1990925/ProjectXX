//
//  EventDetailViewController.m
//  ProjectX
//
//  Created by Justin Mathilde on 31/01/2017.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import "EventDetailViewController.h"
#import "CustomGridCell.h"
#import "CustomEventHeaderView.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

@synthesize strCategory;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [tblMedia registerNib:[UINib nibWithNibName:@"CustomGridCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    
    [lblName    setText:strCategory];
    
    dbRef       = [[FIRDatabase database]   reference];
    lstMedia    = [[NSMutableArray alloc] init];
    
    [self   loadData];
}

- (void)loadData {
    
    [[[dbRef child:@"Categories"] child:strCategory] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        [lstMedia removeAllObjects];
        
        dictData    = [snapshot.value objectAtIndex:0];
        storageRef  = [[FIRStorage storage]     referenceForURL:[NSString stringWithFormat:@"gs://my-awesome-project-f3c97.appspot.com/%@", [dictData objectForKey:@"media"]]];
        
        if ([dictData objectForKey:@"mediaurl"]) {
            
            for (int i = 0; i < [[[dictData objectForKey:@"mediaurl"] allKeys] count]; i++) {
                
                NSString *strKey = [[[dictData objectForKey:@"mediaurl"] allKeys] objectAtIndex:i];
                [lstMedia addObject:[[dictData objectForKey:@"mediaurl"] objectForKey:strKey]];
            }
        }
        
        [tblMedia   reloadData];
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error.localizedDescription);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showCameraView:(BOOL)isLibrary {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        isLibrary = true;
        
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate             = self;
    picker.allowsEditing        = false;
    picker.videoMaximumDuration = 15;
    
    if (isLibrary) {
        
        picker.sourceType           = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes           = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    } else {
        
        picker.sourceType           = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes           = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)btnUploadClicked:(id)sender {
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* library = [UIAlertAction
                         actionWithTitle:@"Library "
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self showCameraView:true];
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* camera = [UIAlertAction
                             actionWithTitle:@"Camera"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self showCameraView:false];
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:library];
    [view addAction:camera];
    [view addAction:cancel];
    
    [self presentViewController:view animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    NSData *data;
    
    BOOL isVideo = false;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        UIImage *imgResult = (UIImage *) [info objectForKey:
                                          UIImagePickerControllerOriginalImage];
        data = UIImageJPEGRepresentation(imgResult, 0.01);
        isVideo = false;
    }
 
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        data = [NSData dataWithContentsOfURL:videoURL];
        isVideo = true;
    }

    [picker dismissViewControllerAnimated:YES completion:^{
       
        [self upload:data :isVideo];
    }];
}

- (void)upload:(NSData*)data :(BOOL)isVideo {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    
    NSString *strFileName = [NSString stringWithFormat:@"%@%@",[[[UIDevice currentDevice] identifierForVendor] UUIDString],[formatter stringFromDate:[NSDate date]]];
    
    if (isVideo)
        strFileName = [NSString stringWithFormat:@"%@.mov", strFileName];
    else
        strFileName = [NSString stringWithFormat:@"%@.jpeg", strFileName];
    
    FIRStorageReference *uploadRef  = [storageRef child:strFileName];
    FIRStorageMetadata *metadata    = [[FIRStorageMetadata alloc] init];
    
    if (isVideo)
        metadata.contentType            = @"video/quicktime";
    else
        metadata.contentType            = @"image/jpeg";
    
    FIRStorageUploadTask *uploadTask = [uploadRef putData:data metadata:metadata];
    
    [uploadTask observeStatus:FIRStorageTaskStatusProgress handler:^(FIRStorageTaskSnapshot * _Nonnull snapshot) {
       
        double percent = (100.0 * snapshot.progress.completedUnitCount) / (snapshot.progress.totalUnitCount);
        NSLog(@"%f", percent);
    }];
    
    [uploadTask observeStatus:FIRStorageTaskStatusSuccess handler:^(FIRStorageTaskSnapshot * _Nonnull snapshot) {
        
        NSLog(@"Upoad completed successfully");
        
        if ([lstMedia count] > 0) {
            
            int nMaxID = 0;
            
            NSArray *lstKey = [[dictData objectForKey:@"mediaurl"] allKeys];
            
            for (int i = 0; i < [lstKey count]; i++) {
                
                if (nMaxID < [[[lstKey objectAtIndex:i] substringFromIndex:1] intValue]) {
                    
                    nMaxID = [[[lstKey objectAtIndex:i] substringFromIndex:1] intValue];
                }
            }

            NSString *strKey = [NSString stringWithFormat:@"m%d", nMaxID + 1];
            
            [[[[[[dbRef child:@"Categories"] child:strCategory] child:@"0"] child:@"mediaurl"] child:strKey] setValue:snapshot.metadata.downloadURL.absoluteString];
        } else {
            
            [[[[[[dbRef child:@"Categories"] child:strCategory] child:@"0"] child:@"mediaurl"] child:@"m0"] setValue:snapshot.metadata.downloadURL.absoluteString];
        }
        
        [self loadData];
    }];
    
    [uploadTask observeStatus:FIRStorageTaskStatusResume handler:^(FIRStorageTaskSnapshot * _Nonnull snapshot) {
        
        NSLog(@"Upoad resumed");
    }];
    
    [uploadTask observeStatus:FIRStorageTaskStatusPause handler:^(FIRStorageTaskSnapshot * _Nonnull snapshot) {
          
        NSLog(@"Upoad paused");
    }];
              
    [uploadTask observeStatus:FIRStorageTaskStatusFailure handler:^(FIRStorageTaskSnapshot * _Nonnull snapshot) {
       
        if (snapshot.error != nil) {
            
            switch (snapshot.error.code) {
                case FIRStorageErrorCodeObjectNotFound:
                    
                    NSLog(@"File does not exist");
                    break;
                case FIRStorageErrorCodeUnauthorized:
                    
                    NSLog(@"User does not have permission to access file");
                    break;
                case FIRStorageErrorCodeCancelled:
                    
                    NSLog(@"User canceled the upload");
                    break;
                case FIRStorageErrorCodeUnknown:
                    
                    NSLog(@"Unknown error occured");
                    break;
                default:
                    break;
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([lstMedia count] % 3 == 0) {
        
        return [lstMedia count]/3;
        
    } else {
        
        return [lstMedia count]/3 + 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    CustomGridCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSString *url1 = [lstMedia objectAtIndex:indexPath.row * 3];
    
    NSString *url2 = @"";
    
    if ([lstMedia count] > indexPath.row * 3 + 1) {
        
        url2 = [lstMedia objectAtIndex:indexPath.row * 3 + 1];
    }
    
    NSString *url3 = @"";
    
    if ([lstMedia count] > indexPath.row * 3 + 2) {
        
        url3 = [lstMedia objectAtIndex:indexPath.row * 3 + 2];
    }
    
    [cell initCustomGridCell:url1 :url2 :url3];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 126;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 220;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CustomEventHeaderView *view = [CustomEventHeaderView sharedView];
    [view initCustomEventHeaderView:dictData :strCategory];
    
    return view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
