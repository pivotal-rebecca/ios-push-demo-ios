//
//  AppDelegate.m
//  Pusheen
//
//  Created by Rebecca on 2/3/2014.
//  Copyright (c) 2014 Rebecca Putinski. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [MainViewController new];
    [self.window makeKeyAndVisible];
    
    // Launched via push notification
    if (launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]) {
        [(MainViewController *)self.window.rootViewController updateLogWithMessage:@"Received in app delegate, on launch"];
        [self handleReceivedNotification:launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [(MainViewController *)self.window.rootViewController updateLogWithMessage:[NSString stringWithFormat:@"Registration successful, got device token: %@", deviceToken.description]];
    
    NSLog(@"Device token for copypasta: %@", [deviceToken.description stringByReplacingOccurrencesOfString:@" " withString:@""]);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [(MainViewController *)self.window.rootViewController updateLogWithMessage:[NSString stringWithFormat:@"Registration failed, error: %@", error.description]];
}

// called when remote-notifications background mode is not enabled
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [(MainViewController *)self.window.rootViewController updateLogWithMessage:@"Received in app delegate, not on launch"];
    
    [self handleReceivedNotification:userInfo];
}

// called when remote-notifications background-mode IS enabled
// intended to be used with silent notifications
// fetch data in the background (small amount of time) and call completionHandler
// notifications can also supply true/false for new data, used in handler
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [(MainViewController *)self.window.rootViewController updateLogWithMessage:@"Received in app delegate, not on launch, background handler"];
    
    [self handleReceivedNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)handleReceivedNotification:(NSDictionary *)payload {
    [(MainViewController *)self.window.rootViewController updateWithNotification:payload];
}


#pragma mark - Local notification

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [(MainViewController *)self.window.rootViewController updateLogWithMessage:@"Received local notification"];
}

#pragma mark - other stuff

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

@end
