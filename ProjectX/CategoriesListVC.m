//
//  CategoriesListVC.m
//  ProjectX
//
//  Created by Zaighum on 1/29/17.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import "CategoriesListVC.h"
#import "CategoryCell.h"
@interface CategoriesListVC ()
{
    NSMutableArray *listOfCategories;
    NSMutableArray *listOfCategoriesImages;
    NSMutableArray *arrayOfSelectedCategories;

}
@end

@implementation CategoriesListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrayOfSelectedCategories = [[NSMutableArray alloc] init];
    [self.doneBtn.layer setBorderWidth:1.0];
    [self.doneBtn.layer setBorderColor:[UIColor colorWithRed:60.0/255.0 green:53.0/255.0 blue:43.0/255.0 alpha:1].CGColor];
    listOfCategories = [[NSMutableArray alloc] initWithObjects:@"Heart of The City",@"Entertainment",@"Culture",@"Sports",@"Music",@"Food", nil];
    listOfCategoriesImages = [[NSMutableArray alloc] initWithObjects:@"HeartOfCity",@"entertainment",@"culture",@"sports",@"music",@"barbecue", nil];
    arrayOfSelectedCategories = [[NSMutableArray alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfCategories.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
    cell.categoryName.text = [listOfCategories objectAtIndex:indexPath.row ];
    [cell.categoryName setTextColor:[UIColor colorWithRed:60.0/255.0 green:53.0/255.0 blue:43.0/255.0 alpha:1]];
    cell.categoryImgVu.image = [UIImage imageNamed:[listOfCategoriesImages objectAtIndex:indexPath.row]];
    
    if ([arrayOfSelectedCategories containsObject:[listOfCategories objectAtIndex:indexPath.row]])
    {
        cell.selectedImgVu.image = [UIImage imageNamed:@"Green_tick"];
    }
    else
    {
        cell.selectedImgVu.image = nil;
         
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([arrayOfSelectedCategories containsObject:[listOfCategories objectAtIndex:indexPath.row]])
    {
        [arrayOfSelectedCategories removeObject:[listOfCategories objectAtIndex:indexPath.row]];
        [self.listTblVu reloadData];
    }
    else
    {
        [arrayOfSelectedCategories addObject:[listOfCategories objectAtIndex:indexPath.row]];
        [self.listTblVu reloadData];

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
- (IBAction)crossBtnTapped:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeBtnTapped" object:nil];
}
- (IBAction)doneBtnTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"doneBtnTapped" object:nil];

}

@end
