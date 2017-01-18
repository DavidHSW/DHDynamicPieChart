# DHDynamicPieChart

##Feature
Animate with any level, angle, tint colors as well as animation duration.

##Demo
![img](https://github.com/DavidHSW/DHDynamicPieChart/blob/master/DemoGif.gif)

##Installation
Simply drag the header file `DHDynamicPieChart.h`into your project:

    #import "DHDynamicPieChart.h"

##How to use
Configure like this:

    DHDynamicPieChart *pieChart = ({
        DHDynamicPieChart *chart = [[DHDynamicPieChart alloc] initWithLevel:20];
        chart.lineWidth = 30.0;
        chart.startAngle = 3.0 / 4.0 * M_PI;
        chart.endAngle = 9.0 / 4.0 * M_PI;
        chart.animateDurationBySeconds = 0.5;
        chart.levelBackgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
        chart.levelTintColors = @[[UIColor colorWithRed:0.90 green:0.22 blue:0.46 alpha:1.0],
                                  [UIColor colorWithRed:0.73 green:0.22 blue:0.90 alpha:1.0],
                                  [UIColor colorWithRed:0.35 green:0.22 blue:0.90 alpha:1.0],
                                  [UIColor colorWithRed:0.22 green:0.82 blue:0.90 alpha:1.0],
                                  [UIColor colorWithRed:0.22 green:0.90 blue:0.57 alpha:1.0]];
        chart;
    });
    [self.view addSubview:pieChart];

##Lisence
Under MIT.
