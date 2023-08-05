//
//  FlipDotMatrixHeader.h
//  Flipper
//
//  Created by Tanner W. Stokes on 12/30/20.
//

#ifndef VirtualDotMatrixWrapper_h
#define VirtualDotMatrixWrapper_h
#endif /* VirtualDotMatrixWrapper_h */

#import <Foundation/Foundation.h>
#import "gfxfont.h"

@interface VirtualDotMatrixWrapper : NSObject

#ifdef __cplusplus
@property /*(unsafe_unretained,assign,atomic)*/ (nonatomic) VirtualDotMatrix * virtualDotMatrix;
#endif

- (id)init:(NSInteger)w h:(NSInteger)h;
//- (void) start:(void (short, short, unsigned short))drawPixelCallback;
- (void) start:(const void *)selfPtr drawPixelCallback:(void (short, short, unsigned short, const void *))drawPixelCallback;
- (void) drawPixel:(NSInteger)x y:(NSInteger)y c:(NSInteger)c;
- (NSInteger) getPixel:(NSInteger)x y:(NSInteger)y;
- (void) print:(NSString *)s;
- (void) setRotation:(NSInteger)r;
- (void) invertDisplay:(bool)i;
- (void) drawFastVLine:(NSInteger)x y:(NSInteger)y height:(NSInteger)h color:(NSInteger)c;
- (void) drawFastHLine:(NSInteger)x y:(NSInteger)y width:(NSInteger)w color:(NSInteger)c;
- (void) fillRect:(NSInteger)x y:(NSInteger)y width:(NSInteger)w height:(NSInteger)h color:(NSInteger)c;
- (void) fillScreen:(int)c;
- (void) drawLine:(NSInteger)x0 y0:(NSInteger)y0 x1:(NSInteger)x1 y1:(NSInteger)y1 color:(NSInteger)c;
- (void) drawRect:(NSInteger)x y:(NSInteger)y w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c;
- (void) drawCircle:(NSInteger)x0 y0:(NSInteger)y0 radius:(NSInteger)r color:(NSInteger)c;
- (void) drawCircleHelper:(NSInteger)x0 y0:(NSInteger)y0 radius:(NSInteger)r cornername:(NSInteger)cornername color:(NSInteger)c;
- (void) fillCircle:(NSInteger)x0 y0:(NSInteger)y0 radius:(NSInteger)r color:(NSInteger)c;
- (void) fillCircleHelper:(NSInteger)x0 y0:(NSInteger)y0 r:(NSInteger)r cornername:(NSInteger)cornername delta:(NSInteger)delta color:(NSInteger)c;
- (void) drawTriangle:(NSInteger)x0 y0:(NSInteger)y0 x1:(NSInteger)x1 y1:(NSInteger)y1 x2:(NSInteger)x2 y2:(NSInteger)y2 color:(NSInteger)c;
- (void) fillTriangle:(NSInteger)x0 y0:(NSInteger)y0 x1:(NSInteger)x1 y1:(NSInteger)y1 x2:(NSInteger)x2 y2:(NSInteger)y2 color:(NSInteger)c;
- (void) drawRoundRect:(NSInteger)x0 y0:(NSInteger)y0 w:(NSInteger)w h:(NSInteger)h radius:(NSInteger)r color:(NSInteger)c;
- (void) fillRoundRect:(NSInteger)x0 y0:(NSInteger)y0 w:(NSInteger)w h:(NSInteger)h radius:(NSInteger)r color:(NSInteger) c;
- (void) drawBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt8 [])bitmap w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c;
- (void) drawBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt8 [])bitmap w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c bg:(NSInteger)bg;
- (void) drawBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(UInt8 *)bitmap w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c;
- (void) drawBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(UInt8 *)bitmap w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c bg:(NSInteger)bg;
- (void) drawXBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt8 [])bitmap w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c;
- (void) drawGrayscaleBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt8 [])bitmap w:(NSInteger)w h:(NSInteger)h;
- (void) drawGrayscaleBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(UInt8*)bitmap w:(NSInteger)w h:(NSInteger)h;
- (void) drawGrayscaleBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt8 [])bitmap mask:(const UInt8 [])mask w:(NSInteger)w h:(NSInteger)h;
- (void) drawGrayscaleBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(UInt8*)bitmap mask:(UInt8*)mask w:(NSInteger)w h:(NSInteger)h;
- (void) drawRGBBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt16 [])bitmap w:(NSInteger)w h:(NSInteger)h;
- (void) drawRGBBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(UInt16*)bitmap w:(NSInteger)w h:(NSInteger)h;
- (void) drawRGBBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt16 [])bitmap mask:(const UInt8 [])mask w:(NSInteger)w h:(NSInteger)h;
- (void) drawRGBBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(UInt16*)bitmap mask:(UInt8*)mask w:(NSInteger)w h:(NSInteger)h;
- (void) drawChar:(NSInteger)x y:(NSInteger)y c:(unsigned char)c color:(NSInteger)color bg:(NSInteger)bg size:(NSInteger)size;
- (void) drawChar:(NSInteger)x y:(NSInteger)y c:(unsigned char)c color:(NSInteger)color bg:(NSInteger)bg sizeX:(NSInteger)size_x sizeY:(NSInteger)size_y;
- (void) getTextBoundsPtr:(const char *)str x:(NSInteger)x y:(NSInteger)y x1:(int16_t *)x1 y1:(int16_t *)y1 w:(uint16_t*)w h:(uint16_t *)h;
// TODO - this is broken because String type can't be found when the library is used as a framework
//- (void) getTextBounds:(const String)str x:(NSInteger)x y:(NSInteger)y x1:(NSInteger *)x1 y1:(NSInteger *)y1 w:(NSInteger *)w h:(NSInteger *)h;
- (void) setTextSize:(NSInteger)s;
- (void) setTextSizeXY:(NSInteger)sx sy:(NSInteger)sy;
// TODO - test this - include all the font headers?
//- (void) setFont:(const GFXfont *)f;
- (void) setCursor:(NSInteger)w height:(NSInteger)h;
- (void) setTextColor:(NSInteger)c;
- (void) setTextColor:(NSInteger)c bg:(NSInteger)bg;
- (void) setTextWrap:(bool)w;
- (void) cp437:(bool)x;
- (NSInteger) width;
- (NSInteger) height;
- (NSInteger) getRotation;
- (NSInteger) getCursorX;
- (NSInteger) getCursorY;

@end
