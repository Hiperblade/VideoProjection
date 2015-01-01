import processing.video.*;

boolean USE_KINECT = false; 

XML xml;
PFont font;
KeyboardMap map;
ImageMaskPool pool;
Palette palette;
IPoligon area;
 
void setup() {
  xml = loadXML(dataPath("config.xml"));
  XML[] children = xml.getChildren("poligon");
  if (children.length > 0) {
    int areaWidth = children[0].getInt("width");
    int areaHeight = children[0].getInt("height");
    String type = children[0].getString("type");
    String data = children[0].getString("data");
    float threshold = children[0].getFloat("threshold");
    if("3D".equals(type)) {
      area = new Poligon3D(areaWidth, areaHeight);
    } else if("2D".equals(type)) {
      area = new Poligon2D(areaWidth, areaHeight);
    } else {
      area = new PoligonNone(areaWidth, areaHeight);
    }
    area.load(data);
    
    map = new KeyboardMap();
    palette = new Palette();
    pool = new ImageMaskPool();
    pool.setThresholdMask(threshold);
    
    String key;
    children = xml.getChildren("palette");
    if (children.length > 0) {
      key = children[0].getString("resetkey");
      addResetPalette(key.charAt(0));
      
      children = children[0].getChildren("color");
      for (int i = 0; i < children.length; i++) {
        addToPalette(children[i].getString("key").charAt(0), children[i].getInt("red"), children[i].getInt("green"), children[i].getInt("blue"));
      }
    }
    
    children = xml.getChildren("pool");
    if (children.length > 0) {
      key = children[0].getString("resetkey");
      addResetPool(key.charAt(0));
      
      children = children[0].getChildren("movie");
      for (int i = 0; i < children.length; i++) {
        if(USE_KINECT) {
          addMovieToPool(children[i].getString("key").charAt(0), dataPath(children[i].getString("filename")), getKinectSource());
        } else {
          addMovieToPool(children[i].getString("key").charAt(0), dataPath(children[i].getString("filename")), getMaskSource());
        }
      }
    }
  }
  //Capture cam = new Capture(this, Capture.list()[0]);
  //cam.start();
  //im = new ImageMask(new CaptureSource(cam), new ImageSource(maskImage));
  
  background(0);
}

private void save() {
  XML[] children = xml.getChildren("poligon");
  if (children.length > 0) {
    children[0].setString("data", area.save());
    children[0].setString("threshold", "" + pool.getThresholdMask());
  }
  saveXML(xml, dataPath("config.xml"));
}

private void addResetPalette(char key) {
  map.add(key, "PALETTE", -1);
}

private void addToPalette(char key, int r, int g, int b) {
  map.add(key, "PALETTE", palette.add(r, g, b));
}

private void addResetPool(char key) {
  map.add(key, "POOL", -1);
}

private void addMovieToPool(char key, String filename, IImageMaskSource mask) {
  Movie video = new Movie(this, filename);
  video.loop();
  map.add(key, "POOL", pool.add(new MovieSource(video), mask));
}

void keyPressed() {
  KeyboardMapItem item = map.get(key);
  if(item != null)
  {
    if(item.Command == "PALETTE") {
      if(item.Attribute == -1) {
        palette.reset();
      } else {
        palette.setCurrent(item.Attribute);
      }
    } else if(item.Command == "POOL") {
      if(item.Attribute == -1) {
        pool.reset();
        background(0);
      } else {
        pool.setCurrent(item.Attribute);
      }
    }
  }
  
  // salvataggio configurazione
  if (key == CODED) {
    if (keyCode == 120) { //KeyEvent.VK_F9
      pool.setThresholdMask(pool.getThresholdMask() - 0.01);
    }
    else if (keyCode == 121) { //KeyEvent.VK_F10
      pool.setThresholdMask(pool.getThresholdMask() + 0.01);
    }
    else if (keyCode == 123) { //KeyEvent.VK_F12
      save();
    }
  }
  
  area.event("keyPressed");
}

void mouseClicked() {
  area.event("mouseClicked");
}

void mousePressed() {
  area.event("mousePressed"); 
}

void mouseDragged() {
  area.event("mouseDragged");
}

void mouseReleased() {
  area.event("mouseReleased");
}

void mouseWheel(MouseEvent event) {
  area.event("mouseWheel", "" + event.getCount());
}

void draw() {
  PImage tmp = pool.getImage();
  if(tmp != null) {
    background(0);
    palette.draw();
    area.draw(tmp);
  }
}
