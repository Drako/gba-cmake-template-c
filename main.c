#include <gba.h>

EWRAM_DATA u16 image[SCREEN_WIDTH*SCREEN_HEIGHT];

int __attribute__((noreturn)) main(void)
{
  irqInit();
  irqEnable(IRQ_VBLANK);
  SetMode(MODE_3 | BG2_ENABLE);

  for (int y = 0; y<SCREEN_HEIGHT; ++y) {
    for (int x = 0; x<SCREEN_WIDTH; ++x) {
      int const index = y*SCREEN_WIDTH+x;
      image[index] = RGB5(x*31/SCREEN_WIDTH, y*31/SCREEN_HEIGHT, 0);
    }
  }

  DMA_Copy(3, image, VRAM, DMA_VBLANK | DMA16);

  for (;;) {
    VBlankIntrWait();
  }
}
