//
//  ViewController.m
//  Project4
//
//  Created by Jinwoo Kim on 2/25/21.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray<NSString *> *args = [NSProcessInfo processInfo].arguments;
    [args enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"enable-testing"]) {
            self.view.backgroundColor = UIColor.systemTealColor;
//            [UIView setAnimationsEnabled:NO];
            *stop = YES;
        }
    }];
}

- (IBAction)textChanged:(UITextField *)sender {
    self.label.text = self.textField.text;
}

- (IBAction)sliderChanged:(UISlider *)sender {
    self.progressView.progress = 1 - self.slider.value;
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    self.title = [self.segmentedControl titleForSegmentAtIndex:self.segmentedControl.selectedSegmentIndex];
}

- (IBAction)colorSelected:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:sender.titleLabel.text
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
