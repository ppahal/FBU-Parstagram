//
//  PostCell.m
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/4/21.
//

#import "PostCell.h"
#import "Post.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initializePostCell:(Post *)post{
    //Set up post
    self.post = post;
    
    //Set up username
    self.usernameLabel.text = post.username;
    
    //Set up profile pic
    
    self.profileView.layer.cornerRadius = self.profileView.frame.size.width/2;
    self.profileView.clipsToBounds = YES;
    
    //Set up post image
    
    
    //Set up post caption
    NSString *captionUsername = [post.username stringByAppendingString:@" "];
    NSString *captionEntire = [captionUsername stringByAppendingString:post.caption];
    NSMutableAttributedString *captionAttributed = [[NSMutableAttributedString alloc] initWithString:captionEntire];
    [captionAttributed addAttribute:NSFontAttributeName
                                          value:[UIFont fontWithName:@"System-Semibold" size:17.0]
                                  range:NSMakeRange(0, ([post.username length] - 1))] ;
    self.captionLabel.text = captionAttributed.string;
}

@end
