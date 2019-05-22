//
//  FirstViewController.m
//  MeanWallet
//
//  Created by MeanFan Moo on 2019/5/11.
//  Copyright © 2019年 MeanFan Moo. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *msgText;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,atomic) NSArray* balanceArray;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _msgText.text = @"Loading";
    _msgText.hidden = NO;
    _tableView.hidden = YES;
    [[ServerCommManager instance] getBalanceWithDelegate:self];
    
}

- (void)returnWithStatusCode:(long)statusCode withArray:(NSArray *)array{
    NSLog(@"[getBalance] responseStatusCode:%ld\ndata:\n %@\n--------------",statusCode,array);
    if(statusCode == 200){
        self.balanceArray = array;
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.balanceArray != nil || self.balanceArray.count>0){
                self.msgText.hidden = YES;
                self.tableView.hidden = NO;
                [self.tableView reloadData];
            }else{
                self.msgText.text = @"No Balance";
                self.msgText.hidden = NO;
                self.tableView.hidden = YES;
            }
        });
    }else{
        self.balanceArray = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.msgText.text = @"Get Balance Failed";
            self.msgText.hidden = NO;
            self.tableView.hidden = YES;
            
        });
    }
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.balanceArray == nil){
        return 0;
    }
    return self.balanceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(self.balanceArray == nil){
        return cell;
    }
    NSDictionary* assetDict = self.balanceArray[indexPath.row];
    NSString *asset = assetDict[@"asset"];
    NSString *balance = assetDict[@"balance"];
    cell.textLabel.text = asset;
    cell.detailTextLabel.text = balance;
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)returnWithStatusCode:(long)statusCode withDict:(NSDictionary *)dict {
    return;
}


@end
