import SimpleOpenNI.*;

SimpleOpenNI  kinect;

IImageMaskSource getKinectSource() {
  if(kinect == null) {
    kinect = new SimpleOpenNI(this);
    kinect.enableDepth();
  }
  
  return new DepthSource(kinect);
}

public class DepthSource implements IImageMaskSource
{
  private SimpleOpenNI source;
  
  public DepthSource(SimpleOpenNI source){
    this.source = source;
  }
  
  public boolean available(){
    return true;
  }
  
  public PImage getImage(){
    source.update();
    return source.depthImage();
  }
}
