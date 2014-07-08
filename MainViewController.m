//
//  MainViewController.m
//  paperweight
//
//  Created by Shaun Stehly on 7/6/14.
//  Copyright (c) 2014 youtube. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *newsView;
@property (weak, nonatomic) IBOutlet UIView *headlinesView;

- (IBAction)onPanHeadlines:(UIPanGestureRecognizer *)panGestureRecognizer;

//- (void)onPanHeadlines:(UIPanGestureRecognizer *)panGestureRecognizer;


//@property (nonatomic, assign) float startingPoint;
//@property (nonatomic, assign) float headlineStart;

@end

@implementation MainViewController

// Is this the same as adding the @property in the ToC?
CGPoint startingPoint;
CGPoint headlineStart;
CGPoint fingerStart;


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
    
    
    startingPoint = self.headlinesView.center;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanHeadlines:)];
    
    [self.view addGestureRecognizer:panGestureRecognizer];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    self.newsView.contentSize = CGSizeMake(1444, 253);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CGPoint) newYvalue:(CGPoint)locationPoint {
    return locationPoint;
}


//- (void)onPanHeadlines:(UIPanGestureRecognizer *)panGestureRecognizer {
//    CGPoint location = [panGestureRecognizer locationInView:self.view];
//    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
//    CGPoint destination = startingPoint;
//    
//    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        
//        fingerStart = [panGestureRecognizer locationInView:self.view];
//        headlineStart = self.headlinesView.center;
//        
//    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        CGFloat nextY = headlineStart.y + (location.y - fingerStart.y);
//        destination = CGPointMake(startingPoint.x, nextY);
//        self.headlinesView.center = CGPointMake(self.headlinesView.center.x, location.y);
//        
//    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
//        CGFloat delta = location.y - fingerStart.y;
//        
//        if (delta < 0) {
//            destination = startingPoint;
//        } else {
//            destination = CGPointMake(startingPoint.x, 805);
//        }
//        
//        [UIView animateWithDuration:.6 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:1 options:0 animations:^{
//            self.headlinesView.center = destination;
//        } completion:nil];
//    }
//}

- (IBAction)onPanHeadlines:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint location = [panGestureRecognizer locationInView:self.view];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    CGPoint destination = startingPoint;
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        fingerStart = [panGestureRecognizer locationInView:self.view];
        headlineStart = self.headlinesView.center;
        
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat nextY = headlineStart.y + (location.y - fingerStart.y);
//        self.headlinesView.transform = CGAffineTransformMakeScale(1.01, 1.01);
        
        if ((self.headlinesView.center.y - 568) + (location.y - fingerStart.y) <= self.headlinesView.center.y - 568) {
            destination = CGPointMake(startingPoint.x, nextY - nextY / 1.5 + 185);
            NSLog(@"went past top of screen");

        } else {
            destination = CGPointMake(startingPoint.x, nextY);
            NSLog(@"not off top of screen");

        }
        
        [UIView animateWithDuration:.75 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:.5 options:0 animations:^{
            self.headlinesView.center = destination;
        } completion:nil];
        
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat delta = location.y - fingerStart.y;
//        self.headlinesView.transform = CGAffineTransformMakeScale(1, 1);

        
        if (delta < 0) {
            destination = startingPoint;
        } else {
            destination = CGPointMake(startingPoint.x, 805);
        }
        
        [UIView animateWithDuration:.75 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:.5 options:0 animations:^{
            self.headlinesView.center = destination;
        } completion:nil];
    }
}

@end
