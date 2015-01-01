public class Palette {
  private ArrayList<PaletteColor> data = new ArrayList<PaletteColor>();
  private int current = -1;
  
  public int add(int r, int g, int b) {
    data.add(new PaletteColor(r, g, b));
    return data.size() -1;
  }
  
  public void setCurrent(int index) {
    if(data.size() > index) {
      current = index;
    }
  }
  
  public void reset() {
    current = -1;
  }
  
  public void draw() {
    if(current > -1) {
      PaletteColor tintColor = data.get(current);
      tint(tintColor.R, tintColor.G, tintColor.B);
    } else {
      tint(255, 255, 255);
    }
  }
}

public class PaletteColor {
  public int R = 255;
  public int G = 255;
  public int B = 255;
  
  public PaletteColor(int r, int g, int b) {
    R = r;
    G = g;
    B = b;
  }
}
