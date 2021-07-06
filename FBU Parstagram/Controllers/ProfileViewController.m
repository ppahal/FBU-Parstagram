//
//  ProfileViewController.m
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/4/21.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "ProfileMenuViewController.h"
#import "CameraViewController.h"
#import "PostImageCell.h"

@interface ProfileViewController () <CameraViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UIButton *postCount;
@property (weak, nonatomic) IBOutlet UIButton *followingCount;
@property (weak, nonatomic) IBOutlet UIButton *followersCount;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *pronounsLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *usernameLabel;
@property (strong,nonatomic) NSMutableArray *posts;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //Fix layout
    //InterItem Spacing
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    CGFloat postsPerRow = 3;
    CGFloat itemwidth = (self.collectionView.frame.size.width)/postsPerRow;
    self.flowLayout.itemSize = CGSizeMake(itemwidth, itemwidth);
    
    //Modify profileView
    self.profileView.layer.cornerRadius = self.profileView.frame.size.width/2;
    self.profileView.clipsToBounds = YES;
    
    [self fetchPosts];
}

//- (void)viewDidLayoutSubviews {
//   [super viewDidLayoutSubviews];
//    NSLog(@"Spacing");
//
//    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.flowLayout.minimumLineSpacing = 0;
//    self.flowLayout.minimumInteritemSpacing = 0;
//    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//}

-(void) fetchPosts{
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            NSLog(@"%@",@"Fetch successful");
            // do something with the data fetched
            self.posts = [Post postsWithArray:posts];
            [self.collectionView reloadData];
        }
        else {
            NSLog(@"%@",@"Fetch error.");
            // handle error
        }
    }];
}

-(void)setScreenInfo{
    PFUser *me = [PFUser currentUser];
    //self.nameLabel.text = me.name;
    self.usernameLabel.title = me.username;
    //self.pronounsLabel.text = me.pronouns;
    //self.profileView
    //self.postCount.titleLabel.text = NSString(@"%d", self.posts.count);
    
}

- (IBAction)editProfile:(id)sender {
}

- (void)didPost:(Post *)post{
    [self.posts insertObject:post atIndex:0];
    [self.collectionView reloadData];
}
- (IBAction)clickCamera:(id)sender {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"profileToCameraSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        CameraViewController *vc = (CameraViewController*)navigationController.topViewController;
        vc.delegate = self;
    }else{
        ProfileMenuViewController *vc = [segue destinationViewController];
        [vc.tabBarController.tabBar removeFromSuperview];
    }
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"PostImageCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.item];
    cell.postView.file = post.postImage;
    [cell.postView loadInBackground];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

//// MARK: UICollectionViewDelegateFlowLayout methods
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"IN flowLayout");
//    int totalwidth = self.collectionView.bounds.size.width;
//    int numberOfCellsPerRow = 3;
//    int dimensions = (CGFloat)(totalwidth / numberOfCellsPerRow);
//    return CGSizeMake(dimensions, dimensions);
//}

@end
