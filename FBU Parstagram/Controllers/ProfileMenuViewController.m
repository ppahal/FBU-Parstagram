//
//  ProfileMenuViewController.m
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/4/21.
//

#import "ProfileMenuViewController.h"
#import "Parse/Parse.h"

@interface ProfileMenuViewController ()

@end

@implementation ProfileMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar removeFromSuperview];
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.alpha = 0;
}

- (IBAction)clickOutsideMenu:(id)sender {
    NSLog(@"%s", "Back to main");
    //[self performSegueWithIdentifier:@"ProfileSegue" sender:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        NSLog(@"%s", "Logout successful");
        [self performSegueWithIdentifier:@"logoutSegue" sender:self];
    }];
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
