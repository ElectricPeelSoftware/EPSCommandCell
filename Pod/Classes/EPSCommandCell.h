//
//  EPSCommandCell.h
//  UITableViewCell+RACCommand
//
//  Created by Peter Stuart on 8/14/14.
//  Copyright (c) 2014 Electric Peel, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface EPSCommandCell : UITableViewCell

@property (nonatomic) RACCommand *command;
@property (readonly, nonatomic) BOOL canExecuteCommand;

@end
