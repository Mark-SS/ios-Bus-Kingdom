//
//  BKFirstViewController.m
//  BusKingdom
//
//  Created by gongliang on 13-9-3.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKFirstViewController.h"
#import "BKStationViewController.h"
#import "BKLineInfo.h"
#import "BKUntility.h"

@interface BKFirstViewController ()

@property (nonatomic, strong) NSArray *staArray; //站信息

@end

@implementation BKFirstViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"staSegue"]) {
        
        if ([BKUntility isBlankString:self.lineTextField.text]) {
            return;
        }
        
        BKStationViewController *staVC = segue.destinationViewController;
        staVC.hidesBottomBarWhenPushed = YES;
        staVC.title = self.lineTextField.text;
        staVC.staArray = self.staArray;
    }
}

#pragma mark -
#pragma mark textField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
    }
    return YES;
}


@end
