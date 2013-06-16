## Supports

KRUploader supports ARC.

## How To Get Started

KRUploader can easy use POST method of HTTP protocol to upload an image to server.

``` objective-c
#import "KRUploader.h"

@synthesize _krUploader;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _krUploader = [[KRUploader alloc] init];
}

-(IBAction)uploadImageMethod1:(id)sender
{
    __weak KRUploader *_anotherUploader = [KRUploader sharedManager];
    _anotherUploader.serverURL          = @"http://yourserver";
    _anotherUploader.uploadImage        = _uploadImage;
    _anotherUploader.serverReceivedName = @"myVarName";
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
    self._krUploader.uploadImage        = _uploadImage;
    self._krUploader.serverReceivedName = @"myVarName";
    self._krUploader.imageFileName      = @"myImage.png";
    [self._krUploader startUploadWithCompletion:^(NSString *responseString) {
        NSLog(@"response string : %@", responseString);
    }];
}
```

## Version

KRUploader now is V0.5 beta.

## License

KRUploader is available under the MIT license ( or Whatever you wanna do ). See the LICENSE file for more info.
