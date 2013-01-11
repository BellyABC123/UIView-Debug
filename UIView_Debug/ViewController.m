//
//  ViewController.m
//  Constraints_Hybrid
//
//  Created by Eric Rolf on 1/3/13.
//  Copyright (c) 2013 Cardinal Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *orangeView, *greyView, *goldView;
@property (nonatomic, strong) NSArray *myLConstraints, *myPConstraints;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupConstraints];
    [self applyConstraintsForInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

- (void)setupConstraints
{
    _myPConstraints = [self.view constraints];
    
    if (_myLConstraints) return;
    NSMutableArray *constraints = [NSMutableArray array];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_orangeView, _greyView, _goldView);
    NSDictionary *metrics = NSDictionaryOfVariableBindings(@20);
    
    NSArray *hConstriants = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_orangeView(==_greyView)]-20-[_greyView(==_orangeView)]-|"
                                                                    options:NSLayoutFormatDirectionLeftToRight
                                                                    metrics:metrics
                                                                      views:views];
    
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_orangeView(300)]-20-[_goldView]-|"
                                                                    options:NSLayoutFormatDirectionLeadingToTrailing
                                                                    metrics:metrics
                                                                      views:views];
    
    NSArray *v1Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_greyView]-20-[_goldView]-|"
                                                                    options:NSLayoutFormatDirectionLeadingToTrailing
                                                                    metrics:metrics
                                                                      views:views];
    NSArray *h1Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_goldView]-|"
                                                                    options:NSLayoutFormatDirectionLeadingToTrailing
                                                                    metrics:metrics
                                                                      views:views];
    
    
    [self mergeArraysInto:&constraints, hConstriants, h1Constraints, vConstraints, v1Constraints, nil];
    _myLConstraints = (NSArray*)constraints;
    return;

}

- (void)applyConstraintsForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        [self.view removeConstraints:_myPConstraints];
        [self.view addConstraints:_myLConstraints];
    }
    else
    {
        [self.view removeConstraints:_myLConstraints];
        [self.view addConstraints:_myPConstraints];
    }
    ALCLog(self.view);
    ALAMBLog(self.view);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self applyConstraintsForInterfaceOrientation:toInterfaceOrientation];
}

- (void)mergeArraysInto:(NSMutableArray**)intoArray, ...
{
    NSArray *eachObject;
    va_list argumentList;
    if (intoArray) // The first argument isn't part of the varargs list,
    {
        va_start(argumentList, intoArray); // Start scanning for arguments after firstObject.
        while ((eachObject = va_arg(argumentList, NSArray*))) // As many times as we can get an argument of type "id"
        {
            [*intoArray addObjectsFromArray:eachObject]; // that isn't nil, add it to self's contents.
        }
        va_end(argumentList);
    }
}

@end
