//
//  ViewController.m
//  SegmentedControl + PageViewControl
//
//  Created by Jian Yao Ang on 12/24/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "OneViewController.h"

@interface ViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *container;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (assign, nonatomic) NSUInteger currentIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    [self.pageViewController setDataSource:self];
    [self.pageViewController setDelegate:self];
    
    self.currentIndex = 0;
    
    [self.pageViewController setViewControllers:@[[self viewAtIndex:self.currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
     
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    
    [self.segmentedControl addTarget:self action:@selector(indexChangedForSegmentedControl) forControlEvents:UIControlEventValueChanged];
    
}

-(void)viewDidLayoutSubviews
{
    self.pageViewController.view.frame = self.container.frame;
}

#pragma mark - index trackers
-(UIViewController*)viewAtIndex:(NSUInteger)index
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc;
    
    if (index == 0)
    {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"one"];
    }
    else if (index == 1)
    {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"two"];
    }
    else if (index == 2)
    {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"three"];
    }
    else
    {
        vc = nil;
    }
    return vc;
}

-(NSUInteger)indexAtView:(UIViewController*)view
{
    NSUInteger index;
    
    if ([view isKindOfClass:[OneViewController class]])
    {
        index = 0;
    }
    else if ([view isKindOfClass:[TwoViewController class]])
    {
        index = 1;
    }
    else if ([view isKindOfClass:[ThreeViewController class]])
    {
        index = 2;
    }
    return index;
}

-(void)indexChangedForSegmentedControl
{
    NSInteger direction;
    
    if (self.segmentedControl.selectedSegmentIndex > self.currentIndex)
    {
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    else if (self.segmentedControl.selectedSegmentIndex < self.currentIndex)
    {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    else
    {
        return;
    }
    self.currentIndex = self.segmentedControl.selectedSegmentIndex;
    
    [self.pageViewController setViewControllers:@[[self viewAtIndex:self.currentIndex]] direction:direction animated:YES completion:nil];
    
}

#pragma mark - uipageViewcontroller data source methods
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexAtView:viewController];
    
    if (index == 0)
    {
        return nil;
    }
    index--;
    return [self viewAtIndex:index];
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexAtView:viewController];
    index++;
    
    //number of "child" View Controllers. In this case, One,Two,Threee = 3
    if (index == 3)
    {
        return nil;
    }
    return [self viewAtIndex:index];
}

#pragma mark - uipageviewcontroller delegate method
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *currentView = [[_pageViewController viewControllers] objectAtIndex:0];
    self.currentIndex = [self indexAtView:currentView];
    self.segmentedControl.selectedSegmentIndex = self.currentIndex;
}



@end
