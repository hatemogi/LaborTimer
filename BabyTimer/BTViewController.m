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
#import "BTLogSession.h"


@interface BTViewController ()
- (void)updateTime:(NSTimer *)timer;
- (NSString *)intervalString:(NSTimeInterval)dt;
- (IBAction)selectSession:(id)sender;
@end

@implementation BTViewController {
    NSTimer *periodicTimer;
    NSMutableArray *items;
    NSDateFormatter *dateFormatter;
    
    BTLogSession *session;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    items = [[NSMutableArray alloc] init];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    session = [BTLogSession new];
    session = [[session prependSession] prependSession];
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
    int min = sec / 60;
    sec -= min * 60;
    return [NSString stringWithFormat:@"%02d:%02d", min, (int)sec];
}

- (void)updateTime:(NSTimer *)timer
{
    NSTimeInterval dt = [session.lastStampAt timeIntervalSinceNow];
    self.timeLabel.text = [self intervalString:dt];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return session.stampCount + session.sessionCount - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath item] < session.stampCount) {
        BTLogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogCell" forIndexPath:indexPath];
        
        BTLogRecord *record = (BTLogRecord *)session.records[[indexPath item]];
        cell.textLabel.text = [dateFormatter stringFromDate:record.at];
        if (record.dt < 0.001) {
            cell.detailTextLabel.text = @"시작";
        } else {
            cell.detailTextLabel.text = [self intervalString:record.dt];
        }
        return cell;
    } else {
        BTLogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SessionCell" forIndexPath:indexPath];
        cell.textLabel.text = @"세션은 여기에";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    NSLog(@"빠라바라밤!");
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (IBAction)buttonRedraw:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [btn setNeedsDisplay];
}
    
- (IBAction)buttonTouched:(id)sender
{
    NSLog(@"%@ touched, state = %d", sender, ((UIButton *)sender).highlighted);
    if (sender == self.signButton) {
        [self.signButton setNeedsDisplay];
        NSLog(@"진통시작");
        NSTimeInterval dt = -[self.timer.lastTimestamp timeIntervalSinceNow];
        NSLog(@"dt = %f", dt);
        session = [session stamp:[NSDate date]];
        [self.timer signal];
        [self.logView reloadData];
    }
}

- (IBAction)selectSession:(id)sender
{
    NSLog(@"세션 선택됨");
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return YES;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    NSLog(@"action!");
    
}

@end
