//
//  PostCell.h
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/4/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Parse/Parse.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profileView;
@property (weak, nonatomic) IBOutlet PFImageView *postView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *directMessageButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property(strong,nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
