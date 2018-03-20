@interface _UIStatusBar : UIView
@property (nonatomic, assign, readwrite) NSInteger style;
@end

@interface _UIBatteryView : UIView
@property NSInteger chargingState;
@property CGFloat chargePercent;
@property (nonatomic, retain) UILabel *nz9_percentLabel;
- (void)nz9_initPercentLabel;
- (UIColor *)nz9_colorFormula;
@end

NSInteger currentStyle = 0; // Color style of status bar

%hook _UIStatusBar

- (void)setStyle:(NSInteger)arg1 {
	%orig;
	currentStyle = arg1;
}

%end

%hook _UIBatteryView
%property (nonatomic, retain) UILabel *nz9_percentLabel;

%new
- (void)nz9_initPercentLabel {
	self.nz9_percentLabel = [[UILabel alloc]initWithFrame:CGRectMake(1.5, -4, 18.75, 13)];// CGRectMake(0,0,self.frame.size.width -4, self.frame.size.height - 2)]; // CGRectMake(0, 0, 23, 10)];
	self.nz9_percentLabel.text = [NSString stringWithFormat:@"%i%%", (int)floor((self.chargePercent * 100))];
	self.nz9_percentLabel.adjustsFontSizeToFitWidth = YES;
	self.nz9_percentLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)arg1 {
	self = %orig;
	[self nz9_initPercentLabel];
	[self addSubview: self.nz9_percentLabel];
	return self;
}

- (void)setChargePercent:(CGFloat)percent {
	%orig;
	self.nz9_percentLabel.text = [NSString stringWithFormat:@"%i%%", (int)floor((self.chargePercent * 100))];
	if(percent == 1.0) {
		self.nz9_percentLabel.frame = CGRectMake(1.5, -4.5, 18.75, 13);
	}
	else {
		self.nz9_percentLabel.frame = CGRectMake(1.5, -4, 18.75, 13);
	}
}

%new
- (UIColor *)nz9_colorFormula {
	if(currentStyle == UIBarStyleBlack) {
		self.nz9_percentLabel.textColor = UIColor.whiteColor;
		return UIColor.whiteColor;
	}
	else {
		self.nz9_percentLabel.textColor = UIColor.blackColor;
		return UIColor.blackColor;
	}
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

- (void)setShowsInlineChargingIndicator:(BOOL)arg1 {
	%orig(NO);
}

%end
