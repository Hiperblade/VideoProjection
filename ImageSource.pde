IImageMaskSource getMaskSource() {
  PImage maskImage = loadImage(dataPath("mask.jpg"));
  
  return new ImageSource(maskImage);
}
