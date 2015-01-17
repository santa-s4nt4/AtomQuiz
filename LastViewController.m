//
//  LastViewController.m
//  Atom Quiz
//
//  Created by santa naruse on 2014/10/25.
//  Copyright (c) 2014年 santa naruse. All rights reserved.
//

#import "LastViewController.h"
#import <Social/Social.h>

@interface UIViewController ()

@end

@implementation LastViewController
{
    //クイズ画面から正答数を受ける
    int correctPercentage;
    
    //各種ラベル
    IBOutlet UILabel *percentageLabel;
    IBOutlet UILabel *levelLabel;
}

@synthesize correctPercentage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    percentageLabel.font = [UIFont fontWithName:@"AdobeMingStd-Light" size:55];
    levelLabel.font = [UIFont fontWithName:@"AdobeMingStd-Light" size:22];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; //ステータスバーを白色にする
    
    //正答率に応じて「一般常識レベル」の位と画像を設定
    if (correctPercentage >= 0 && correctPercentage <= 30) {
        levelLabel.text = @"まだまだ覚えきれていません!";
    } else if (correctPercentage >= 31 && correctPercentage < 79) {
        levelLabel.text = @"もっと頑張れよ!";
    } else if (correctPercentage >= 80 && correctPercentage < 99) {
        levelLabel.text = @"あともう少しで完璧です!";
    } else if (correctPercentage >= 100){
        levelLabel.text = @"文句無しに完璧です!";
    }

    //実際の正答率を表示
    percentageLabel.text = [NSString stringWithFormat:@"%d %%", correctPercentage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)face
{
    SLComposeViewController *fbVC =
    [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [fbVC setInitialText:@"Why don't you play Atom Quiz?"];
    [self presentViewController:fbVC animated:YES completion:nil];
}

-(IBAction)twitter
{
    SLComposeViewController*twVC =
    [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [twVC setInitialText:@"Why don't you play Atom Quiz?"];
    [self presentViewController:twVC animated:YES completion:nil];
}

-(IBAction)home
{
    [self.navigationController popToRootViewControllerAnimated:YES]; //ルートまで一気に戻る
}

@end
