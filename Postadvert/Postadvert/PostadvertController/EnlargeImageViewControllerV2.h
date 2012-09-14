//
//  EnlargeImageViewControllerV2.h
//  Postadvert
//
//  Created by Mtk Ray on 6/1/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostCellContent;
@protocol KTPhotoBrowserDataSource;
@interface EnlargeImageViewControllerV2 : UIViewController<UIScrollViewDelegate, UIActionSheetDelegate>
{
    id <KTPhotoBrowserDataSource> dataSource_;
    UIScrollView *_scrollView;
	UIPageControl *pageControl;
    NSMutableArray *imageViews;
    
    UILabel *title;
    IBOutlet UIToolbar *topToolbar;
    PostCellContent *content;
    NSInteger totalImage;
    Float32 pageWidth;
    BOOL isShowToolbar;
    BOOL isTempShowToolbar;
    IBOutlet UIWindow *myWindow;
    
    // these values are stored off before we start rotation so we adjust our content offset appropriately during rotation
    int firstVisiblePageIndexBeforeRotation_;
    CGFloat percentScrolledIntoFirstVisiblePage_;
    NSInteger _index;
}

- (id) initWithDataSource:(id <KTPhotoBrowserDataSource> )datasource andStartWithPhotoAtIndex:(NSInteger)index;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
//@property (nonatomic, assign) PostCellContent *content;
@property (nonatomic, strong) NSMutableArray *imageViews;
//@property (nonatomic) NSInteger index;

@end
