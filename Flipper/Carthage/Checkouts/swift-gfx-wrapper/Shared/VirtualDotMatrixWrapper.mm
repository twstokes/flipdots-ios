#import <Foundation/Foundation.h>

#import "VirtualDotMatrix.hpp"
#import "VirtualDotMatrixWrapper.h"


@implementation VirtualDotMatrixWrapper
{
    VirtualDotMatrix * _VirtualDotMatrix;
}


/// Initialize a matrix with no internal buffer.
/// @param w Width of matrix.
/// @param h Height of matrix.
-(id)init:(NSInteger)w height:(NSInteger)h {
    self = [super init];
    if (self) {
        _VirtualDotMatrix = new VirtualDotMatrix(w, h, false);
    }
    return self;
}


/// Initialize a matrix.
/// @param w Width of matrix.
/// @param h Height of matrix.
/// @param b Use a pixel buffer.
-(id)init:(NSInteger)w height:(NSInteger)h useBuffer:(BOOL)b {
    self = [super init];
    if (self) {
        _VirtualDotMatrix = new VirtualDotMatrix(w, h, b);
    }
    return self;
}


/// Assigns a new matrix.
/// @param newVal New matrix.
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


/// Start the matrix.
/// @param selfPtr A pointer to the bridged Swift object.
/// @param drawPixelCallback An optional pointer to a callback to fire when drawing an individual pixel.
- (void) start:(const void *)selfPtr drawPixelCallback:(const void (short, short, unsigned short, const void *))drawPixelCallback {
    _VirtualDotMatrix->start(selfPtr, drawPixelCallback);
}


/// Draws a pixel on the matrix.
/// @param x X coordinate.
/// @param y Y coordinate.
/// @param c 16-bit 5-6-5 color.
- (void) drawPixel:(NSInteger)x y:(NSInteger)y color:(NSInteger)c {
    _VirtualDotMatrix->drawPixel(int16_t(x), int16_t(y), uint16_t(c));
}


/// Gets pixel at specified coordinates.
/// @param x X coordinate.
/// @param y Y coordinate.
- (NSInteger) getPixel:(NSInteger)x y:(NSInteger)y {
    return _VirtualDotMatrix->getPixel(int16_t(x), int16_t(y));
}


/// Print helper for write function.
- (void) print:(NSString *)s {
    _VirtualDotMatrix->print(s.UTF8String);
}


/// Set rotation setting for display.
/// @param r  0 through 3 corresponding to 4 cardinal rotations.
- (void) setRotation:(NSInteger)r {
    _VirtualDotMatrix->setRotation(uint8_t(r));
}


/// Invert the display.
/// @param i True if you want to invert, false to make 'normal'.
- (void) invertDisplay:(bool)i {
    _VirtualDotMatrix->invertDisplay(i);
}


/// Speed optimized vertical line drawing.
/// @param x Line horizontal start point.
/// @param y Line vertical start point.
/// @param h Length of vertical line to be drawn, including first point.
/// @param c Color to fill with.
- (void) drawFastVLine:(NSInteger)x y:(NSInteger)y height:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->drawFastVLine(x, y, h, c);
}


/// Speed optimized horizontal line drawing.
/// @param x Line horizontal start point.
/// @param y Line vertical start point.
/// @param w Length of horizontal line to be drawn, including 1st point.
/// @param c Color 16-bit 5-6-5 Color to draw line with.
- (void) drawFastHLine:(NSInteger)x y:(NSInteger)y width:(NSInteger)w color:(NSInteger)c {
    _VirtualDotMatrix->drawFastHLine(x, y, w, c);
}


/// Fill a rectangle completely with one color.
/// @param x Top left corner x coordinate.
/// @param y Top left corner y coordinate.
/// @param w Width in pixels.
/// @param h Height in pixels.
/// @param c 16-bit 5-6-5 Color to fill with.
- (void) fillRect:(NSInteger)x y:(NSInteger)y width:(NSInteger)w height:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->fillRect(x, y, w, h, c);
}


