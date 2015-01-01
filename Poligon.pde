public class Point {
  public int x;
  public int y;
}

public interface IPoligon {
  void event(String eventId);
  void event(String eventId, String value);
  void draw(PImage img);
  void load(String data);
  String save();
}

public class PoligonNone implements IPoligon {
  
  public PoligonNone(int width, int height) {
    size(width, height);
  }
  
   public void event(String eventId) {
  }
  
  public void event(String eventId, String value) {
  }
  
  public void draw(PImage img) {
    image(img, 0, 0);
  }
  
  public void load(String data) {
  }
  
  public String save() {
    return "";
  }
}

public class Poligon2D implements IPoligon {
  private Point tL = new Point();
  private Point tR = new Point();
  private Point bR = new Point();
  private Point bL = new Point();
  
  private int editVertex = 0;
  
  public Poligon2D(int width, int height) {
    size(width, height, P2D);
    
    tR.x = width - 1;
    bR.x = width - 1;
    bR.y = height - 1;
    bL.y = height - 1;
  }
  
  private void keyPressed() {
    editVertex = 0;
    if (key == CODED) {
      if (keyCode == 112) { //KeyEvent.VK_F1
        editVertex = 5;
      } else if (keyCode == 113) { //KeyEvent.VK_F2
        editVertex = 1;
      } else if (keyCode == 114) { //KeyEvent.VK_F3
        editVertex = 2;
      } else if (keyCode == 115) { //KeyEvent.VK_F4
        editVertex = 3;
      } else if (keyCode == 116) { //KeyEvent.VK_F5
        editVertex = 4;
      }
    }
  }
  
  private void mouseClicked() {
    switch(editVertex) {
      case 1:
        tL.x = mouseX;
        tL.y = mouseY;
        break;
      case 2:
        tR.x = mouseX;
        tR.y = mouseY;
        break;
      case 3:
        bR.x = mouseX;
        bR.y = mouseY;
        break;
      case 4:
        bL.x = mouseX;
        bL.y = mouseY;
        break;
    }
  }
  
  private String getState() {
    switch(editVertex) {
      case 1:
        return " EDIT: Top Left Corner";
      case 2:
        return " EDIT: Top Right Corner";
      case 3:
        return " EDIT: Bottom Left Corner";
      case 4:
        return " EDIT: Bottom Right Corner";
      case 5:
        return " --- HELP ---\n F1: Top Left Corner\n F2: Top Right Corner\n F3: Bottom Left Corner\n F4: Bottom Right Corner";
      default:
        return null;
    }
  }
  
  private void drawBorder() {
    beginShape();
    noFill();
    strokeWeight(2);
    stroke(255, 0, 0);
    vertex(tL.x, tL.y);
    vertex(tR.x, tR.y);
    vertex(bR.x, bR.y);
    vertex(bL.x, bL.y);
    endShape(CLOSE);
    
    fill(255, 0, 0);
    text(getState(), 10, 20);
  }
  
  public void event(String eventId) {
        event(eventId, null);
  }
  
  public void event(String eventId, String value) {
    if(eventId == "keyPressed") {
      keyPressed();
    } else if(eventId == "mouseClicked") {
      mouseClicked();
    }
  }
  
  public void draw(PImage img) {
    beginShape();
    strokeWeight(0);  
    texture(img);
    vertex(tL.x, tL.y, 0, 0);
    vertex(tR.x, tR.y, img.width, 0);
    vertex(bR.x, bR.y, img.width, img.height);
    vertex(bL.x, bL.y, 0, img.height);  
    endShape();
    
    if(editVertex > 0) {
      drawBorder();
    }
  }
  
  public void load(String data) {
    if((data != null) && (!"".equals(data))) {
      String[] list = split(data, ';');
      tL.x = int(list[0]);
      tL.y = int(list[1]);
      tR.x = int(list[2]);
      tR.y = int(list[3]);
      bR.x = int(list[4]);
      bR.y = int(list[5]);
      bL.x = int(list[6]);
      bL.y = int(list[7]);
    }
  }
  
  public String save() {
    return tL.x + ";" + tL.y + ";" + tR.x + ";" + tR.y + ";" + bR.x + ";" + bR.y + ";" + bL.x + ";" + bL.y;
  }
}

public class Poligon3D implements IPoligon {
  private float rotationX = 0;
  private float rotationY = 0;
  private float rotationZ = 0;
  private float zoom = 1;
  
