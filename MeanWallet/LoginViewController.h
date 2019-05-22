//
//  LoginViewController.h
//  MeanWallet
//
//  Created by MeanFan Moo on 2019/5/15.
//  Copyright © 2019年 MeanFan Moo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "api/ServerCommManager.h"
#import "api/ServerCommManagerDelegate.h"
#import "FirstViewController.h"
@interface LoginViewController : UIViewController<ServerCommManagerDelegate>

@end