/// Fill the screen completely with one color.!
/// @param c 16-bit 5-6-5 Color to fill with.
- (void) fillScreen:(int)c {
    _VirtualDotMatrix->fillScreen(c);
}


/// Draw a line.
/// @param x0 Start point x coordinate.
/// @param y0 Start point y coordinate.
/// @param x1 End point x coordinate.
/// @param y1 End point y coordinate.
/// @param c 16-bit 5-6-5 Color to draw with.
- (void) drawLine:(NSInteger)x0 y0:(NSInteger)y0 x1:(NSInteger)x1 y1:(NSInteger)y1 color:(NSInteger)c {
    _VirtualDotMatrix->drawLine(x0, y0, x1, y1, c);
}


/// Draw a rectangle with no fill color.
/// @param x Top left corner x coordinate.
/// @param y Top left corner y coordinate.
/// @param w Width in pixels.
/// @param h Height in pixels.
/// @param c 16-bit 5-6-5 Color to draw with.
- (void) drawRect:(NSInteger)x y:(NSInteger)y width:(NSInteger)w height:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->drawRect(x, y, w, h, c);
}


/// Draw a circle outline.
/// @param x0 Center-point x coordinate.
/// @param y0 Center-point y coordinate.
/// @param r Radius of circle.
/// @param c 16-bit 5-6-5 Color to draw with.
- (void) drawCircle:(NSInteger)x0 y0:(NSInteger)y0 radius:(NSInteger)r color:(NSInteger)c {
    _VirtualDotMatrix->drawCircle(x0, y0, r, c);
}


/// Quarter-circle drawer, used to do circles and roundrects.
/// @param x0 Center-point x coordinate.
/// @param y0 Center-point y coordinate.
/// @param r Radius of circle.
/// @param cornername Mask bit #1 or bit #2 to indicate which quarters of the circle we're doing.
/// @param c 16-bit 5-6-5 Color to draw with.
- (void) drawCircleHelper:(NSInteger)x0 y0:(NSInteger)y0 radius:(NSInteger)r cornername:(NSInteger)cornername color:(NSInteger)c {
    _VirtualDotMatrix->drawCircleHelper(x0, y0, r, cornername, c);
}


/// Draw a circle with filled color.
/// @param x0 Center-point x coordinate.
/// @param y0 Center-point y coordinate.
/// @param r  Radius of circle.
/// @param c 16-bit 5-6-5 Color to fill with.
- (void) fillCircle:(NSInteger)x0 y0:(NSInteger)y0 radius:(NSInteger)r color:(NSInteger)c {
    _VirtualDotMatrix->fillCircle(x0, y0, r, c);
}


/// Quarter-circle drawer with fill, used for circles and roundrects.
/// @param x0 Center-point x coordinate.
/// @param y0 Center-point y coordinate.
/// @param r Radius of circle.
/// @param cornername Mask bits indicating which quarters we're doing.
/// @param delta  Offset from center-point, used for round-rects.
/// @param c 16-bit 5-6-5 Color to fill with.
- (void) fillCircleHelper:(NSInteger)x0 y0:(NSInteger)y0 radius:(NSInteger)r cornername:(NSInteger)cornername delta:(NSInteger)delta color:(NSInteger)c {
    _VirtualDotMatrix->fillCircleHelper(x0, y0, r, cornername, delta, c);
}


/// Draw a triangle with no fill color.
/// @param x0 Vertex #0 x coordinate.
/// @param y0 Vertex #0 y coordinate.
/// @param x1 Vertex #1 x coordinate.
/// @param y1 Vertex #1 y coordinate.
/// @param x2 Vertex #2 x coordinate.
/// @param y2 Vertex #2 y coordinate.
/// @param c 16-bit 5-6-5 Color to draw with.
- (void) drawTriangle:(NSInteger)x0 y0:(NSInteger)y0 x1:(NSInteger)x1 y1:(NSInteger)y1 x2:(NSInteger)x2 y2:(NSInteger)y2 color:(NSInteger)c {
    _VirtualDotMatrix->drawTriangle(x0, y0, x1, y1, x2, y2, c);
}

