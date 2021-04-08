#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Account.h"
#import "AccountTool.h"

FOUNDATION_EXPORT double QYCAccountVersionNumber;
FOUNDATION_EXPORT const unsigned char QYCAccountVersionString[];

