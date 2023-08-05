//
//  VirtualDotMatrix.cpp
//  Flipper
//
//  Created by Tanner W. Stokes on 1/2/21.
//

#include "VirtualDotMatrix.hpp"

VirtualDotMatrix::VirtualDotMatrix(uint8_t mW, uint8_t mH)
    : Adafruit_GFX(mW, mH), matrixWidth(mW), matrixHeight(mH)
{
    buffer = new uint16_t[mW * mH];
}

void VirtualDotMatrix::start(const void *sb = NULL, DrawPixelCallback cb = NULL)
{
    if (cb != NULL) {
        drawPixelCallback = cb;
    }
    
    if (sb != NULL) {
        swiftBoard = sb;
    }
    
    // initialize the board buffer with all zeros
    fillScreen(0);
}

/*
    required implementation by gfx library for drawing
*/
void VirtualDotMatrix::drawPixel(int16_t x, int16_t y, uint16_t color)
{
    if (x < 0 || x >= matrixWidth ||
        y < 0 || y >= matrixHeight)
    {
        // out of bounds
        return;
    }

    buffer[y*matrixWidth + x] = color;

    if (drawPixelCallback != NULL && swiftBoard != NULL) {
        drawPixelCallback(x, y, color, swiftBoard);
    }
}

/*
    return pixel (x, y) from the buffer
*/
uint16_t VirtualDotMatrix::getPixel(int16_t x, int16_t y) {
    if (x < 0 || x >= matrixWidth ||
        y < 0 || y >= matrixHeight)
    {
        // out of bounds
        return 0;
    }
    
    // TODO this entire function may need to go if drawPixel writes via callback
    // the buffer is stored elsewhere
    // maybe it's nice to keep the buffer optional, though?
    return buffer[y*matrixWidth + x];

}
