//
//  BTViewController.m
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 6..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import "BTViewController.h"
#import "BTCircleButton.h"
#import "BTLogRecord.h"
#import "BTLogSession.h"


@interface BTViewController ()
- (void)updateTime:(NSTimer *)timer;
- (NSString *)intervalString:(NSTimeInterval)dt;
- (IBAction)selectSession:(id)sender;
@end

@implementation BTViewController {
    NSTimer *periodicTimer;
    NSDateFormatter *dateFormatter;
    BTLogSession *_session;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    _session = [BTLogSession new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    periodicTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
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
    int min = sec / 60;
    sec -= min * 60;
    return [NSString stringWithFormat:@"%02d:%02d", min, (int)sec];
}

- (void)updateTime:(NSTimer *)timer
{
    self.currentTimeLabel.text = [self intervalString:[[_session lastStampAt] timeIntervalSinceNow]];
    self.sessionTimeLabel.text = [self intervalString:[[_session firstStampAt] timeIntervalSinceNow]];
    double avr = [_session averageInterval];
    if (avr > 0.0) {
        self.averageTimeLabel.text = [self intervalString:avr];
    } else {
        self.averageTimeLabel.text = NSLocalizedString(@"BTAvrPeriod", @"진통주기");
    }
}

- (IBAction)buttonRedraw:(id)sender
{
    [sender setNeedsDisplay];
}
    
- (IBAction)buttonTouched:(id)sender
{
    if (sender == self.signButton) {
        _session = [_session stamp:[NSDate date]];

    } else {
        // reset button
        _session = [_session reset];
    }
//    [self buttonRedraw:sender];
    [self.logView reloadData];
}

- (IBAction)selectSession:(id)sender
{
    NSLog(@"세션 선택됨");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _session.stampCount + _session.sessionCount - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath item] < _session.stampCount) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogCell" forIndexPath:indexPath];
        
        BTLogRecord *record = (BTLogRecord *)_session.records[[indexPath item]];
        cell.textLabel.text = [dateFormatter stringFromDate:record.at];
        if (record.dt < 0.001) {
            cell.detailTextLabel.text = NSLocalizedString(@"BTStart", @"시작");
        } else {
            cell.detailTextLabel.text = [self intervalString:record.dt];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SessionCell" forIndexPath:indexPath];
        cell.textLabel.text = @"세션은 여기에";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    if (_session.stampCount <= [indexPath item]) {
        NSLog(@"히스토리보기");
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_session cancelStamp:_session.stampCount - 1 - [indexPath item]];
        [self.logView reloadData];
    }
}


@end
