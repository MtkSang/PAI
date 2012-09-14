

#import <UIKit/UIKit.h>
@class LeftViewController;
@class DetailViewController;
//@class RightViewController;
@class LeftViewController;
@class DetailViewController;
//@class RightViewController;
typedef enum
{
    SideBarInternalStateNormal,
    SideBarInternalStateCurrent,
    SideBarInternalStateComments
}SideBarInternalState;

@interface SideBarViewController : UIViewController<UIGestureRecognizerDelegate>
{
    
    UINavigationController *navLeft;
    UINavigationController *navDetail;
    UIButton * button;
    UIView *botView;
    UIView *loginView;
    NSInteger previousState;
    NSInteger didShowListLogin;
    LeftViewController *sideBar ;
    DetailViewController *mainCtr ;
    SideBarInternalState internalState;
    UIBarButtonItem *leftBarBtnNavDetail;
    CGPoint previousPoint;
}
@property (nonatomic) NSInteger                              sideBarState;
@property (nonatomic, strong) UINavigationController    *navLeft;;
@property (nonatomic, strong) UINavigationController    *navDetail;
@property (nonatomic, strong) IBOutlet UIView *overlay;
- (IBAction) showHideSideBar;
- (IBAction)buttonClicked:(id)sender;
- (void)navMove;
+ (SideBarViewController*)instanceSideBar;
- (UIView*) createLoginListView;
-(IBAction) onTouchSignInBtn: (id) sender;
-(IBAction) onTouchSignInAnonymouslybtn:(id) sender;
-(IBAction) onTouchCreateAccountBtn: (id) sender;
-( void ) logOutListener;
- (void) showPopUpDialog:(UIView*) view :(CGPoint) point;
- (void) hidePopUpDialog:(UIView*) view;
- (void)navigatePostAdvertWithBrowser:(id) sender;
@end