- (void) fillTriangle:(NSInteger)x0 y0:(NSInteger)y0 x1:(NSInteger)x1 y1:(NSInteger)y1 x2:(NSInteger)x2 y2:(NSInteger)y2 color:(NSInteger)c {
    _VirtualDotMatrix->fillTriangle(x0, y0, x1, y1, x2, y2, c);
}

- (void) drawRoundRect:(NSInteger)x0 y0:(NSInteger)y0 width:(NSInteger)w height:(NSInteger)h radius:(NSInteger)r color:(NSInteger)c {
    _VirtualDotMatrix->drawRoundRect(x0, y0, w, h, r, c);
}

- (void) fillRoundRect:(NSInteger)x0 y0:(NSInteger)y0 width:(NSInteger)w height:(NSInteger)h radius:(NSInteger)r color:(NSInteger) c {
    _VirtualDotMatrix->fillRoundRect(x0, y0, w, h, r, c);
}

- (void) drawBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const uint8_t [])bitmap width:(NSInteger)w height:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->drawBitmap(x, y, bitmap, w, h, c);
}

- (void) drawBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const uint8_t [])bitmap width:(NSInteger)w height:(NSInteger)h color:(NSInteger)c bg:(NSInteger)bg {
    _VirtualDotMatrix->drawBitmap(x, y, bitmap, w, h, c, bg);
}

- (void) drawBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(uint8_t *)bitmap width:(NSInteger)w height:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->drawBitmap(x, y, bitmap, w, h, c);
}

- (void) drawBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(uint8_t *)bitmap width:(NSInteger)w height:(NSInteger)h color:(NSInteger)c bg:(NSInteger)bg {
    _VirtualDotMatrix->drawBitmap(x, y, bitmap, w, h, c, bg);
}

- (void) drawXBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const uint8_t [])bitmap width:(NSInteger)w height:(NSInteger)h color:(NSInteger)c {
    _VirtualDotMatrix->drawXBitmap(x, y, bitmap, w, h, c);
}

- (void) drawGrayscaleBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const uint8_t [])bitmap width:(NSInteger)w height:(NSInteger)h {
    _VirtualDotMatrix->drawGrayscaleBitmap(x, y, bitmap, w, h);
}

- (void) drawGrayscaleBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(uint8_t*)bitmap width:(NSInteger)w height:(NSInteger)h {
    _VirtualDotMatrix->drawGrayscaleBitmap(x, y, bitmap, w, h);
}

- (void) drawGrayscaleBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const uint8_t [])bitmap mask:(const uint8_t [])mask width:(NSInteger)w height:(NSInteger)h {
    _VirtualDotMatrix->drawGrayscaleBitmap(x, y, bitmap, mask, w, h);
}

- (void) drawGrayscaleBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(uint8_t*)bitmap mask:(uint8_t*)mask width:(NSInteger)w height:(NSInteger)h {
    _VirtualDotMatrix->drawGrayscaleBitmap(x, y, bitmap, mask, w, h);
}

- (void) drawRGBBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt16 [])bitmap width:(NSInteger)w height:(NSInteger)h {
    _VirtualDotMatrix->drawRGBBitmap(x, y, bitmap, w, h);
}

- (void) drawRGBBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(UInt16*)bitmap width:(NSInteger)w height:(NSInteger)h {
    _VirtualDotMatrix->drawRGBBitmap(x, y, bitmap, w, h);
}

- (void) drawRGBBitmap:(NSInteger)x y:(NSInteger)y bitmap:(const UInt16 [])bitmap mask:(const UInt8 [])mask width:(NSInteger)w height:(NSInteger)h {
    _VirtualDotMatrix->drawRGBBitmap(x, y, bitmap, mask, w, h);
}

