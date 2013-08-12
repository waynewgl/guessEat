//
//  UIDevice+Resolutions.h
//  guessEat
//
//  Created by Stephen Zheng on 12/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#ifndef guessEat_UIDevice_Resolutions_h
#define guessEat_UIDevice_Resolutions_h

enum {
    UIDeviceResolution_Unknown           = 0,
    UIDeviceResolution_iPhoneStandard    = 1,    // iPhone 1,3,3GS Standard Display  (320x480px)
    UIDeviceResolution_iPhoneRetina4    = 2,    // iPhone 4,4S Retina Display 3.5"  (640x960px)
    UIDeviceResolution_iPhoneRetina5     = 3,    // iPhone 5 Retina Display 4"       (640x1136px)
    UIDeviceResolution_iPadStandard      = 4,    // iPad 1,2,mini Standard Display   (1024x768px)
    UIDeviceResolution_iPadRetina        = 5     // iPad 3 Retina Display            (2048x1536px)
}; typedef NSUInteger UIDeviceResolution;

@interface UIDevice (Resolutions)

- (UIDeviceResolution)resolution;

NSString *NSStringFromResolution(UIDeviceResolution resolution);

@end


#endif
