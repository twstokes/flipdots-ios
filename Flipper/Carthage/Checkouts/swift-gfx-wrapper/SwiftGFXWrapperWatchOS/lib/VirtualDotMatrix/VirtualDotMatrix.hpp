//
//  VirtualDotMatrix.hpp
//  Flipper
//
//  Created by Tanner W. Stokes on 1/2/21.
//

#include "Adafruit_GFX.h"

#ifndef VirtualDotMatrix_hpp
#define VirtualDotMatrix_hpp

#include <stdio.h>

#endif /* VirtualDotMatrix_hpp */

typedef void (*DrawPixelCallback)(int16_t x, int16_t y, uint16_t color, const void *);

class VirtualDotMatrix : public Adafruit_GFX
{
public:
    VirtualDotMatrix(uint8_t matrixW, uint8_t matrixH);

    void start(const void *sb, DrawPixelCallback cb);
    void drawPixel(int16_t x, int16_t y, uint16_t color);
    uint16_t getPixel(int16_t x, int16_t y);

private:
    uint16_t *buffer;
    DrawPixelCallback drawPixelCallback;
    const void *swiftBoard;
    const uint8_t matrixWidth, matrixHeight;
};
