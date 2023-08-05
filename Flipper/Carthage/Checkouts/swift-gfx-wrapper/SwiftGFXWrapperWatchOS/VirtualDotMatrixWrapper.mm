//
//  VirtualDotMatrixWrapper.m
//  Flipper
//
//  Created by Tanner W. Stokes on 12/30/20.
//

#import <Foundation/Foundation.h>

#import "VirtualDotMatrix.hpp"
#import "VirtualDotMatrixWrapper.h"


@implementation VirtualDotMatrixWrapper
{
    VirtualDotMatrix * _VirtualDotMatrix;
}

-(id)init:(NSInteger)w h:(NSInteger)h {
    self = [super init];
    if (self) {
        _VirtualDotMatrix = new VirtualDotMatrix(w, h);
    }
    return self;
}

-(void)setVirtualDotMatrix:(VirtualDotMatrix*)newVal {
    @synchronized(self) {
        delete _VirtualDotMatrix;
        _VirtualDotMatrix = newVal;
    }
}

-(VirtualDotMatrix*)VirtualDotMatrix {
    return _VirtualDotMatrix;
}

-(void)dealloc {
    delete _VirtualDotMatrix;
}

- (void) start:(const void *)selfPtr drawPixelCallback:(void (short, short, unsigned short, const void *))drawPixelCallback {
    _VirtualDotMatrix->start(selfPtr, drawPixelCallback);
}

- (void) drawPixel:(NSInteger)x y:(NSInteger)y c:(NSInteger)c {
    _VirtualDotMatrix->drawPixel(int16_t(x), int16_t(y), uint16_t(c));
}

- (NSInteger) getPixel:(NSInteger)x y:(NSInteger)y {
    return _VirtualDotMatrix->getPixel(int16_t(x), int16_t(y));
}

- (void) print:(NSString *)s {
    _VirtualDotMatrix->print(s.UTF8String);
}

- (void) setRotation:(NSInteger)r {
    _VirtualDotMatrix->setRotation(uint8_t(r));
}

- (void) invertDisplay:(bool)i {
    _VirtualDotMatrix->invertDisplay(i);
}

- (void) drawFastVLine:(NSInteger)x y:(NSInteger)y height:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->drawFastVLine(x, y, h, c);
}

- (void) drawFastHLine:(NSInteger)x y:(NSInteger)y width:(NSInteger)w color:(NSInteger)c {
    _VirtualDotMatrix->drawFastHLine(x, y, w, c);
}

- (void) fillRect:(NSInteger)x y:(NSInteger)y width:(NSInteger)w height:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->fillRect(x, y, w, h, c);
}

- (void) fillScreen:(int)c {
    _VirtualDotMatrix->fillScreen(c);
}

- (void) drawLine:(NSInteger)x0 y0:(NSInteger)y0 x1:(NSInteger)x1 y1:(NSInteger)y1 color:(NSInteger)c {
    _VirtualDotMatrix->drawLine(x0, y0, x1, y1, c);
}

- (void) drawRect:(NSInteger)x y:(NSInteger)y w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->drawRect(x, y, w, h, c);
}

- (void) drawCircle:(NSInteger)x0 y0:(NSInteger)y0 radius:(NSInteger)r color:(NSInteger)c {
    _VirtualDotMatrix->drawCircle(x0, y0, r, c);
}

- (void) drawCircleHelper:(NSInteger)x0 y0:(NSInteger)y0 radius:(NSInteger)r cornername:(NSInteger)cornername color:(NSInteger)c {
    _VirtualDotMatrix->drawCircleHelper(x0, y0, r, cornername, c);
}

- (void) fillCircle:(NSInteger)x0 y0:(NSInteger)y0 radius:(NSInteger)r color:(NSInteger)c {
    _VirtualDotMatrix->fillCircle(x0, y0, r, c);
}

- (void) fillCircleHelper:(NSInteger)x0 y0:(NSInteger)y0 r:(NSInteger)r cornername:(NSInteger)cornername delta:(NSInteger)delta color:(NSInteger)c {
    _VirtualDotMatrix->fillCircleHelper(x0, y0, r, cornername, delta, c);
}

- (void) drawTriangle:(NSInteger)x0 y0:(NSInteger)y0 x1:(NSInteger)x1 y1:(NSInteger)y1 x2:(NSInteger)x2 y2:(NSInteger)y2 color:(NSInteger)c {
    _VirtualDotMatrix->drawTriangle(x0, y0, x1, y1, x2, y2, c);
}

- (void) fillTriangle:(NSInteger)x0 y0:(NSInteger)y0 x1:(NSInteger)x1 y1:(NSInteger)y1 x2:(NSInteger)x2 y2:(NSInteger)y2 color:(NSInteger)c {
    _VirtualDotMatrix->fillTriangle(x0, y0, x1, y1, x2, y2, c);
}

- (void) drawRoundRect:(NSInteger)x0 y0:(NSInteger)y0 w:(NSInteger)w h:(NSInteger)h radius:(NSInteger)r color:(NSInteger)c {
    _VirtualDotMatrix->drawRoundRect(x0, y0, w, h, r, c);
}

- (void) fillRoundRect:(NSInteger)x0 y0:(NSInteger)y0 w:(NSInteger)w h:(NSInteger)h radius:(NSInteger)r color:(NSInteger) c {
    _VirtualDotMatrix->fillRoundRect(x0, y0, w, h, r, c);
}

