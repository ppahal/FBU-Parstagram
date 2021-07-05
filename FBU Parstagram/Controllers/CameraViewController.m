//
//  CameraViewController.m
//  FBU Parstagram
//
//  Created by Priya Pahal on 7/5/21.
//

#import "CameraViewController.h"
#import "Post.h"
#import "Parse/Parse.h"
#import "TimelineViewController.h"

@interface CameraViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *postView;
@property (weak, nonatomic) IBOutlet UITextView *captionView;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captionView.delegate=self;
    self.captionView.textColor = UIColor.lightGrayColor;
    // Do any additional setup after loading the view.
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if(textView.textColor == UIColor.lightGrayColor){
        textView.text = nil;
        textView.textColor = UIColor.whiteColor;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if(textView.text.length == 0){
        textView.text = @"Write a caption...";
        textView.textColor = UIColor.lightGrayColor;
    }
}

- (IBAction)selectImage:(id)sender {
    if(self.captionView.text.length == 0){
        self.captionView.text = @"Write a caption...";
        self.captionView.textColor = UIColor.lightGrayColor;
    }
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)clickShare:(id)sender {
    Post *newPost = [Post new];
    //User info
    newPost.author = [PFUser currentUser];
    //Post info
    newPost.caption = self.captionView.text;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    //newPost.comments = [[NSArray alloc] NSArray init];
    newPost.isFavorited=NO;
    newPost.isLiked=NO;
    //Images
    newPost.postImage= [Post getPFFileFromImage:self.postView.image];
    
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            [self.delegate didPost:newPost];
            [self performSegueWithIdentifier:@"cameraToTimelineSegue" sender:self];
        }else{
            NSLog(@"%@",@"Post error.");
        }
    }];
}
- (IBAction)clickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *image = [self resizeImage:info[UIImagePickerControllerEditedImage] withSize:CGSizeMake(300, 300)];
    self.postView.image = image;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
