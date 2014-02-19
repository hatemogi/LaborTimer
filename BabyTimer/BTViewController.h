//
//  BTViewController.h
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 6..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *relaxButton;
@property (weak, nonatomic) IBOutlet UIButton *signButton;

- (IBAction)buttonTouched:(id)sender;
- (IBAction)buttonRedraw:(id)sender;

@end
