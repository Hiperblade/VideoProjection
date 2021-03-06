public interface IImageMaskSource
{
  boolean available();
  PImage getImage();
}

public class ImageMask {
  private IImageMaskSource image;
  private IImageMaskSource mask;
  private float thresholdMask;
  
  public ImageMask(IImageMaskSource image, IImageMaskSource mask){
    this(image, mask, 1);
  }
  
  public ImageMask(IImageMaskSource image, IImageMaskSource mask, float thresholdMask){
    this.image = image;
    this.mask = mask;
    this.thresholdMask = thresholdMask;
  }
  
  protected PImage cropImage(PImage baseImage, PImage maskImage){
    maskImage.filter(THRESHOLD, thresholdMask);
    baseImage.resize(maskImage.width, maskImage.height);
    baseImage.mask(maskImage);
    return baseImage;
  }
  
  public PImage getImage() {
    PImage tmp = null;
    if (image.available() && mask.available()) {
      tmp = cropImage(image.getImage(), mask.getImage());
    }
    return tmp;
  }
  
  public void setThresholdMask(float value) {
    thresholdMask = value;
  }
}

public class ImageSource implements IImageMaskSource
{
  private PImage source;
  
  public ImageSource(PImage source){
    this.source = source;
  }
  
  public boolean available(){
    return true;
  }
  
  public PImage getImage(){
    return source;
  }
}

public class MovieSource implements IImageMaskSource
{
  private Movie source;
  
  public MovieSource(Movie source){
    this.source = source;
  }
  
  public boolean available(){
    return source.available();
  }
  
  public PImage getImage(){
    source.read();
    return source;
  }
}

public class CaptureSource implements IImageMaskSource
{
  private Capture source;
  
  public CaptureSource(Capture source){
    this.source = source;
  }
  
  public boolean available(){
    return source.available();
  }
  
  public PImage getImage(){
    source.read();
    return source;
  }
}
