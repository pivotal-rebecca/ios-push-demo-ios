//
//  MainViewController.h
//  Pusheen
//
//  Created by Rebecca on 2/3/2014.
//  Copyright (c) 2014 Rebecca Putinski. All rights reserved.
//

@interface MainViewController : UIViewController

- (void)updateWithNotification:(NSDictionary *)payload;
- (void)updateLogWithMessage:(NSString *)message;

@end
