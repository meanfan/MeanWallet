//
//  LoginViewController.m
//  MeanWallet
//
//  Created by MeanFan Moo on 2019/5/15.
//  Copyright © 2019年 MeanFan Moo. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController()
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation LoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
}
- (IBAction)loginOnClick:(id)sender {
    NSString *username=_usernameTF.text;
    NSString *password=_passwordTF.text;
    if(username.length==0 || password.length==0){
        //notify
    }else{
        //login
    }
}

@end
