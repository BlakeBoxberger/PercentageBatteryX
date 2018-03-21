@interface _UIBatteryView : UIView
@property NSInteger chargingState;
@property CGFloat chargePercent;
@property BOOL saverModeActive;
@property (nonatomic, copy, readwrite) UIColor *fillColor;
@property (nonatomic, retain) UILabel *nz9_percentLabel;
- (void)nz9_initPercentLabel;
- (UIColor *)nz9_colorFormula;
@end

%hook _UIBatteryView
%property (nonatomic, retain) UILabel *nz9_percentLabel;

%new
- (void)nz9_initPercentLabel {
    self.nz9_percentLabel = [[UILabel alloc]initWithFrame:CGRectMake(1.5, -1.25, 18.75, 13)]; // CGRectMake(0,0,self.frame.size.width -4, self.frame.size.height - 2)]; // CGRectMake(0, 0, 23, 10)];
    self.nz9_percentLabel.text = [NSString stringWithFormat:@"%.0f%%", floor(self.chargePercent * 100)];
    self.nz9_percentLabel.font = [UIFont boldSystemFontOfSize: 9];
    self.nz9_percentLabel.adjustsFontSizeToFitWidth = YES;
    self.nz9_percentLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = %orig;
    [self nz9_initPercentLabel];
    [self addSubview:self.nz9_percentLabel];
    return self;
}

- (void)setChargePercent:(CGFloat)percent {
    %orig;
    
    self.nz9_percentLabel.text = [NSString stringWithFormat:@"%.0f%%", floor(percent * 100)];
    
    CGFloat yValue = (percent == 1.0) ? -2 : -1.25;
    self.nz9_percentLabel.frame = CGRectMake(1.5, yValue, 18.75, 13);
}

%new
- (UIColor *)nz9_colorFormula {
    self.nz9_percentLabel.textColor = self.fillColor;
    return self.fillColor;
}

- (UIColor *)_batteryColor {
    return UIColor.clearColor;
}

- (UIColor *)bodyColor {
    return [self nz9_colorFormula];
}

- (UIColor *)pinColor {
    return [self nz9_colorFormula];
}

- (void)setShowsInlineChargingIndicator:(BOOL)showing {
    %orig(NO);
}

%end
