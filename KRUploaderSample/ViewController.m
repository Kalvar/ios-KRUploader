//
//  ViewController.m
//  KRUploaderSample
//
//  Created by Kalvar on 13/6/16.
//  Copyright (c) 2013年 Kuo-Ming Lin. All rights reserved.
//

#import "ViewController.h"
#import "KRUploader.h"

@interface ViewController ()

@property (nonatomic, strong) KRUploader *_krUploader;

@end

@implementation ViewController

@synthesize outImageView;
@synthesize _krUploader;

- (void)viewDidLoad
{
    [super viewDidLoad];
	_krUploader = [[KRUploader alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma --mark IBActions
-(IBAction)pickPhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate   = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

-(IBAction)uploadImageMethod1:(id)sender
{
    __weak KRUploader *_anotherUploader = [KRUploader sharedManager];
    _anotherUploader.serverURL          = @"http://yourserver";
    _anotherUploader.uploadImage        = self.outImageView.image;
    _anotherUploader.serverReceivedName = @"myVarName";    //$_FILES['myVarName']['name'] = 'myImage.png'
    _anotherUploader.imageFileName      = @"myImage.png";
    [_anotherUploader setCompletion:^{
        NSLog(@"response string : %@", _anotherUploader.responseString);
    }];
    [_anotherUploader setFailure:^{
        NSLog(@"error descriptions : %@", _anotherUploader.error.description);
    }];
    [_anotherUploader startUpload];
}

-(IBAction)uploadImageMethod2:(id)sender
{
    self._krUploader.serverURL          = @"http://yourserver";
    self._krUploader.uploadImage        = self.outImageView.image;
    self._krUploader.serverReceivedName = @"myVarName";   //$_FILES['myVarName']['name'] = 'myImage.png'
    self._krUploader.imageFileName      = @"myImage.png";
    [self._krUploader startUploadWithCompletion:^(NSString *responseString) {
        NSLog(@"response string : %@", responseString);
    }];
}

#pragma UIImagePickerDelegate
//選擇完成時的動作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{    
    //[picker.parentViewController dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.outImageView.image = image;
}

//選擇取消時的動作
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
