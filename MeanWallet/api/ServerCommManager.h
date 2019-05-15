//
//  ServerCommManager.h
//  MeanWallet
//  Singleton Pattern Object
//  see api at https://t1.tempo.fan/api-docs
//  Created by MeanFan Moo on 2019/5/15.
//  Copyright © 2019年 MeanFan Moo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServerCommManager : NSObject<NSURLSessionDataDelegate>
+ (ServerCommManager *)instance;
- (NSString*)loginAs:(NSString*)username password:(NSString*)password;
@end

NS_ASSUME_NONNULL_END
