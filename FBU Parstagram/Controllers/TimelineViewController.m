//
//  TimelineViewController.m
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/3/21.
//

#import "TimelineViewController.h"
#import "PostCell.h"
#import "Post.h"
#import "Parse/Parse.h"
#import "CameraViewController.h"

@interface TimelineViewController ()<UITableViewDelegate, UITableViewDataSource, CameraViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    [self fetchPosts];
    NSLog(@"%@",@"Load screen");
}

-(void) fetchPosts{
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            NSLog(@"%@",@"Fetch successful");
            // do something with the data fetched
            self.posts = [Post postsWithArray:posts];
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@",@"Fetch error.");
            // handle error
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"%@",@"Go to camera.");
    if([[segue identifier] isEqualToString:@"timelineToCameraSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        CameraViewController *vc = (CameraViewController*)navigationController.topViewController;
        vc.delegate = self;
    }
}

- (void)didPost:(Post *)post{
    [self.posts insertObject:post atIndex:0];
    [self.tableView reloadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    //Set up username
    cell.usernameLabel.text = [post.author.username lowercaseString];
    NSString *likes = [post.likeCount stringValue];
    cell.likeCount.text = [likes stringByAppendingString:@" Likes"];
    cell.captionLabel.text = post.caption;
    
//    //Set up profile pic
//    NSString *URLString = post.profileImage;
//    NSURL *url = [NSURL URLWithString:URLString];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if(post.profileImage){
        cell.profileView.file = post.profileImage;
        [cell.profileView loadInBackground];
    }else{
        cell.postView.image = [UIImage imageNamed:@"person.fill"];
    }
    cell.profileView.layer.cornerRadius = cell.profileView.frame.size.width/2;
    cell.profileView.clipsToBounds = YES;
//    cell.profileView.image = [UIImage imageWithData:urlData];
//
    //Set up post image
    cell.postView.file = post.postImage;
    [cell.postView loadInBackground];
//    URLString = post.postImage;
//    url = [NSURL URLWithString:URLString];
//    urlData = [NSData dataWithContentsOfURL:url];
//    cell.postView.image = [UIImage imageWithData:urlData];
//
//    //Set up post caption
//    NSString *captionUsername = [post.username stringByAppendingString:@" "];
//    NSString *captionEntire = [captionUsername stringByAppendingString:post.caption];
//    NSMutableAttributedString *captionAttributed = [[NSMutableAttributedString alloc] initWithString:captionEntire];
//    [captionAttributed addAttribute:NSFontAttributeName
//                                          value:[UIFont fontWithName:@"System-Semibold" size:17.0]
//                                  range:NSMakeRange(0, ([post.username length] - 1))] ;
//    cell.captionLabel.text = captionAttributed.string;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (IBAction)clickDirectMessages:(id)sender {
}

- (IBAction)clickCamera:(id)sender {
    [self performSegueWithIdentifier:@"timelineToCameraSegue" sender:self];
}

@end
