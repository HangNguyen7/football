//
//  FXSignUpPhoneViewController.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/21/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#define kCELL_NATION @"FXNationTableViewCell"
#define kSIZE_CELL_NATION 46
#define kSIZE_SEARCH_BAR 40

#import "FXSignUpPhoneViewController.h"
#import "FXSignUpVerifyCodeViewController.h"
#import "FXNationTableViewCell.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface FXSignUpPhoneViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnNextStep;
@property (weak, nonatomic) IBOutlet UIView *viewContainCountrySelected;
@property (weak, nonatomic) IBOutlet UIImageView *imgFlag;
@property (weak, nonatomic) IBOutlet UILabel *lbCountrySelected;
@property (weak, nonatomic) IBOutlet UILabel *lbCountryPhoneCode;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *viewContainListNation;

@property (nonatomic, strong) NSArray *arrCountry;
@property (nonatomic, strong) NSMutableArray *arrFilteredCountry;

@end

@implementation FXSignUpPhoneViewController {
    BOOL isSearching;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlurEffectForScreen];
    [self addGestureRecognizerForSubviews];
    [self setupTextField];
    
    _arrCountry = [self getListCountry];
    _arrFilteredCountry = [[NSMutableArray alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    [self initializeViewContainListNation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_textFieldPhoneNumber becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup layout for Subviews
- (void)setupLayoutForSubviews {
    
}

- (void)setBlurEffectForScreen {
    [self addImageViewAsBackground:kImage_Background];
    [self makeBlurEffectView];
    _btnNextStep.userInteractionEnabled = 0;
    [_btnNextStep gradientEffect];
}

#pragma mark - Setup TextField
- (void)setupTextField {
    _textFieldPhoneNumber.keyboardType = UIKeyboardTypePhonePad;
    _textFieldPhoneNumber.delegate = self;
    [_textFieldPhoneNumber addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Add Gesture Recognizer for Subviews
- (void)addGestureRecognizerForSubviews {
    [self.btnNextStep addTarget:self action:@selector(createPulseAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBack addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self addGestureRecognizerWithSelector:@selector(showListNation) withTapsRequired:1 forView:_viewContainCountrySelected];
}

- (NSArray*)getListCountry {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    
    _lbCountrySelected.text = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
    _lbCountryPhoneCode.text = [self getCurrentCountryCallingCodeWithCode:countryCode];
    
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    NSMutableArray *sortedCountryArray = [[NSMutableArray alloc] init];
    for (NSString *countryCode in countryArray) {
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        NSString *callingCode = [[self getCountryCodeDictionary] objectForKey:countryCode];

        CountryBall *countryBall = [[CountryBall alloc] initWithCode:countryCode withName:displayNameString andCallingCode:callingCode];
        
        [sortedCountryArray addObject:countryBall];
    }
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [sortedCountryArray sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}


- (void)initializeViewContainListNation {
    _viewContainListNation = [[UIView alloc] initWithFrame:CGRectMake(_viewContainCountrySelected.frame.origin.x, _viewContainCountrySelected.frame.origin.y + _viewContainCountrySelected.frame.size.height + 10, _viewContainCountrySelected.frame.size.width, kSIZE_SEARCH_BAR + 30 +  kSIZE_CELL_NATION*4)];
    _viewContainListNation.backgroundColor = [UIColor whiteColor];
    _viewContainListNation.layer.cornerRadius = 5;
    _viewContainListNation.clipsToBounds = YES;
    [self.contentView addSubview:_viewContainListNation];
        _viewContainListNation.hidden = 1;
    
    [_viewContainListNation addSubview:[self setupSearchBar]];
    [_viewContainListNation addSubview:[self setupTableViewAutoComplete]];
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Rajdhani-Regular" size:18]}];

}

- (void)showListNation {
    _viewContainListNation.frame = CGRectMake(_viewContainCountrySelected.frame.origin.x, _viewContainCountrySelected.frame.origin.y + _viewContainCountrySelected.frame.size.height + 10, _viewContainCountrySelected.frame.size.width, 0);

    [UIView animateWithDuration:0.25 animations:^{
        _viewContainListNation.hidden = !(_viewContainListNation.isHidden);
        
        _viewContainListNation.frame = CGRectMake(_viewContainCountrySelected.frame.origin.x, _viewContainCountrySelected.frame.origin.y + _viewContainCountrySelected.frame.size.height + 10, _viewContainCountrySelected.frame.size.width, kSIZE_SEARCH_BAR + 30 +  kSIZE_CELL_NATION*4);
    } completion:^(BOOL finished) {
    }];
    
    [self.view endEditing:!(_viewContainListNation.isHidden)];

}

- (UISearchBar*)setupSearchBar {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 10, _viewContainListNation.bounds.size.width - 20, kSIZE_SEARCH_BAR)];
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.returnKeyType = UIReturnKeyDone;
    _searchBar.delegate = self;
    _searchBar.enablesReturnKeyAutomatically = NO;
    
    _searchBar.tintColor = [UIColor redColor];
    [_searchBar setBarTintColor:[UIColor whiteColor]];
    [_searchBar setBackgroundImage:[UIImage new]];
    [_searchBar setPositionAdjustment:UIOffsetMake(-5, 0) forSearchBarIcon:UISearchBarIconSearch];
    [_searchBar setPositionAdjustment:UIOffsetMake(5, 0) forSearchBarIcon:UISearchBarIconClear];
    
    _searchBar.layer.borderWidth = 1;
    _searchBar.layer.borderColor = [UIColor colorWithRed:221.f/255.f green:223.f/255.f blue:233.f/255.f alpha:1].CGColor;
    _searchBar.layer.cornerRadius = 5;
    return _searchBar;
}

- (UITableView*)setupTableViewAutoComplete {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 60, _viewContainListNation.bounds.size.width - 20, _viewContainListNation.bounds.size.height - 20 - 10 - 40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:kCELL_NATION bundle:nil] forCellReuseIdentifier:kCELL_NATION];
    
    return _tableView;
}

#pragma mark - Helper Animation
- (void)createPulseAnimation {
    PulseAnimation *pulse = [PulseAnimation new];
    pulse.colorPulse = [UIColor whiteColor]; //Set fillColor. Default: whiteColor
    
    pulse.position = _btnNextStep.center;

    [self.contentView.layer addSublayer:pulse];//BUG WHEN KEYBOARD SHOW => WRONG FRAME
    
    [self performSelector:@selector(removePulseLayer:) withObject:pulse afterDelay:0.5];
}

- (void)removePulseLayer:(PulseAnimation*)pulse {
    [pulse removeFromSuperlayer];
    
    [self nextStep];
}

#pragma mark - Action
- (void)nextStep {
    FXSignUpVerifyCodeViewController *verifyCodeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FXSignUpVerifyCodeViewController"];
    verifyCodeVC.transitioningDelegate = self;
    
    [self presentViewController:verifyCodeVC animated:YES completion:nil];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:^{
        self.transitioningDelegate = nil;
    }];
}

#pragma mark - TextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)textChanged:(UITextField *)textField {
    if (textField.text.length > 0) {
        [_btnNextStep setBackgroundColor:[UIColor colorWithRed:27.f/255.f green:112.f/255.f blue:195.f/255.f alpha:1]];
        _btnNextStep.userInteractionEnabled = 1;
    } else {
        [_btnNextStep setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.14]];
        _btnNextStep.userInteractionEnabled = 0;
    }
}

