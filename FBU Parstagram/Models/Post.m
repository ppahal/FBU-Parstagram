//
//  Post.m
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/4/21.
//

#import "Post.h"

@implementation Post
//User info
@dynamic author;
@dynamic username;
//Post info
@dynamic caption;
@dynamic likeCount;
@dynamic commentCount;
@dynamic isFavorited;
@dynamic isLiked;
@dynamic comments;
//Images
@dynamic profileImage;
@dynamic postImage;
//Logistical info
@dynamic postID;
@dynamic userID;
@dynamic createdAt;

+ (nonnull NSString *)parseClassName {
        return @"Post";
    }

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        //User info
        self.author = [PFUser currentUser];
        self.username=dictionary[@"username"];
        //Post info
        self.likeCount = @(0);
        self.commentCount = @(0);
        self.caption=dictionary[@"caption"];
        self.comments=dictionary[@"comments"];
        self.isFavorited=dictionary[@"favorited"];
        self.isLiked=dictionary[@"liked"];
        //Images
        self.postImage= dictionary[@"postImage"];
        //self.profileImage=dictionary[@"profileImage"];
        //Logistical info
        self.postID=dictionary[@"postID"];
        self.userID=dictionary[@"userID"];
        self.createdAt=dictionary[@"createdAt"];
    }
    return self;
}

+ (NSMutableArray *)postsWithArray:(NSArray *)dictionaries{
    NSMutableArray *posts = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Post *post = [[Post alloc] initWithDictionary:dictionary];
        [posts addObject:post];
    }
    return posts;
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