- (void) drawBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const uint8_t [])bitmap w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->drawBitmap(x, y, bitmap, w, h, c);
}

- (void) drawBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const uint8_t [])bitmap w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c bg:(NSInteger)bg {
    _VirtualDotMatrix->drawBitmap(x, y, bitmap, w, h, c, bg);
}

- (void) drawBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(uint8_t *)bitmap w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->drawBitmap(x, y, bitmap, w, h, c);
}

- (void) drawBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(uint8_t *)bitmap w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c bg:(NSInteger)bg {
    _VirtualDotMatrix->drawBitmap(x, y, bitmap, w, h, c, bg);
}

- (void) drawXBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const uint8_t [])bitmap w:(NSInteger)w h:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->drawXBitmap(x, y, bitmap, w, h, c);
}

- (void) drawGrayscaleBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const uint8_t [])bitmap w:(NSInteger)w h:(NSInteger)h {
    _VirtualDotMatrix->drawGrayscaleBitmap(x, y, bitmap, w, h);
}

- (void) drawGrayscaleBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(uint8_t*)bitmap w:(NSInteger)w h:(NSInteger)h {
    _VirtualDotMatrix->drawGrayscaleBitmap(x, y, bitmap, w, h);
}

- (void) drawGrayscaleBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const uint8_t [])bitmap mask:(const uint8_t [])mask w:(NSInteger)w h:(NSInteger)h {
    _VirtualDotMatrix->drawGrayscaleBitmap(x, y, bitmap, mask, w, h);
}

- (void) drawGrayscaleBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(uint8_t*)bitmap mask:(uint8_t*)mask w:(NSInteger)w h:(NSInteger)h {
    _VirtualDotMatrix->drawGrayscaleBitmap(x, y, bitmap, mask, w, h);
}

- (void) drawRGBBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt16 [])bitmap w:(NSInteger)w h:(NSInteger)h {
    _VirtualDotMatrix->drawRGBBitmap(x, y, bitmap, w, h);
}

- (void) drawRGBBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(UInt16*)bitmap w:(NSInteger)w h:(NSInteger)h {
    _VirtualDotMatrix->drawRGBBitmap(x, y, bitmap, w, h);
}

- (void) drawRGBBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt16 [])bitmap mask:(const UInt8 [])mask w:(NSInteger)w h:(NSInteger)h {
    _VirtualDotMatrix->drawRGBBitmap(x, y, bitmap, mask, w, h);
}

- (void) drawRGBBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(UInt16*)bitmap mask:(UInt8*)mask w:(NSInteger)w h:(NSInteger)h {
    _VirtualDotMatrix->drawRGBBitmap(x, y, bitmap, mask, w, h);

}

- (void) drawChar:(NSInteger)x y:(NSInteger)y c:(unsigned char)c color:(NSInteger)color bg:(NSInteger)bg size:(NSInteger)size {
    _VirtualDotMatrix->drawChar(x, y, c, color, bg, size);
}

- (void) drawChar:(NSInteger)x y:(NSInteger)y c:(unsigned char)c color:(NSInteger)color bg:(NSInteger)bg sizeX:(NSInteger)size_x sizeY:(NSInteger)size_y {
    _VirtualDotMatrix->drawChar(x, y, c, color, bg, size_x, size_y);
}

- (void) getTextBoundsPtr:(const char *)str x:(NSInteger)x y:(NSInteger)y x1:(int16_t *)x1 y1:(int16_t *)y1 w:(uint16_t *)w h:(uint16_t *)h {
    _VirtualDotMatrix->getTextBounds(str, x, y, x1, y1, w, h);
}

//- (void) getTextBounds:(const String)str x:(NSInteger)x y:(NSInteger)y x1:(NSInteger *)x1 y1:(NSInteger *)y1 w:(NSInteger *)w h:(NSInteger *)h {
//    _VirtualDotMatrix->getTextBounds(str, x, y, x1, y1, w, h);
//}

- (void) setTextSize:(NSInteger)s {
    _VirtualDotMatrix->setTextSize(s);
}

- (void) setTextSizeXY:(NSInteger)sx sy:(NSInteger)sy {
    _VirtualDotMatrix->setTextSize(sx, sy);
}

- (void) setFont:(const GFXfont *)f {
    _VirtualDotMatrix->setFont(f);
}

- (void) setCursor:(NSInteger)w height:(NSInteger)h {
    _VirtualDotMatrix->setCursor(NSInteger(w), NSInteger(h));
}

- (void) setTextColor:(NSInteger)c {
    _VirtualDotMatrix->setTextColor(c);
}

- (void) setTextColor:(NSInteger)c bg:(NSInteger)bg {
    _VirtualDotMatrix->setTextColor(c, bg);
}

- (void) setTextWrap:(bool)w {
    _VirtualDotMatrix->setTextWrap(w);
}

- (void) cp437:(bool)x {
    _VirtualDotMatrix->cp437(x);
}

- (NSInteger) width {
    return _VirtualDotMatrix->width();
}

- (NSInteger) height {
    return _VirtualDotMatrix->height();
}

- (NSInteger) getRotation {
    return _VirtualDotMatrix->getRotation();
}

- (NSInteger) getCursorX {
    return _VirtualDotMatrix->getCursorX();
}

- (NSInteger) getCursorY {
    return _VirtualDotMatrix->getCursorY();
}

@end
