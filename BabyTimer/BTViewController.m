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

@interface BTViewController ()
@end

@implementation BTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LogCell";
    BTLogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = @"텍스트";
    
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
    }
    other.selected = false;
    
}

@end
