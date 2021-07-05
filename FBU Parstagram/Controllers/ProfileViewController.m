//
//  ProfileViewController.m
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/4/21.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "ProfileMenuViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ProfileMenuViewController *vc = [segue destinationViewController];
    [vc.tabBarController.tabBar removeFromSuperview];
}


@end
