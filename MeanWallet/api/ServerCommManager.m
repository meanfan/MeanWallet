//
//  ServerCommManager.m
//  MeanWallet
//  Singleton Pattern Object, DO NOT init and alloc
//  see api at https://t1.tempo.fan/api-docs
//  Created by MeanFan Moo on 2019/5/15.
//  Copyright © 2019年 MeanFan Moo. All rights reserved.
//

#import "ServerCommManager.h"

@interface ServerCommManager()
@property NSString* serverRootURLStr;
@property NSString* userAddress;
@property NSString* testUserAddress;
@end

@implementation ServerCommManager

//use "instance" to get instance
+ (ServerCommManager *)instance {
    static ServerCommManager* instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self.class alloc] init];
        instance.serverRootURLStr = @"https://t1.tempo.fan";
        instance.testUserAddress = @"493c6b4ca883ed33b693e6811d66b3feecdb4bdb";
    });
    return instance;
}

- (NSMutableURLRequest*)wireRequestWithRelativeURL:(NSString*)urlStr httpMethod:(NSString*)method jsonBody:(NSString*)json {
    NSURL *url = [NSURL URLWithString:[_serverRootURLStr stringByAppendingString:urlStr]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    if(json!=nil || json.length > 0){
        request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    }
    return request;
}

- (void)loginAs:(NSString*)username password:(NSString*)password delegate:(id<ServerCommManagerDelegate>)delegate{
    //init request
    NSString * relativeURLStr = @"/user/login";
    NSString * jsonBody = [NSString stringWithFormat:@"userName=%@&pwd=%@",username,password];
    NSMutableURLRequest* request = [self wireRequestWithRelativeURL:relativeURLStr httpMethod:@"POST" jsonBody:jsonBody];
    
    //init session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         //resulve data using delegate
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if(httpResponse.statusCode == 200){
            self.userAddress = dict[@"address"];
        }
        [delegate returnWithStatusCode:httpResponse.statusCode withDict:dict];
    }];
    //run session task
    [dataTask resume];
}

-(void)getBalanceWithDelegate:(id<ServerCommManagerDelegate>)delegate{
    // ! use testUserBalance for test
    // NSString * relativeURLStr = [@"/account/balance/" stringByAppendingString:self.userAddress];
    NSString * relativeURLStr = [@"/account/balance/" stringByAppendingString:self.testUserAddress];
    NSMutableURLRequest* request = [self wireRequestWithRelativeURL:relativeURLStr httpMethod:@"GET" jsonBody:nil];
    
    //init session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //resulve data using delegate
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [delegate returnWithStatusCode:httpResponse.statusCode withArray:array];
        
    }];
    //run session task
    [dataTask resume];
}
    

@end
