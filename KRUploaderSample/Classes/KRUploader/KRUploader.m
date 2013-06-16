//
//  KRUploader.m
//  KRUploaderSample
//
//  Created by Kalvar on 13/6/16.
//  Copyright (c) 2013年 Kuo-Ming Lin. All rights reserved.
//

#import "KRUploader.h"

@interface KRUploader ()

@end

@interface KRUploader (fixPrivate)

-(void)_initWithVars;

@end

@implementation KRUploader (fixPrivate)

-(void)_initWithVars
{
    self.serverURL          = @"";
    self.serverReceivedName = @"_varName";
    self.uploadImage        = nil;
    self.imageFileName      = @"_sample.png";
    self.responseString     = @"";
    self.error              = nil;
}

@end

@implementation KRUploader

@synthesize serverURL;
@synthesize serverReceivedName;
@synthesize uploadImage;
@synthesize imageFileName;
@synthesize responseString;
@synthesize error;
@synthesize completion;
@synthesize failure;

+(KRUploader *)sharedManager
{
    static dispatch_once_t pred;
    static KRUploader *_singleton = nil;
    dispatch_once(&pred, ^{
        _singleton = [[KRUploader alloc] init];
    });
    return _singleton;
    //return [[self alloc] init];
}

-(id)init
{
    self = [super init];
    if( self )
    {
        [self _initWithVars];
    }
    return self;
}

#pragma --mark Methods
-(NSString *)startUpload
{
    //To convert your image file to raw.
    NSData *imageData = UIImagePNGRepresentation(self.uploadImage);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:self.serverURL]];
    [request setHTTPMethod:@"POST"];
    //Boundary and Header.
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    //Your uploading file.
    NSMutableData *bodyData = [NSMutableData data];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    /*
     * Declares the PHP received $_FILES variables.
     * - $_FILES['_varName']['name'] = _sample.png
     */
    NSString *_contentDisposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                                     self.serverReceivedName,
                                     self.imageFileName];
    [bodyData appendData:[_contentDisposition dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[NSData dataWithData:imageData]];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:bodyData];
    //Received response of server.
    NSError *_error;
    NSData *returnData     = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&_error];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    self.responseString    = returnString;
    self.error             = _error;
    if( self.completion )
    {
        if( !_error )
        {
            self.completion();
        }
    }
    if( self.failure )
    {
        if( _error )
        {
            self.failure();
        }
    }
    return self.responseString;
}

-(void)startUploadWithCompletion:(UploadCompleted)_completeHandler;
{
    self.completion = nil;
    self.failure    = nil;
    _completeHandler( [self startUpload] );
}

@end
