//
//  EPSCommandCell.m
//  UITableViewCell+RACCommand
//
//  Created by Peter Stuart on 8/14/14.
//  Copyright (c) 2014 Electric Peel, LLC. All rights reserved.
//

#import "EPSCommandCell.h"

@implementation EPSCommandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;
    
    [self setupBindings];
    
    return self;
}

- (void)awakeFromNib {
    [self setupBindings];
}

- (void)setupBindings {
    RAC(self, canExecuteCommand) = [[RACObserve(self, command)
        map:^RACSignal *(RACCommand *command) {
            if (command) {
                return command.enabled;
            }
            else {
                return [RACSignal return:@NO];
            }
        }]
        switchToLatest];
    
    RAC(self.textLabel, textColor) = [RACObserve(self, canExecuteCommand) map:^UIColor *(NSNumber *enabled) {
        if (enabled.boolValue) return self.tintColor;
        else return [UIColor grayColor];
    }];
}

@end
