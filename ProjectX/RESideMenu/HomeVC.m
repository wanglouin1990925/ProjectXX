//
//  HomeVC.m
//  ProjectX
//
//  Created by Zaighum on 1/29/17.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import "HomeVC.h"
#import "EventDetailViewController.h"

#import <RESideMenu.h>
#import <UIViewController+RESideMenu.h>
#import <Firebase.h>


@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [tblHome registerNib:[UINib nibWithNibName:@"CustomFeedCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    lstEvent    = [[NSMutableArray alloc] init];
    lstCategory = [[NSMutableArray alloc] init];
    
    [[ref child:@"Categories"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSDictionary *dictData = snapshot.value;

        for (int i = 0; i < [[dictData allKeys] count]; i++) {
         
            [lstEvent       addObject:[[dictData objectForKey:[[dictData allKeys] objectAtIndex:i]] objectAtIndex:0]];
            [lstCategory    addObject:[[dictData allKeys] objectAtIndex:i]];
            
        }
        
        [tblHome reloadData];
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error.localizedDescription);
    
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [lstEvent count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell initCustomFeedCell:[lstEvent objectAtIndex:indexPath.row] :[lstCategory objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventDetailViewController *viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
    
    viewcontroller.strCategory  = [lstCategory objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:viewcontroller animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 116;
}

- (IBAction)sideMenuBtnTapped:(id)sender {
    [self presentLeftMenuViewController:nil];
    
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