- (void) drawRGBBitmapPtr:(NSInteger)x y:(NSInteger)y bitmap:(UInt16*)bitmap mask:(UInt8*)mask width:(NSInteger)w height:(NSInteger)h {
    _VirtualDotMatrix->drawRGBBitmap(x, y, bitmap, mask, w, h);

}

- (void) drawChar:(NSInteger)x y:(NSInteger)y c:(unsigned char)c color:(NSInteger)color background:(NSInteger)bg size:(NSInteger)size {
    _VirtualDotMatrix->drawChar(x, y, c, color, bg, size);
}

- (void) drawChar:(NSInteger)x y:(NSInteger)y c:(unsigned char)c color:(NSInteger)color background:(NSInteger)bg sizeX:(NSInteger)size_x sizeY:(NSInteger)size_y {
    _VirtualDotMatrix->drawChar(x, y, c, color, bg, size_x, size_y);
}

- (void) getTextBoundsPtr:(const char *)str x:(NSInteger)x y:(NSInteger)y x1:(int16_t *)x1 y1:(int16_t *)y1 width:(uint16_t *)w height:(uint16_t *)h {
    _VirtualDotMatrix->getTextBounds(str, x, y, x1, y1, w, h);
}

- (void) setTextSize:(NSInteger)s {
    _VirtualDotMatrix->setTextSize(s);
}

- (void) setTextSizeXY:(NSInteger)sx sy:(NSInteger)sy {
    _VirtualDotMatrix->setTextSize(sx, sy);
}