#pragma mark - Table View Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearching) {
        return _arrFilteredCountry.count;
    }
    else {
        return _arrCountry.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FXNationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCELL_NATION forIndexPath:indexPath];
   
    CountryBall *countryBall;

    if (isSearching) {
        countryBall = _arrFilteredCountry[indexPath.row];
        cell.lbNation.text = countryBall.name;
    }
    else {
        countryBall = _arrCountry[indexPath.row];
        cell.lbNation.text = countryBall.name;
    }
    
    cell.imgFlag.image = [UIImage imageNamed:@"Flag_US"];
    
    return cell;
}

#pragma mark - TABLE VIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryBall *countryBall;

    if (isSearching) {
        countryBall = _arrFilteredCountry[indexPath.row];
        _lbCountrySelected.text = countryBall.name;
        _lbCountryPhoneCode.text = [self getCurrentCountryCallingCodeWithCode:countryBall.code];
        _imgFlag.image = [UIImage imageNamed:@"Flag_US"];
    }
    else {
        countryBall = _arrCountry[indexPath.row];
        _lbCountrySelected.text = countryBall.name;
        _lbCountryPhoneCode.text = [self getCurrentCountryCallingCodeWithCode:countryBall.code];
        _imgFlag.image = [UIImage imageNamed:@"Flag_US"];
    }
    
    _viewContainListNation.hidden = 1;
    [self.view endEditing:1];
}

#pragma mark - SEARCH BAR DELEGATE
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d", isSearching);
    
    //Remove all objects first.
    [_arrFilteredCountry removeAllObjects];
    
    if([searchText length] != 0) {
        isSearching = YES;
        
        NSString *searchString = searchBar.text;
        
        for (CountryBall *countryBall in _arrCountry) {
            NSString *tempStr = countryBall.name;
            NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
            if (result == NSOrderedSame) {
                [_arrFilteredCountry addObject:countryBall];
            }
        }
    }
    else {
        isSearching = NO;
    }
    [_tableView reloadData];
}

#pragma mark - UIViewControllerTransitioningDelegate
/* Called when presenting a view controller that has a transitioningDelegate */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [self bounceTrasitionAnimatorWithAppearing:YES];
}

/* Called when dismissing a view controller that has a transitioningDelegate */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [self bounceTrasitionAnimatorWithAppearing:NO];
}

#pragma mark - Utils
- (NSString*)getCurrentCountryCallingCodeWithCode:(NSString*)code {
    NSString *countryCallingCode = [NSString stringWithFormat:@"(+%@)",[[self getCountryCodeDictionary] objectForKey:code]];
    
    return countryCallingCode;
}

- (NSDictionary*)getCountryCodeDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
            @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
            @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
            @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
            @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
            @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
            @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
            @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
            @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
            @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
            @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
            @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
            @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
            @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
            @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
            @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
            @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
            @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
            @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
            @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
            @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
            @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
            @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
            @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
            @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
            @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
            @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
            @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
            @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
            @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
            @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
            @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
            @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
            @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
            @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
            @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
            @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
            @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
            @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
            @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
            @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
            @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
            @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
            @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
            @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
            @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
            @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
            @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
            @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
            @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
            @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
            @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
            @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
            @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
            @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
            @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
            @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
            @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
            @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
            @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
            @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
}



@end



















