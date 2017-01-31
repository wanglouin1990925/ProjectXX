//
//  LeftMenuVC.m
//  ProjectX
//
//  Created by Zaighum on 1/29/17.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import "LeftMenuVC.h"
#import "SideMenuCell.h"
#import <UIViewController+RESideMenu.h>
#import "HomeVC.h"
#import "SuggestedVC.h"
@interface LeftMenuVC ()
{
    NSMutableArray *listOfItems;
    NSMutableArray *listOfImages;
    
}
@end

@implementation LeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    listOfItems = [[NSMutableArray alloc] initWithObjects:@"Home", @"Suggested", nil];
    listOfImages = [[NSMutableArray alloc] initWithObjects:@"iconHome",@"suggest_icon", nil];
    self.tblVu.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.nameLbl.text = [listOfItems objectAtIndex:indexPath.row];
    cell.imgVu.image = [UIImage imageNamed:[listOfImages objectAtIndex:indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeVC *homeVc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    SuggestedVC *suggestedVC = [self.storyboard instantiateViewControllerWithIdentifier:@"suggestedVC"];

    if (indexPath.row == 0)
    {
        [self.sideMenuViewController setContentViewController:homeVc animated:YES];
        [self.sideMenuViewController hideMenuViewController];


    }
    else if (indexPath.row == 1)
    {
        [self.sideMenuViewController setContentViewController:suggestedVC animated:YES];
        [self.sideMenuViewController hideMenuViewController];


    }
    
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
