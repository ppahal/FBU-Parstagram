//
//  Post.h
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/4/21.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic,strong) NSDate *createdAt;
@property(strong,nonatomic) NSString *username;
@property(strong,nonatomic) PFFileObject *profileImage;
@property(strong,nonatomic) PFFileObject *postImage;
@property(strong,nonatomic) NSString *caption;
@property(nonatomic) BOOL isLiked;
@property(nonatomic) BOOL isFavorited;
@property(strong,nonatomic) NSMutableArray *comments;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)postsWithArray:(NSArray *)dictionaries;
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END
