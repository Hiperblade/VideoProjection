public class ImageMaskPool {
  private ArrayList<ImageMask> pool = new ArrayList<ImageMask>();
  private int current = -1;
  
  public ImageMaskPool() {
  }
  
  public int add(ImageMask im) {
    pool.add(im);
    return pool.size() -1;
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

