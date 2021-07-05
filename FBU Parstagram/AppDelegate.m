//
//  AppDelegate.m
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/3/21.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Accessing Client_Key and App_Id from Keys.plist
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString *clientKey = [dict objectForKey: @"Client_Key"];
    NSString *appId = [dict objectForKey: @"App_Id"];
    
//    // Code to initialize Parse
//    // Override point for customization after application launch.
//    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
//        configuration.applicationId = appId; // <- UPDATE
//        configuration.clientKey = clientKey; // <- UPDATE
//        configuration.server = @"https://parseapi.back4app.com";
//    }];
//
//    [Parse initializeWithConfiguration:config];
//
//    if (PFUser.currentUser) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"AuthenticatedViewController"];
//    }

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

@end
