class trend {
  String name;
  String filename;
  color cl;
  boolean highlighted;
  
  trend(String n, String f, color c) {
    name = n;
    filename = f;
    cl = c;
    highlighted = false;
  }
  
  color getColor() {
    if (highlighted) {
      return highlightColor;
    }
    return cl;
  }
  
  color getOC() { // original, non-highlighted color
    return cl;
  }
  
  boolean isHighlighted() {
    return highlighted;
  }
  
}