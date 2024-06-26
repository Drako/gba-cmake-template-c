#include <tonc.h>

EWRAM_DATA COLOR image[M3_WIDTH*M3_HEIGHT];

int __attribute__((noreturn)) main(void)
{
  irq_init(NULL);
  irq_enable(II_VBLANK);
  REG_DISPCNT = DCNT_MODE3 | DCNT_BG2;

  VBlankIntrWait();
  m3_frame(10, M3_HEIGHT-12, M3_WIDTH-10, M3_HEIGHT-9, CLR_WHITE);
  VBlankIntrWait();

  for (int y = 0; y<M3_HEIGHT; ++y) {
    for (int x = 0; x<M3_WIDTH; ++x) {
      int const index = y*M3_WIDTH+x;
      image[index] = RGB15(x*31/M3_WIDTH, y*31/M3_HEIGHT, 0);
      int const progress = (index*(M3_WIDTH-22))/(M3_WIDTH*M3_HEIGHT);
      m3_plot(11+progress, M3_HEIGHT-11, CLR_RED);
    }
  }

  dma_cpy(vid_mem, image, M3_WIDTH*M3_HEIGHT, 3, DMA_16 | DMA_AT_VBLANK | DMA_ENABLE);

  for (;;) {
    VBlankIntrWait();
  }
}
