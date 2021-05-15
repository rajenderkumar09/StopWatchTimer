//
//  StopWatch.m
//  Timer
//
//  Created by Rajender Sharma on 15/05/21.
//

#import "StopWatch.h"

@interface StopWatch () {
	NSDate * startDate;
	NSTimeInterval  secondsAlreadyRun;
}

@property (nonatomic, strong) NSTimer * timer;

@end

@implementation StopWatch


//Method for creating new timer object and start mapping time intervals into "HH:MM:SS" format
-(void)start {

	//Hold current date time for calculating time intervals
	startDate = [NSDate date];

	//We need to call method manually for first time, as timer will call it after 1 second.
	[self timechanged];

	//Create and hold reference of the new timker object.
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timechanged) userInfo:nil repeats:true];
}

-(void)pause {
	secondsAlreadyRun += [[NSDate date] timeIntervalSinceDate:startDate];
	[self stop];
}

//Invalidate and Stop timer
-(void)stop {
	[self.timer invalidate];
	self.timer = nil;
}

//This Method will be called after every 1 second interval and update time of the Text Label.
-(void)timechanged {
	if ( [self.delegate respondsToSelector:@selector(didChangeTime:)] ) {
		NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:startDate];

		[self.delegate didChangeTime:interval+secondsAlreadyRun];
	}
}

@end
