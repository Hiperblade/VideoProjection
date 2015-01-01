import java.util.Map;

public class KeyboardMap {
  private ArrayList<KeyboardMapItem> map;
  
  public KeyboardMap() {
    map = new ArrayList<KeyboardMapItem>();
  }
  
  public void add(char key, String command, int attribute) {
    map.add(new KeyboardMapItem(key, command, attribute));
  }
  
  public KeyboardMapItem get(char key) {
    for (KeyboardMapItem item : map) {
      if(item.Key == key) {
        return item;
      }
    }
    return null;
  }
}

public class KeyboardMapItem {
  public char Key;
  public String Command;
  public int Attribute;
  
  public KeyboardMapItem(char key, String command, int attribute) {
    Key = key;
    Command = command;
    Attribute = attribute;
  }
}
