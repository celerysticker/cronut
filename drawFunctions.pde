void reset() {
  background(bg);
  styleReset();
}
  
void styleReset() {
  noFill();
  noStroke();
  textAlign(LEFT, CENTER);
}

void drawTrendLine(int index) {
  float previousX = -1;
  float previousY = -1;
  strokeWeight(2);
  stroke(trends[index].getColor());
  fill(trends[index].getColor());
  
  float minTrendX = minX;
  float maxTrendX = maxX;
  
  boolean highlighted = false;
  float highlightX = -1;
  for (int year = 0; year < nyears; year++) {
    for (int month = 1; month < 13; month++) {
      float x = map(year * 12 + month, 0,nyears * 12, minTrendX,maxTrendX);
      float y = axisY - trendPts[index][year][month];
      
      // mouse interactions
      if (abs(x - mouseX) < 5) {
        highlightX = x;
        if (abs(y - mouseY) < 5) {
          trends[index].highlighted = true;
          highlighted = true;
        }
      }
      
      ellipse(x, y, 1, 1);
      if (previousX >= 0) {
        line(previousX, previousY, x, y);
      }
      previousX = x;
      previousY = y;
    }
  }
  
  if (!highlighted) { // no points are highlighted, so entire trend is not highlighted
    trends[index].highlighted = false;
  }
  
  // draw vertical line
  if (highlightX > 0) {
    stroke(white, 50);
    strokeWeight(2);
    line(highlightX, minY, highlightX, maxY);
    styleReset();
  }
  
  // click interactions
  if (mousePressed && mouseButton == LEFT) {
    for (int i = 0; i < ntrends; i++) {
      if (trends[i].isHighlighted()) {
        currTrend = i;
        break;
      }
    }
  }
  
}

void drawTrend(int index) {
  int highlighted = 0;
  int year = -1;
  int month = -1;
  float highlightX = -1;
  
  for (int i = 0; i < nreviews[index]; i++) {
    float radius = 10;
    color dotColor = color(trends[index].getOC(), 30f);
    float x = reviews[index][i].x;
    float y = reviews[index][i].y;
     
     // mouse interactions
     if (abs(x - mouseX) < 5) {
       //stroke(255, 50, 130, 200);
       highlighted++;
       year = reviews[index][i].year;
       month = reviews[index][i].month;
       highlightX = x;
       if (abs(y - mouseY) < 1) { // mouseover some dot
         radius = 15;
         dotColor = highlightColor;
         highlightBID = reviews[index][i].business_id;
         highlightUID = reviews[index][i].user_id;
       }
     }
     
     // highlight business
     if (reviews[index][i].business_id.equals(highlightBID)) {
       dotColor = highlightColor;
     }
     // highlight user
     if (reviews[index][i].user_id.equals(highlightUID)) {
        stroke(highlightColor2);
        strokeWeight(2);
     }
     // draw dot
     fill(dotColor);
     ellipse(x, y, radius, radius);
     styleReset(); //reset
  }
  
  if (highlighted == 0) {
    highlightBID = "";
    highlightUID = "";
  }
  
  // draw vertical line
  if (highlightX > 0) {
    stroke(white);
    line(highlightX, 10, highlightX, maxY);
  }
  
  // write details
  fill(255);
  if (month > 0 && year > 0) {
    textAlign(LEFT, BOTTOM);
    text(intToMonth(month) + " " + year + "\n" + highlighted + " reviews" +  "\n" 
    //+ highlightBID, highlightX, height - 30);
    + getBName(highlightBID), highlightX + 5, 50);
  }
  
  // click interactions
  if (mousePressed && mouseButton == LEFT) {
    if (highlightBID != null && getBName(highlightBID) != "") {
      selectedBs.add(highlightBID);
    }
  }
  if (mousePressed && mouseButton == RIGHT) {
    trendview = true;
    currTrend = -1;
  }
  
  // businesses on the side
  drawLegend(highlightBID, highlightUID);
  displayBs();
  
  // "compare businesses" button
  if (drawCompareButton(maxX + marginX / 2, maxY, "Compare Businesses", color(255))) {
    trendview = false;
    dotview = false;
    compareview = true;
  }
}

void drawCompare() {
  drawBusiness(1, 75, 100);
  drawBusiness(2, 300, 100);
  if (drawDotButton(maxX + marginX / 2, minY, "Back", color(255))) {
    trendview = false;
    dotview = true;
    compareview = false;
  }
}

void drawAxes() {
  stroke(white);
  fill(white);
  // draw axes
  float minTrendX = minX;
  float maxTrendX = maxX;
  line(minTrendX, axisY, maxTrendX, axisY);
  
  // axis labels
  text("2011", map(0, 0,5, minTrendX,maxTrendX), axisY + 15);
  text("2012", map(1, 0,5, minTrendX,maxTrendX), axisY + 15);
  text("2013", map(2, 0,5, minTrendX,maxTrendX), axisY + 15);
  text("2014", map(3, 0,5, minTrendX,maxTrendX), axisY + 15);
  text("2015", map(4, 0,5, minTrendX,maxTrendX), axisY + 15);
  text("2016", map(5, 0,5, minTrendX,maxTrendX), axisY + 15);
  
  styleReset();
}

