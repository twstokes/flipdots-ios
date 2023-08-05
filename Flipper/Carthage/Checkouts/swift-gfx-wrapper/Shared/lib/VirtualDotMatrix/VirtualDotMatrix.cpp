#include "VirtualDotMatrix.hpp"

VirtualDotMatrix::VirtualDotMatrix(int16_t mW, int16_t mH, bool useBuffer)
    : Adafruit_GFX(mW, mH), buffer(NULL), drawPixelCallback(NULL), swiftBoard(NULL) {
        if (useBuffer) {
            // initialize an internal pixel buffer
            buffer = new uint16_t[mW * mH];
        }
}

/*
    set the drawing callbacks (if provided) and fill the screen with black
*/
void VirtualDotMatrix::start(const void * sb = NULL, DrawPixelCallback cb = NULL)
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
    if (x < 0 || x >= width() ||
        y < 0 || y >= height())
    {
        // out of bounds
        return;
    }

    // using a buffer can impact performance positively by doing quick lookups
    if (buffer != NULL) {
        if (buffer[y*width() + x] == color) {
            // nothing changed, early return
            return;
        }

        buffer[y*width() + x] = color;
    }

    if (drawPixelCallback != NULL && swiftBoard != NULL) {
        drawPixelCallback(x, y, color, swiftBoard);
    }
}

/*
    return pixel (x, y) from the buffer
 
    this will return 0 if a buffer isn't available
*/
uint16_t VirtualDotMatrix::getPixel(int16_t x, int16_t y) {
    // we're not using the buffer, so there's nothing to return
    if (buffer == NULL) {
        return 0;
    }

    if (x < 0 || x >= width() ||
        y < 0 || y >= height())
    {
        // out of bounds
        return 0;
    }

    return buffer[y*width() + x];
}
