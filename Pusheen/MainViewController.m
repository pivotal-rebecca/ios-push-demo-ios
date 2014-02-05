//
//  MainViewController.m
//  Pusheen
//
//  Created by Rebecca on 2/3/2014.
//  Copyright (c) 2014 Rebecca Putinski. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@end

@implementation MainViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateLogWithMessage:@"Log started"];
}

- (void)updateWithNotification:(NSDictionary *)payload {
    [self updateLogWithMessage:[NSString stringWithFormat:@"Got push notification!\n%@", payload]];
    
    if (payload[@"image_url"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:payload[@"image_url"]]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                _imageView.image = image;
            });
        });
    }
}

- (IBAction)registerForRemoteNotificationsTapped:(id)sender {
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert];
}

- (IBAction)unregisterTapped:(id)sender {
    [self updateLogWithMessage:@"Unregister notifications."];
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}

- (IBAction)scheduleLocalNotification:(id)sender {
    [self updateLogWithMessage:@"Scheduling notification to fire in 5 seconds"];
    
    UILocalNotification *local = [UILocalNotification new];
    local.alertBody = @"This is a local notification";
    local.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    [[UIApplication sharedApplication] scheduleLocalNotification:local];
}

- (void)updateLogWithMessage:(NSString *)message {
    _logTextView.text = [message stringByAppendingFormat:@"\n\n%@", _logTextView.text];
}

@end
