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
        [[ServerCommManager instance]loginAs:username password:password delegate:self];
        
    }
}

/* impl ServerCommManagerDelegate*/
-(void)returnWithStatusCode:(long)statusCode withDict:(NSDictionary*)dict{
    NSLog(@"[login] responseStatusCode:%ld\ndata:\n %@\n--------------",statusCode,dict);
    if(statusCode == 200){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showMain" sender:nil];
        });
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"login failed" message:dict[@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        });
    }
    

}

@end
