//
//  Objc.h
//  CupertinoStandards
//
//  Created by Jorge Luis on 26/08/18.
//

#import <Foundation/Foundation.h>
//Idea from: https://stackoverflow.com/questions/32758811/catching-nsexception-in-swift

@interface Objc : NSObject
/**
 This method executes an block inside of objective-c runtime error handling. Which means that even if you do something inside the block that throw an NSException (such as NSInvalidArgumentException), the execution of the program will not stop, and the exception will be thrown for you to handle it (instead of you ending up seeing some random assembly in your face out of nowhere).

 @param tryBlock The block that will be executed.
 @param error If some error occurs, this pointer will get the error.
 @return Returns the object returned in the tryBlock parameter, or nil if some error occur. This return can be useful to keep the execution of your program synchronous.
 */
+ (nullable id)catchException:(id(^)(void))tryBlock error:(__autoreleasing NSError **)error;
@end
