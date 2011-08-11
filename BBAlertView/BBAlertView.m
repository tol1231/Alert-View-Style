#import "BBAlertView.h"

#define RELEASE_SAFELY(__POINTER) { \
 if (__POINTER)                     \
 {                                  \
  [__POINTER release];              \
  __POINTER = nil;                  \
 }                                  \
}

@interface BBAlertView ()
- (void)setupInitialValues;
- (void)cleanupInitialValues;
- (void)drawRoundedRect:(CGRect)rrect
              inContext:(CGContextRef)context
             withRadius:(CGFloat)radius;
@end

@implementation BBAlertView

@synthesize fillColor = _fillColor;
@synthesize strokeColor = _strokeColor;


- (void)dealloc
{
    [self cleanupInitialValues];
    [super dealloc];
}


- (void)cleanupInitialValues
{
    RELEASE_SAFELY(_fillColor);
    RELEASE_SAFELY(_strokeColor);
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (nil != self)
	{
        [self setupInitialValues];
    }
    return self;
}


- (void)setupInitialValues
{
    _fillColor = nil;
    _strokeColor = _fillColor;
}


- (void)layoutSubviews
{
    NSArray *subviews = [self subviews];
    for (UIView *view in subviews)
    {
        if ([view class] == [UIImageView class]
          && view.tag    == 0)
		{
            /*
             * NOTE:
             * This removes the alert view's bg image.
             */
            [view removeFromSuperview];
            break;
        }
	}
}

- (void)drawRect:(CGRect)rect
{	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, rect);
	CGContextSetAllowsAntialiasing(context, true);
	CGContextSetLineWidth(context, 0.0);
	CGContextSetAlpha(context, 0.8); 
	CGContextSetLineWidth(context, 2.0);
	CGContextSetStrokeColorWithColor(context, [self.strokeColor CGColor]);
	CGContextSetFillColorWithColor(context, [self.fillColor CGColor]);
    
// -----------------------------------------------------------------------------
#pragma mark Draw Background
// -----------------------------------------------------------------------------
    
	CGFloat backOffset = 2.0f;
    
	CGRect backRect
    = CGRectMake(rect.origin.x    + backOffset,
                 rect.origin.y    + backOffset,
                 rect.size.width  - backOffset * 2,
                 rect.size.height - backOffset * 2);
    
    [self drawRoundedRect:backRect inContext:context withRadius:8];
    
    CGContextDrawPath(context, kCGPathFillStroke);

// -----------------------------------------------------------------------------
#pragma mark Clip Context
// -----------------------------------------------------------------------------

    CGRect clipRect
    = CGRectMake(backRect.origin.x    + backOffset  - 1,
                 backRect.origin.y    + backOffset  - 1,
                 backRect.size.width  - (backOffset - 1) * 2,
                 backRect.size.height - (backOffset - 1) * 2);
    
    [self drawRoundedRect:clipRect inContext:context withRadius:8];
    
    CGContextClip (context);
    
// -----------------------------------------------------------------------------
#pragma mark Draw Highlight
// -----------------------------------------------------------------------------
    
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t no_locations   = 2;
    CGFloat locations[2]  = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 1.0, 1.0, 0.35, 1.0, 1.0, 1.0, 0.06 };
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(
                        rgbColorspace,
                        components,
                        locations,
                        no_locations
    );
    
    CGRect ovalRect = CGRectMake(-130,
                                 -115,
                                 rect.size.width * 2,
                                 rect.size.width / 2);
    
    CGPoint start = CGPointMake(rect.origin.x, rect.origin.y);
    CGPoint end   = CGPointMake(rect.origin.x, rect.size.height / 5);
    
    CGContextSetAlpha(context, 1.0);
    CGContextAddEllipseInRect(context, ovalRect);
    CGContextClip (context);
    CGContextDrawLinearGradient(context, glossGradient, start, end, 0);
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
}


- (void) drawRoundedRect:(CGRect) rrect inContext:(CGContextRef) context 
              withRadius:(CGFloat) radius
{
	CGContextBeginPath (context);
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), 
    maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect),
    maxy = CGRectGetMaxY(rrect);
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
}


@end