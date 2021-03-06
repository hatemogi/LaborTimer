//
//  BTViewController.h
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 6..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

@interface BTViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *logView;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sessionTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *signButton;

- (IBAction)buttonTouched:(id)sender;
- (IBAction)buttonRedraw:(id)sender;

@end
