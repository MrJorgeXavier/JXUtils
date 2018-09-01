//
//  Objc.m
//  CupertinoStandards
//
//  Created by Jorge Luis on 26/08/18.
//

#import "Objc.h"

@implementation Objc
+ (nullable id)catchException:(id(^)(void))tryBlock error:(__autoreleasing NSError **)error {
    @try {
        return tryBlock();
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
        return nil;
    }
}
@end
