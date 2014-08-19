//
//  EPSCommandCell.m
//  UITableViewCell+RACCommand
//
//  Created by Peter Stuart on 8/14/14.
//  Copyright (c) 2014 Electric Peel, LLC. All rights reserved.
//

#import "EPSCommandCell.h"

#import <ReactiveCocoa/RACEXTScope.h>

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
    
    @weakify(self);
    
    RACSignal *tintSignal = [[[self rac_signalForSelector:@selector(tintColorDidChange)] startWith:nil]
        map:^UIColor *(id value) {
            @strongify(self);

            return self.tintColor;
        }];
    
    RAC(self.textLabel, textColor) = [RACSignal
        combineLatest:@[ RACObserve(self, canExecuteCommand), tintSignal ]
        reduce:^UIColor *(NSNumber *canExecute, UIColor *tintColor){
            if (canExecute.boolValue) return tintColor;
            else return [UIColor grayColor];
        }];

}

@end
