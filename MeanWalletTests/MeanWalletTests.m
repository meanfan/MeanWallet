//
//  MeanWalletTests.m
//  MeanWalletTests
//
//  Created by MeanFan Moo on 2019/5/11.
//  Copyright © 2019年 MeanFan Moo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ServerCommManager.h"
@interface MeanWalletTests : XCTestCase

@end

@implementation MeanWalletTests

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void)testLogin {
    ServerCommManager* serverCommManager=[ServerCommManager instance];
    [serverCommManager loginAs:@"meantest" password:@"test123456"];
}


@end
