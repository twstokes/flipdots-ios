#import <Foundation/Foundation.h>

//! Project version number for SwiftGFXWrapperMacOS.
FOUNDATION_EXPORT double SwiftGFXWrapperMacOSVersionNumber;

//! Project version string for SwiftGFXWrapperMacOS.
FOUNDATION_EXPORT const unsigned char SwiftGFXWrapperMacOSVersionString[];

// clear out the variable modifier used in the library
// since we don't have the PROGMEM Arduino functions
#define PROGMEM

#import "VirtualDotMatrixWrapper.h"
#import "Fonts.h"
