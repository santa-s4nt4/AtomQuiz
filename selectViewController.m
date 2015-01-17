//
//  selectViewController.m
//  Atom Quiz
//
//  Created by santa naruse on 2014/12/06.
//  Copyright (c) 2014年 santa naruse. All rights reserved.
//

#import "selectViewController.h"

@interface selectViewController ()

@end

@implementation selectViewController
{
    //各種ラベル
    IBOutlet UILabel *atomLabel;
    IBOutlet UILabel *chemicalLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    atomLabel.font = [UIFont fontWithName:@"AdobeMingStd-Light" size:41];
    chemicalLabel.font = [UIFont fontWithName:@"AdobeMingStd-Light" size:41];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)home
{
    [self.navigationController popToRootViewControllerAnimated:YES]; //ルートまで一気に戻る
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