  private int editAsse = 0;
  private boolean locked = false;
  private int xOffset;
  private int yOffset;
  
  public Poligon3D(int width, int height) {
    size(width, height, P3D);
  }
  
  private void keyPressed() {
    editAsse = 0;
    if (key == CODED) {
      if (keyCode == 112) { //KeyEvent.VK_F1
        editAsse = 5; // help
      } else if (keyCode == 113) { //KeyEvent.VK_F2
        editAsse = 1; // x
      } else if (keyCode == 114) { //KeyEvent.VK_F3
        editAsse = 2; // y
      } else if (keyCode == 115) { //KeyEvent.VK_F4
        editAsse = 3; // z
      } else if (keyCode == 116) { //KeyEvent.VK_F5
        editAsse = 4;
      }
    }
  }
  
  private void mousePressed() {
    locked = true; 
    xOffset = mouseX; 
    yOffset = mouseY; 
  }
  
  private void mouseDragged() {
    if(locked) {
      int deltaY = int((mouseY - yOffset) / 5);
      int deltaX = int((mouseX - xOffset) / 5);
      
      switch(editAsse) {
        case 1:
          if(deltaY > 0) {
            rotationX += 0.001;
          } else if(deltaY < 0) {
            rotationX -= 0.001;
          }
          break;
        case 2:
          if(deltaX > 0) {
            rotationY += 0.001;
          } else if(deltaX < 0) {
            rotationY -= 0.001;
          }
          break;
        case 3:
          if(deltaY > 0) {
            rotationZ += 0.001;
          } else if(deltaY < 0) {
            rotationZ -= 0.001;
          }
          break;
      }
    }
  }
  
  private void mouseReleased() {
    locked = false;
  }
  
  private void mouseWheel(String value){
    if(editAsse == 4) {
      if(int(value) == 1) {
        zoom += 0.01;
      } else {
        zoom -= 0.01;
      }
    }
  }
  
  private String getState() {
    switch(editAsse) {
      case 1:
        return " EDIT: Asse X";
      case 2:
        return " EDIT: Asse Y";
      case 3:
        return " EDIT: Rotation";
      case 4:
        return " EDIT: Zoom";
      case 5:
        return " --- HELP ---\n F1: Asse X\n F2: Asse Y\n F3: Rotation\n F4: Zoom";
      default:
        return null;
    }
  }
  
  private void drawBorder() {
    beginShape();
    noFill();
    strokeWeight(2);
    stroke(255, 0, 0);
    vertex(-(width/2), -(height/2));
    vertex((width/2), -(height/2));
    vertex((width/2), (height/2));
    vertex(-(width/2), (height/2));
    endShape(CLOSE);
    fill(255, 0, 0);
    text(getState(), -(width/2) + 10, -(height/2) + 20);
  }
  
  public void event(String eventId) {
    event(eventId, null);
  }
  
  public void event(String eventId, String value) {
    if(eventId == "keyPressed") {
      keyPressed();
    } else if(eventId == "mousePressed") {
      mousePressed();
    } else if(eventId == "mouseDragged") {
      mouseDragged();
    } else if(eventId == "mouseReleased") {
      mouseReleased();
    } else if(eventId == "mouseWheel") {
      mouseWheel(value);
    }
  }
  
  public void draw(PImage img) {
    translate(width / 2, height / 2);
    scale(zoom);
    rotateX(PI * rotationX);
    rotateY(PI * rotationY);
    rotateZ(PI * rotationZ);
    beginShape();
    strokeWeight(0);
    texture(img);
    vertex(-(width/2), -(height/2), 0, 0, 0);
    vertex((width/2), -(height/2), 0, img.width, 0);
    vertex((width/2), (height/2), 0, img.width, img.height);
    vertex(-(width/2), (height/2), 0, 0, img.height);
    endShape();
    if(editAsse > 0) {
      drawBorder();
    }
  }
  
  public void load(String data) {
    if((data != null) && (!"".equals(data))) {
      String[] list = split(data, ';');
      rotationX = float(list[0]);
      rotationY = float(list[1]);
      rotationZ = float(list[2]);
      zoom = float(list[3]);
    }
  }
  
  public String save() {
    return rotationX + ";" + rotationY + ";" + rotationZ + ";" + zoom;
  }
}