boolean drawCompareButton(float x, float y, String label, color c) {
  noStroke();
  float w = 130;
  float h = 30;
  color textCol = color(50);
  color buttonCol = c;
  boolean id = false;
  
  // mouse interactions
  if ((mouseX >= x && mouseX <= x + w) && (mouseY >= y && mouseY <= y + h)) {
    buttonCol = highlightColor;
    textCol = c;
    if (mousePressed) {
      id = true;
    }
  }
  
  // button itself
  fill(buttonCol);
  //ellipse(x, y + h/2, h, h);
  //ellipse(x + w, y + h/2, h, h);
  rect(x, y, w, h);
  
  // text
  fill(textCol);
  textAlign(CENTER, CENTER);
  text(label, x + w/2, y + h/2 - 1);
  
  float xX = x + w;
  // mouse interactions
  if ((mouseX >= xX && mouseX <= xX + h) && (mouseY >= y && mouseY <= y + h)) {
    buttonCol = highlightColor;
    textCol = c;
    if (mousePressed) {
      print("click\n");
    }
  }
  
  styleReset();
  return id;
}

boolean drawDotButton(float x, float y, String label, color c) {
  noStroke();
  float w = 100;
  float h = 30;
  color textCol = color(50);
  color buttonCol = c;
  boolean id = false;
  
  // mouse interactions
  if ((mouseX >= x && mouseX <= x + w) && (mouseY >= y && mouseY <= y + h)) {
    buttonCol = highlightColor;
    textCol = c;
    if (mousePressed) {
      id = true;
    }
  }
  
  // button itself
  fill(buttonCol);
  rect(x, y, w, h);
  
  // text
  fill(textCol);
  textAlign(CENTER, CENTER);
  text(label, x + w/2, y + h/2 - 1);
  
  float xX = x + w;
  // mouse interactions
  if ((mouseX >= xX && mouseX <= xX + h) && (mouseY >= y && mouseY <= y + h)) {
    buttonCol = highlightColor;
    textCol = c;
    if (mousePressed) {
      highlightBID = null;
      selectedBs = new HashSet<String>();
      print("hi\n");
      print(selectedBs);
    }
  }
  
  styleReset();
  return id;
}

void drawSearchButton(float x, float y, String label, color c, int index) {
  noStroke();
  float w = 90;
  float h = 30;
  color textCol = color(50);
  color buttonCol = c;
  
  // button itself
  fill(buttonCol);
  //ellipse(x, y + h/2, h, h);
  //ellipse(x + w, y + h/2, h, h);
  rect(x, y, w, h);
  
  // text
  fill(textCol);
  textAlign(CENTER, CENTER);
  text(label, x + w/2, y + h/2 - 1);
  
  float xX = x + w;
  // mouse interactions
  if ((mouseX >= xX && mouseX <= xX + h) && (mouseY >= y && mouseY <= y + h)) {
    buttonCol = highlightColor;
    textCol = c;
    if (mousePressed) {
      showTrend[index] = false; // toggle button
    }
  }
  
  // "X" button
  fill(buttonCol);
  rect(xX, y, h, h);
  fill(textCol);
  text("X", xX + h/2, y + h/2 - 1);
  
  styleReset();
}

void drawSearchBar(float x, float y, String label, color c) {
    noStroke();
  float w = 400;
  float h = 30;
  color textCol = color(50);
  color buttonCol = c;
  
  // button itself
  fill(buttonCol);
  //ellipse(x, y + h/2, h, h);
  //ellipse(x + w, y + h/2, h, h);
  rect(x, y, w, h);
  
  // text
  fill(textCol);
  textAlign(LEFT, CENTER);
  text(label, x + 10, y + h/2 - 1);
  
  float xX = x + w;
  // mouse interactions
  if ((mouseX >= xX && mouseX <= xX + h) && (mouseY >= y && mouseY <= y + h)) {
    buttonCol = highlightColor;
    textCol = c;
    if (mousePressed) {
      //
    }
  }
  
  styleReset();
}

void drawLabel(float x, float y, String label, color c, String bid) {
    noStroke();
  float w = 90;
  float h = 30;
  color textCol = color(50);
  color buttonCol = c;
  
  // button itself
  fill(buttonCol);
  //ellipse(x, y + h/2, h, h);
  //ellipse(x + w, y + h/2, h, h);
  rect(x, y, w, h);
  
  // text
  fill(textCol);
  textAlign(CENTER, CENTER);
  text(label, x + w/2, y + h/2 - 1);
  
  
  float xX = x + w;
  // mouse interactions
  if ((mouseX >= xX && mouseX <= xX + h) && (mouseY >= y && mouseY <= y + h)) {
    buttonCol = textCol;
    textCol = c;
    removeBID = bid;
    if (mousePressed) {
       //
    }
  }
  else if (removeBID == bid) { // not highlighted but previously set removeBID
    removeBID = null;
  }
  
  // "X" button
  fill(buttonCol);
  rect(xX, y, h, h);
  fill(textCol);
  text("X", xX + h/2, y + h/2 - 1);
  
  styleReset();
}

void displayBs(){
  int offset = 50;
  for (String bid : selectedBs) {
    // text(getBName(bid), maxX + marginX / 2, 100 + offset);
    drawLabel(maxX + marginX / 2, 100 + offset, getBName(bid), highlightColor, bid);
    offset += 50;
  }
}

void drawLegend(String bid, String uid) {
  noStroke();
  fill(highlightColor);
  ellipse(maxX + marginX / 2, 75, 10, 10);
  noFill();
  stroke(highlightColor2);
  strokeWeight(2);
  ellipse(maxX + marginX / 2, 90, 10, 10);
  fill(color(255));
  styleReset();
  text("Click to add business", maxX + marginX / 2, 120);
  text("Business: " + getBName(bid), maxX + marginX / 2 + 12, 73.5);
  text("Reviewer: " + getUName(uid), maxX + marginX / 2 + 12, 88.5);
  styleReset();
}