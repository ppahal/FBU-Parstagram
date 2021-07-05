//
//  CameraViewController.h
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/5/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CameraViewControllerDelegate
- (void)didPost:(Post *) post;
@end

@interface CameraViewController : UIViewController
@property (nonatomic, weak) id<CameraViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
