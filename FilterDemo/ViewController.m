//
//  ViewController.m
//  FilterDemo
//
//  Created by LiJunfeng on 15/11/26.
//  Copyright © 2015年 LiJunfeng. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage.h>
#import "GPUImageFourInputFilter.h"
#import "GPUImageFiveInputFilter.h"
#import "GPUImageSixInputFilter.h"
#import "IFAmaroFilter.h"
#import "IFBrannanFilter.h"

typedef NS_ENUM(NSUInteger, FilterType) {
    FilterTypeThree,
    FilterTypeFour,
    FilterTypeFive,
    FilterTypeSix,
};

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

//@property (nonatomic, strong) GPUImageAddBlendFilter *filter;

//-----------------------------------------------------------------

@property (nonatomic) FilterType filterType;

@property (nonatomic, strong) GPUImageThreeInputFilter *threeFilter;
@property (nonatomic, strong) GPUImageFourInputFilter *fourFilter;
@property (nonatomic, strong) GPUImageFiveInputFilter *fiveFilter;
@property (nonatomic, strong) GPUImageSixInputFilter *sixFilter;

@property (nonatomic, strong) GPUImagePicture *sourcePicture;
@property (nonatomic, strong) GPUImagePicture *sourcePicture1;
@property (nonatomic, strong) GPUImagePicture *sourcePicture2;
@property (nonatomic, strong) GPUImagePicture *sourcePicture3;
@property (nonatomic, strong) GPUImagePicture *sourcePicture4;
@property (nonatomic, strong) GPUImagePicture *sourcePicture5;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.filterType = FilterTypeFour;
//    self.filterType = FilterTypeSix;
    
    self.sourcePicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"jfl"]];
}

- (IBAction)filter:(id)sender
{
    UIImage *resultImage;
    
    switch (self.filterType) {
        case FilterTypeThree: {
            
            break;
        }
        case FilterTypeFour: {
            self.fourFilter = [[IFAmaroFilter alloc] init];
            
            self.sourcePicture1 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blackboard1024" ofType:@"png"]]];
            self.sourcePicture2 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"overlayMap" ofType:@"png"]]];
            self.sourcePicture3 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"amaroMap" ofType:@"png"]]];
            
            [self.sourcePicture addTarget:self.fourFilter];
            [self.sourcePicture1 addTarget:self.fourFilter];
            [self.sourcePicture2 addTarget:self.fourFilter];
            [self.sourcePicture3 addTarget:self.fourFilter];
            
            [self.fourFilter useNextFrameForImageCapture];
            
            [self.sourcePicture processImage];
            [self.sourcePicture1 processImage];
            [self.sourcePicture2 processImage];
            [self.sourcePicture3 processImage];
            
            resultImage = [self.fourFilter imageFromCurrentFramebuffer];
            
            break;
        }
        case FilterTypeFive: {
            break;
        }
        case FilterTypeSix: {
            self.sixFilter = [[IFBrannanFilter alloc] init];
            
            self.sourcePicture1 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"brannanProcess" ofType:@"png"]]];
            self.sourcePicture2 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"brannanBlowout" ofType:@"png"]]];
            self.sourcePicture3 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"brannanContrast" ofType:@"png"]]];
            self.sourcePicture4 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"brannanLuma" ofType:@"png"]]];
            self.sourcePicture5 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"brannanScreen" ofType:@"png"]]];
            
            [self.sourcePicture addTarget:self.sixFilter];
            [self.sourcePicture1 addTarget:self.sixFilter];
            [self.sourcePicture2 addTarget:self.sixFilter];
            [self.sourcePicture3 addTarget:self.sixFilter];
            [self.sourcePicture4 addTarget:self.sixFilter];
            [self.sourcePicture5 addTarget:self.sixFilter];
            
            [self.sixFilter useNextFrameForImageCapture];
            
            [self.sourcePicture processImage];
            [self.sourcePicture1 processImage];
            [self.sourcePicture2 processImage];
            [self.sourcePicture3 processImage];
            [self.sourcePicture4 processImage];
            [self.sourcePicture5 processImage];
            
            resultImage = [self.sixFilter imageFromCurrentFramebuffer];
            
            break;
        }
            
            
        default:
            break;
    }
    
    self.testImageView.image = resultImage;
}


@end
