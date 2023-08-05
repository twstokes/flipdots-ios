#ifndef VirtualDotMatrix_hpp
#define VirtualDotMatrix_hpp

#include "Adafruit_GFX.h"
#include <stdio.h>

/*
On an Arduino, the fonts use the PROGMEM modifer to
put them into flash memory instead of SRAM.

Since we're on another platform with no concept of
PROGMEM, we're blanking it out so we don't have to change
the font sources.
*/
#define PROGMEM

typedef const void (*DrawPixelCallback)(int16_t x, int16_t y, uint16_t color, const void *);

class VirtualDotMatrix : public Adafruit_GFX
{
public:
    VirtualDotMatrix(int16_t matrixW, int16_t matrixH, bool useBuffer);

    void start(const void *sb, DrawPixelCallback cb);
    void drawPixel(int16_t x, int16_t y, uint16_t color);
    uint16_t getPixel(int16_t x, int16_t y);

private:
    uint16_t *buffer;
    DrawPixelCallback drawPixelCallback;
    const void *swiftBoard;
};

#endif /* VirtualDotMatrix_hpp */
