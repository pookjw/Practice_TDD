//
//  Converter.m
//  Project2
//
//  Created by Jinwoo Kim on 2/24/21.
//

#import "Converter.h"

@implementation Converter
- (double)convertToCelsiusFromFahrenheit:(double)fahrenheit {
//    return (fahrenheit - 32) * 5 / 9;
    NSMeasurement *fahrenheitMeasurement = [[NSMeasurement alloc] initWithDoubleValue:fahrenheit unit:[NSUnitTemperature fahrenheit]];
    NSMeasurement *celsiusMeasurement = [fahrenheitMeasurement measurementByConvertingToUnit:[NSUnitTemperature celsius]];
    return celsiusMeasurement.doubleValue;
}
@end
