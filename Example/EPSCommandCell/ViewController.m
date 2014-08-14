//
//  ViewController.m
//  UITableViewCell+RACCommand
//
//  Created by Peter Stuart on 8/14/14.
//  Copyright (c) 2014 Electric Peel, LLC. All rights reserved.
//

#import "ViewController.h"

#import <EPSCommandCell/EPSCommandCell.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic) RACCommand *command;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.segmentedControl.selectedSegmentIndex = 0;
    
    RACSignal *enabled = [[[self.segmentedControl rac_signalForControlEvents:UIControlEventValueChanged]
        map:^NSNumber *(UISegmentedControl *segmentedControl) {
            return @(segmentedControl.selectedSegmentIndex == 0);
        }]
        startWith:@YES];
    
    self.command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
        return [RACSignal empty];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EPSCommandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.command = self.command;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    EPSCommandCell *cell = (EPSCommandCell *)[tableView cellForRowAtIndexPath:indexPath];
    return cell.canExecuteCommand;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EPSCommandCell *cell = (EPSCommandCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.command execute:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
