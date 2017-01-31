//
//  SelectCategoryVC.m
//  ProjectX
//
//  Created by Zaighum on 1/29/17.
//  Copyright © 2017 Zaighumavicenna. All rights reserved.
//

#import "SelectCategoryVC.h"
#import <UIViewController+CWPopup.h>
#import "CategoriesListVC.h"
@interface SelectCategoryVC ()

@end

@implementation SelectCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.selectCategoriesBtn.layer setBorderWidth:1.0];
    [self.selectCategoriesBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeBtnTapped) name:@"closeBtnTapped" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneBtntapped) name:@"doneBtnTapped" object:nil];

    
    self.useBlurForPopup = YES;
    
}

- (void) closeBtnTapped
{
    [self dismissPopupViewControllerAnimated:YES completion:NULL];
}

- (void) doneBtntapped
{
    [self dismissPopupViewControllerAnimated:YES completion:NULL];
    [self performSegueWithIdentifier:@"toRootVC" sender:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)selectCategoriesBtnTapped:(id)sender {
    CategoriesListVC *popUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"categoryListPopUp"];
    popUpVC.view.frame = CGRectMake(0, 0, 300, 480);

    [self presentPopupViewController:popUpVC animated:YES completion:NULL];
    
    
}

@end
