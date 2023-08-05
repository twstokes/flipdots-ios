#import <Foundation/Foundation.h>

//! Project version number for SwiftGFXWrapperWatchOS.
FOUNDATION_EXPORT double SwiftGFXWrapperWatchOSVersionNumber;

//! Project version string for SwiftGFXWrapperWatchOS.
FOUNDATION_EXPORT const unsigned char SwiftGFXWrapperWatchOSVersionString[];

// clear out the variable modifier used in the library
// since we don't have the PROGMEM Arduino functions
#define PROGMEM

#import "VirtualDotMatrixWrapper.h"
#import "Fonts.h"