// a customized version of setFont to make things nicer in Swift
// because we have the advantage of not running on an MCU, we
// include all the fonts
- (void) setFont:(Font)f {
    const GFXfont * font;
    
    switch (f) {
        case FreeMono12pt7bFont:
            font = &FreeMono12pt7b;
            break;
        case FreeMono18pt7bFont:
            font = &FreeMono18pt7b;
            break;
        case FreeMono24pt7bFont:
            font = &FreeMono24pt7b;
            break;
        case FreeMono9pt7bFont:
            font = &FreeMono9pt7b;
            break;
        case FreeMonoBold12pt7bFont:
            font = &FreeMonoBold12pt7b;
            break;
        case FreeMonoBold18pt7bFont:
            font = &FreeMonoBold18pt7b;
            break;
        case FreeMonoBold24pt7bFont:
            font = &FreeMonoBold24pt7b;
            break;
        case FreeMonoBold9pt7bFont:
            font = &FreeMonoBold9pt7b;
            break;
        case FreeMonoBoldOblique12pt7bFont:
            font = &FreeMonoBoldOblique12pt7b;
            break;
        case FreeMonoBoldOblique18pt7bFont:
            font = &FreeMonoBoldOblique18pt7b;
            break;
        case FreeMonoBoldOblique24pt7bFont:
            font = &FreeMonoBoldOblique24pt7b;
            break;
        case FreeMonoBoldOblique9pt7bFont:
            font = &FreeMonoBoldOblique9pt7b;
            break;
        case FreeMonoOblique12pt7bFont:
            font = &FreeMonoOblique12pt7b;
            break;
        case FreeMonoOblique18pt7bFont:
            font = &FreeMonoOblique18pt7b;
            break;
        case FreeMonoOblique24pt7bFont:
            font = &FreeMonoOblique24pt7b;
            break;
        case FreeMonoOblique9pt7bFont:
            font = &FreeMonoOblique9pt7b;
            break;
        case FreeSans12pt7bFont:
            font = &FreeSans12pt7b;
            break;
        case FreeSans18pt7bFont:
            font = &FreeSans18pt7b;
            break;
        case FreeSans24pt7bFont:
            font = &FreeSans24pt7b;
            break;
        case FreeSans9pt7bFont:
            font = &FreeSans9pt7b;
            break;
        case FreeSansBold12pt7bFont:
            font = &FreeSansBold12pt7b;
            break;
        case FreeSansBold18pt7bFont:
            font = &FreeSansBold18pt7b;
            break;
        case FreeSansBold24pt7bFont:
            font = &FreeSansBold24pt7b;
            break;
        case FreeSansBold9pt7bFont:
            font = &FreeSansBold9pt7b;
            break;
        case FreeSansBoldOblique12pt7bFont:
            font = &FreeSansBoldOblique12pt7b;
            break;
        case FreeSansBoldOblique18pt7bFont:
            font = &FreeSansBoldOblique18pt7b;
            break;
        case FreeSansBoldOblique24pt7bFont:
            font = &FreeSansBoldOblique24pt7b;
            break;
        case FreeSansBoldOblique9pt7bFont:
            font = &FreeSansBoldOblique9pt7b;
            break;
        case FreeSansOblique12pt7bFont:
            font = &FreeSansOblique12pt7b;
            break;
        case FreeSansOblique18pt7bFont:
            font = &FreeSansOblique18pt7b;
            break;
        case FreeSansOblique24pt7bFont:
            font = &FreeSansOblique24pt7b;
            break;
        case FreeSansOblique9pt7bFont:
            font = &FreeSansOblique9pt7b;
            break;
        case FreeSerif12pt7bFont:
            font = &FreeSerif12pt7b;
            break;
        case FreeSerif18pt7bFont:
            font = &FreeSerif18pt7b;
            break;
        case FreeSerif24pt7bFont:
            font = &FreeSerif24pt7b;
            break;
        case FreeSerif9pt7bFont:
            font = &FreeSerif9pt7b;
            break;
        case FreeSerifBold12pt7bFont:
            font = &FreeSerifBold12pt7b;
            break;
        case FreeSerifBold18pt7bFont:
            font = &FreeSerifBold18pt7b;
            break;
        case FreeSerifBold24pt7bFont:
            font = &FreeSerifBold24pt7b;
            break;
        case FreeSerifBold9pt7bFont:
            font = &FreeSerifBold9pt7b;
            break;
        case FreeSerifBoldItalic12pt7bFont:
            font = &FreeSerifBoldItalic12pt7b;
            break;
        case FreeSerifBoldItalic18pt7bFont:
            font = &FreeSerifBoldItalic18pt7b;
            break;
        case FreeSerifBoldItalic24pt7bFont:
            font = &FreeSerifBoldItalic24pt7b;
            break;
        case FreeSerifBoldItalic9pt7bFont:
            font = &FreeSerifBoldItalic9pt7b;
            break;
        case FreeSerifItalic12pt7bFont:
            font = &FreeSerifItalic12pt7b;
            break;
        case FreeSerifItalic18pt7bFont:
            font = &FreeSerifItalic18pt7b;
            break;
        case FreeSerifItalic24pt7bFont:
            font = &FreeSerifItalic24pt7b;
            break;
        case FreeSerifItalic9pt7bFont:
            font = &FreeSerifItalic9pt7b;
            break;
        case Org_01Font:
            font = &Org_01;
            break;
        case PicopixelFont:
            font = &Picopixel;
            break;
        case Tiny3x3a2pt7bFont:
            font = &Tiny3x3a2pt7b;
            break;
        case TomThumbFont:
            font = &TomThumb;
            break;
        case DefaultFont:
        default:
            // clear the custom font and go back
            // to the default
            _VirtualDotMatrix->setFont(NULL);
            return;
    }
    
    _VirtualDotMatrix->setFont(font);
}

- (void) setCursor:(NSInteger)x y:(NSInteger)y {
    _VirtualDotMatrix->setCursor(NSInteger(x), NSInteger(y));
}

- (void) setTextColor:(NSInteger)c {
    _VirtualDotMatrix->setTextColor(c);
}

- (void) setTextColor:(NSInteger)c background:(NSInteger)bg {
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
