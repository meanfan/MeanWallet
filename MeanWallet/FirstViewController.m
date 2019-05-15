//
//  FirstViewController.m
//  MeanWallet
//
//  Created by MeanFan Moo on 2019/5/11.
//  Copyright © 2019年 MeanFan Moo. All rights reserved.
//

#import "FirstViewController.h"
#import "api/ServerCommManager.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[ServerCommManager instance] loginAs:@"meantest" password:@"test123456"];
}


@end
