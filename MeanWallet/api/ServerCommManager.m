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
@end

@implementation ServerCommManager

//use "instance" to get instance
+ (ServerCommManager *)instance {
    static ServerCommManager* instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self.class alloc] init];
        instance.serverRootURLStr = @"https://t1.tempo.fan";
    });
    return instance;
}

- (NSMutableURLRequest*)wireRequestWithRelativeURL:(NSString*)urlStr httpMethod:(NSString*)method jsonBody:(NSString*)json {
    NSURL *url = [NSURL URLWithString:[_serverRootURLStr stringByAppendingString:urlStr]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    return request;
}

- (NSString*)loginAs:(NSString*)username password:(NSString*)password {
    //init request
    NSString * relativeURLStr = @"/user/login";
    NSString * jsonBody = [NSString stringWithFormat:@"userName=%@&pwd=%@",username,password];
    NSMutableURLRequest* request = [self wireRequestWithRelativeURL:relativeURLStr httpMethod:@"POST" jsonBody:jsonBody];
    
    //init session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                 //resulve data
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                 NSLog(@"%@",dict);
             }];
    //run session task
    [dataTask resume];
    return nil;
}
@end
