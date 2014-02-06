//
//  BTViewController.h
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 6..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTTimer.h"

@interface BTViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *relaxButton;
@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (weak, nonatomic) IBOutlet BTTimer *timer;

- (IBAction)buttonTouched:(id)sender;

@end
