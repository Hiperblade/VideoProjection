public class ImageMaskPool {
  private ArrayList<ImageMask> pool = new ArrayList<ImageMask>();
  private int current = -1;
  private float thresholdMask = 1;
  
  public ImageMaskPool() {
  }
  
  public int add(ImageMask im) {
    pool.add(im);
    return pool.size() -1;
  }
  
  public int add(IImageMaskSource image, IImageMaskSource mask) {
    return add(new ImageMask(image, mask, thresholdMask));
  }
  
  public float getThresholdMask() {
    return thresholdMask;
  }
  
  public void setThresholdMask(float value) {
    if(value < 0) {
      value = 0;
    } else if (value > 1) {
      value = 1;
    }
    
    if(thresholdMask != value)
    {
      thresholdMask = value;
      
      for(ImageMask im : pool) {
        im.setThresholdMask(thresholdMask);
      }
    }
  }
  
  public void setCurrent(int index) {
    if(pool.size() > index) {
      current = index;
    }
  }
  
  public void reset() {
    current = -1;
  }
  
  public PImage getImage() {
    if(current > -1) {
      return pool.get(current).getImage();
    }
    return null;
  }
}

