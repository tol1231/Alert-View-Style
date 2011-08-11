#import <UIKit/UIKit.h>

@interface BBAlertView : UIAlertView
{
    UIColor *_fillColor;
    UIColor *_strokeColor;
}

@property (retain) UIColor *fillColor;
@property (retain) UIColor *strokeColor;

@end