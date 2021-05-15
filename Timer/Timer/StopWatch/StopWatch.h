//
//  StopWatch.h
//  Timer
//
//  Created by Rajender Sharma on 15/05/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TimeUpdated <NSObject>

-(void) didChangeTime:(NSTimeInterval)time;

@end

@interface StopWatch : NSObject

@property (weak, nonatomic) NSObject<TimeUpdated>* delegate;

-(void)start;
-(void)pause;
-(void)stop;

@end

NS_ASSUME_NONNULL_END
