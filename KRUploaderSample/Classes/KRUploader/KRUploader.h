//
//  KRUploader.h
//  KRUploaderSample
//
//  Created by Kalvar on 13/6/16.
//  Copyright (c) 2013年 Kuo-Ming Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UploadCompleted)(NSString *responseString);

@interface KRUploader : NSObject
{
    //要上傳的目標 SERVER URL
    NSString *serverURL;
    //要上傳的圖片
    UIImage *uploadImage;
    //SERVER 收到的參數名 $_FILES['_varName']['name']
    NSString *serverReceivedName;
    //SERVER 收到的上傳圖片名稱 _sample.png
    NSString *imageFileName;
    NSString *responseString;
    NSError *error;
}

@property (nonatomic, strong) NSString *serverURL;
@property (nonatomic, strong) UIImage *uploadImage;
@property (nonatomic, strong) NSString *serverReceivedName;
@property (nonatomic, strong) NSString *imageFileName;
@property (nonatomic, strong) NSString *responseString;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, copy) void (^completion)(void);
@property (nonatomic, copy) void (^failure)(void);

+(KRUploader *)sharedManager;
-(NSString *)startUpload;
-(void)startUploadWithCompletion:(UploadCompleted)_completeHandler;

@end
