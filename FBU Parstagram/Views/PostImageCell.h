//
//  PostImageCell.h
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/5/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Parse/Parse.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postView;
@end

NS_ASSUME_NONNULL_END
