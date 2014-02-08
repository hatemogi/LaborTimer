//
//  BTViewController.m
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 6..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import "BTViewController.h"
#import "BTLogViewCell.h"
#import "BTCircleButton.h"
#import "BTLogRecord.h"

@interface BTViewController ()
- (void)updateTime:(NSTimer *)timer;
- (NSString *)intervalString:(NSTimeInterval)dt;
@end

@implementation BTViewController {
    NSTimer *periodicTimer;
    NSMutableArray *items;
    NSDateFormatter *dateFormatter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    items = [[NSMutableArray alloc] init];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd HH:mm:ss"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    periodicTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    NSLog(@"timer registered");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [periodicTimer invalidate];
    [super viewWillDisappear:animated];
}

- (NSString *)intervalString:(NSTimeInterval)dt
{
    NSTimeInterval sec = abs(dt);
    NSUInteger min = sec / 60;
    sec -= min * 60;
    return [NSString stringWithFormat:@"%02d:%02d", min, (int)sec];
}

- (void)updateTime:(NSTimer *)timer
{
    NSTimeInterval dt = [[self.timer lastTimestamp] timeIntervalSinceNow];
    self.timeLabel.text = [self intervalString:dt];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"item count: %d", [items count]);
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LogCell";
    BTLogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    BTLogRecord *record = (BTLogRecord *)[items objectAtIndex:[indexPath item]];
    cell.textLabel.text = [dateFormatter stringFromDate:record.at];
    cell.detailTextLabel.text = [self intervalString:record.dt];
    return cell;
}


- (IBAction)buttonTouched:(id)sender
{
    NSLog(@"%@ touched", sender);
    UIButton *btn = (UIButton *)sender;
    UIButton *other = self.signButton;
    btn.selected = !btn.selected;
    if (sender == self.signButton) {
        NSLog(@"진통시작");
        other = self.relaxButton;
        NSTimeInterval dt = -[self.timer.lastTimestamp timeIntervalSinceNow];
        NSLog(@"dt = %f", dt);
        BTLogRecord *r = [[BTLogRecord alloc] initAt:[NSDate date] dt:dt];
        [items insertObject:r atIndex:0];
        [self.timer signal];
        [self.logView reloadData];
    }
    other.selected = false;
    
}

@end
