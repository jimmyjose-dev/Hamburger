//
//  ViewController.m
//  Hamburger
//
//  Created by Jimmy Jose on 11/08/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "Hamburger.h"

@interface ViewController ()
{Hamburger *buttonHamburger;}
@end

@implementation ViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:151.0/255.0 blue:68.0/255.0 alpha:1.0];
    
    CGRect frame = CGRectMake(133, 133, 54, 54);
    
    buttonHamburger = [[Hamburger alloc] initWithFrame:frame];
    
    [buttonHamburger addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonHamburger];
}

-(void)toggle:(Hamburger *)hamburger{

    hamburger.showsMenu = !hamburger.showsMenu;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
