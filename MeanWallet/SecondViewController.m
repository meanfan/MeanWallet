//
//  SecondViewController.m
//  MeanWallet
//
//  Created by MeanFan Moo on 2019/5/11.
//  Copyright © 2019年 MeanFan Moo. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *msgText;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,atomic) NSArray* ledgerArray;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _msgText.text = @"Loading";
    _msgText.hidden = NO;
    _tableView.hidden = YES;
    [[ServerCommManager instance] getLedgerWithDelegate:self];
    
}

- (void)returnWithStatusCode:(long)statusCode withArray:(NSArray *)array{
    NSLog(@"[getLedger] responseStatusCode:%ld\ndata:\n %@\n--------------",statusCode,array);
    if(statusCode == 200){
        self.ledgerArray = array;
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.ledgerArray != nil || self.ledgerArray.count>0){
                self.msgText.hidden = YES;
                self.tableView.hidden = NO;
                [self.tableView reloadData];
            }else{
                self.msgText.text = @"No Ledger";
                self.msgText.hidden = NO;
                self.tableView.hidden = YES;
            }
        });
    }else{
        self.ledgerArray = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.msgText.text = @"Get Ledger Failed";
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
    if(self.ledgerArray == nil){
        return 0;
    }
    return self.ledgerArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(self.ledgerArray == nil){
        return cell;
    }
    NSDictionary* assetDict = self.ledgerArray[indexPath.row];
    NSString *asset = assetDict[@"asset"];
    NSDictionary *notes = assetDict[@"notes"][0];
    NSString *action = notes[@"action"];
    NSString *amount = notes[@"amount"];
    cell.textLabel.text = asset;
    if([action compare:@"in"]==0){
        action = @"+";
    }else{
        action = @"-";
    }
    cell.detailTextLabel.text = [action stringByAppendingString:amount];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)returnWithStatusCode:(long)statusCode withDict:(NSDictionary *)dict {
    return;
}



@end
