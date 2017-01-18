//
//  ViewController.m
//  DHDynamicPieChart
//
//  Created by David Hu on 1/17/17.
//
//

#import "ViewController.h"
#import "DHDynamicPieChart.h"

@interface ViewController ()
{
    NSMutableArray<DHDynamicPieChart *> *_pieCharts;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pieCharts = [[NSMutableArray alloc] init];
    
    DHDynamicPieChart *pieChart1 = ({
        DHDynamicPieChart *chart = [[DHDynamicPieChart alloc] initWithLevel:20];
        chart.translatesAutoresizingMaskIntoConstraints = NO;
        chart.lineWidth = 30.0;
        chart.startAngle = 3.0 / 4.0 * M_PI;
        chart.endAngle = 9.0 / 4.0 * M_PI;
        chart.levelBackgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
        chart.levelTintColors = @[[UIColor colorWithRed:0.90 green:0.22 blue:0.46 alpha:1.0],
                                  [UIColor colorWithRed:0.73 green:0.22 blue:0.90 alpha:1.0],
                                  [UIColor colorWithRed:0.35 green:0.22 blue:0.90 alpha:1.0],
                                  [UIColor colorWithRed:0.22 green:0.82 blue:0.90 alpha:1.0],
                                  [UIColor colorWithRed:0.22 green:0.90 blue:0.57 alpha:1.0]];
        chart;
    });
    [self.view addSubview:pieChart1];
    [_pieCharts addObject:pieChart1];
    
    DHDynamicPieChart *pieChart2 = ({
        DHDynamicPieChart *chart = [[DHDynamicPieChart alloc] initWithLevel:40];
        chart.translatesAutoresizingMaskIntoConstraints = NO;
        chart.lineWidth = 40.0;
        chart.startAngle = 7 / 4.0 * M_PI;
        chart.endAngle = 13.0 / 4.0 * M_PI;
        chart.levelBackgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
        chart.levelTintColors = @[[UIColor colorWithRed:0.90 green:0.22 blue:0.46 alpha:1.0],
                                  [UIColor colorWithRed:0.73 green:0.22 blue:0.90 alpha:1.0],
                                  [UIColor colorWithRed:0.35 green:0.22 blue:0.90 alpha:1.0],
                                  [UIColor colorWithRed:0.22 green:0.82 blue:0.90 alpha:1.0],
                                  [UIColor colorWithRed:0.22 green:0.90 blue:0.57 alpha:1.0]];
        chart;
    });
    [self.view addSubview:pieChart2];
    [_pieCharts addObject:pieChart2];
    
    DHDynamicPieChart *pieChart3 = ({
        DHDynamicPieChart *chart = [[DHDynamicPieChart alloc] initWithLevel:20];
        chart.translatesAutoresizingMaskIntoConstraints = NO;
        chart.lineWidth = 20.0;
        chart.startAngle =M_PI;
        chart.endAngle = 2 * M_PI;
        chart.levelBackgroundColor = [UIColor colorWithRed:0.89 green:0.84 blue:0.91 alpha:1.0];
        chart.levelTintColors = @[[UIColor colorWithRed:0.68 green:0.44 blue:0.78 alpha:1.0],
                                  [UIColor colorWithRed:0.65 green:0.36 blue:0.77 alpha:1.0],
                                  [UIColor colorWithRed:0.61 green:0.28 blue:0.75 alpha:1.0],
                                  [UIColor colorWithRed:0.58 green:0.21 blue:0.74 alpha:1.0],
                                  [UIColor colorWithRed:0.53 green:0.08 blue:0.72 alpha:1.0],];
        chart;
    });
    [self.view addSubview:pieChart3];
    [_pieCharts addObject:pieChart3];
    
    DHDynamicPieChart *pieChart4 = ({
        DHDynamicPieChart *chart = [[DHDynamicPieChart alloc] initWithLevel:10];
        chart.translatesAutoresizingMaskIntoConstraints = NO;
        chart.lineWidth = 10.0;
        chart.startAngle = 1.0 / 4.0 * M_PI;
        chart.endAngle = 7.0 / 4.0 * M_PI;
        chart.levelBackgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
        chart.levelTintColors = @[[UIColor colorWithRed:0.32 green:0.40 blue:0.84 alpha:1.0],
                                  [UIColor colorWithRed:0.32 green:0.84 blue:0.78 alpha:1.0]];
        chart;
    });
    [self.view addSubview:pieChart4];
    [_pieCharts addObject:pieChart4];
    
    DHDynamicPieChart *pieChart5 = ({
        DHDynamicPieChart *chart = [[DHDynamicPieChart alloc] initWithLevel:10];
        chart.translatesAutoresizingMaskIntoConstraints = NO;
        chart.lineWidth = 30.0;
        chart.startAngle = 0;
        chart.endAngle = 2 * M_PI;
        chart.levelBackgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
        chart.levelTintColors = @[[UIColor colorWithRed:0.32 green:0.39 blue:0.73 alpha:1.0],
                                  [UIColor colorWithRed:0.73 green:0.32 blue:0.64 alpha:1.0],
                                  [UIColor colorWithRed:0.84 green:0.32 blue:0.32 alpha:1.0],
                                  ];
        chart;
    });
    [self.view addSubview:pieChart5];
    [_pieCharts addObject:pieChart5];
    
    NSDictionary *viewDic = NSDictionaryOfVariableBindings(pieChart1, pieChart2, pieChart3, pieChart4, pieChart5);
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[pieChart1(200)]-[pieChart3(100)]"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                      views:viewDic]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[pieChart1]-[pieChart2(pieChart1)]-|"
                                                                                    options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                                    metrics:nil
                                                                                      views:viewDic]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[pieChart3]-[pieChart4(pieChart3)]-[pieChart5(pieChart3)]-|"
                                                                                    options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                                    metrics:nil
                                                                                      views:viewDic]];
}
- (IBAction)resetChart:(id)sender {
    for (DHDynamicPieChart *chart in _pieCharts) {
        [chart reset];
    }
}

- (IBAction)setRandomLevel1:(id)sender {
    [_pieCharts[0] setLevel:arc4random()%20 + 1 animated:YES];
}
- (IBAction)setRandomLevel2:(id)sender {
    [_pieCharts[1] setLevel:arc4random()%40 + 1 animated:YES];
}
- (IBAction)setRandomLevel3:(id)sender {
    [_pieCharts[2] setLevel:arc4random()%20 + 1 animated:YES];
}
- (IBAction)setRandomLevel4:(id)sender {
    [_pieCharts[3] setLevel:arc4random()%10 + 1 animated:YES];
}
- (IBAction)setRandomLevel5:(id)sender {
    [_pieCharts[4] setLevel:arc4random()%10 + 1 animated:YES];
}

@end
