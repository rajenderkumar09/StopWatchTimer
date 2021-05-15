//
//  ViewController.m
//  Timer
//
//  Created by Rajender Sharma on 15/05/21.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property(nonatomic, strong) StopWatch * stopWatch;

- (IBAction)startTimerAction:(UIButton *)sender;
- (IBAction)stopTimerAction:(UIButton *)sender;

@end

@implementation ViewController 

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.

	[self cleanData];
	[self configureView];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
}

//Getter method for StopWatch object
-(StopWatch*) stopWatch {
	if (_stopWatch == nil) {
		self.stopWatch = [[StopWatch alloc] init];
		self.stopWatch.delegate = self;
	}
	return _stopWatch;
}

//Configure View
-(void)configureView {
	self.timeLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
	self.timeLabel.layer.borderColor = [[UIColor blackColor] CGColor];
	self.timeLabel.layer.borderWidth = 1.0f;

	self.startButton.layer.borderColor = [[UIColor blackColor] CGColor];
	self.startButton.layer.borderWidth = 1.0f;

	self.stopButton.layer.borderColor = [[UIColor blackColor] CGColor];
	self.stopButton.layer.borderWidth = 1.0f;
	self.stopButton.hidden = true;
}

//Start Button Outlet action
- (IBAction)startTimerAction:(UIButton *)sender {

	NSString * title = [sender titleForState:UIControlStateNormal];
	if ([title isEqualToString:@"Start"]) {
		//stop existing timer if there is any.
		[self.stopWatch stop];

		//Start stop watch now
		[self.stopWatch start];

		//Update Start Button Title
		[self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
		self.stopButton.hidden = false;

	} else if ([title isEqualToString:@"Pause"]) {

		[self.stopWatch pause];
		[self.startButton setTitle:@"Resume" forState:UIControlStateNormal];

	} else if ([title isEqualToString:@"Resume"]) {

		[self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
		[self.stopWatch start];
	}
}

//Stop Button Outlet Action
- (IBAction)stopTimerAction:(UIButton *)sender {

	[self.stopWatch stop];
	[self cleanData];

	//Update Button Title and hide stop button
	[self.startButton setTitle:@"Start" forState:UIControlStateNormal];
	self.stopButton.hidden = true;
}

-(void)cleanData {

	//clean stopwatch object
	self.stopWatch = nil;

	//Set Time to 00:00:00
	self.timeLabel.text = @"00:00:00";
}

//Method for calculating coverting time changes into string
- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
	NSInteger ti = (NSInteger)interval;
	NSInteger seconds = ti % 60;
	NSInteger minutes = (ti / 60) % 60;
	NSInteger hours = (ti / 3600);
	NSString *time = nil;
	if (hours > 0) {
		time = [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, minutes, seconds];
	} else {
		time = [NSString stringWithFormat:@"00:%02li:%02li", (long)minutes, seconds];
	}
	return time;
}

//StopWatch Delegate
- (void)didChangeTime:(NSTimeInterval)time {
	self.timeLabel.text = [self stringFromTimeInterval:time];
}



@end
