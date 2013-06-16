//
//  ViewController.h
//  KRUploaderSample
//
//  Created by Kalvar on 13/6/16.
//  Copyright (c) 2013年 Kuo-Ming Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
}

@property (nonatomic, weak) IBOutlet UIImageView *outImageView;

-(IBAction)pickPhoto:(id)sender;
-(IBAction)uploadImageMethod1:(id)sender;
-(IBAction)uploadImageMethod2:(id)sender;

@end
