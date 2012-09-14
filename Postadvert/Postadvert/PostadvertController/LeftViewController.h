#import <UIKit/UIKit.h>
#import "WEPopoverController.h"
@class DetailViewController;

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"
@class DetailViewController;
@interface LeftViewController : UIViewController<WEPopoverControllerDelegate, UIPopoverControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate> 

{
    IBOutlet UIView * overlay;
    IBOutlet UIButton *botButton;
    //IBOutlet UITableView *tableView;
    //IBOutlet UIView *botView;
    UIView *menuView;
    BOOL isHideSideBar;
    CGPoint previousPoint;
}
@property (nonatomic, strong) UIView             *overlay;
@property (nonatomic, strong) NSMutableArray     *listItems;
@property (nonatomic, strong) NSMutableArray     *listImages;
@property (nonatomic, strong) NSMutableArray     *listItemsFavorites;
@property (nonatomic, strong) NSMutableArray     *listIamgesFavorites;
@property (nonatomic, strong) WEPopoverController *popoverController;
@property (nonatomic, strong) DetailViewController *detailVw;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *botView;

- (void)showPopUpDialog:(UIView*) view :(CGPoint) point;
- (void) hidePopUpDialog:(UIView*) view;
//- (UIView*) createLoginListView;
- (UIView*) drawPostAdvertTopMenu;
//- (UIView*) drawPostAdvertMainMenu;
+ (UIImage*)        getFlagWithName:(NSString*) countryName;
- (IBAction)buttonClinked:(id)sender;
@end