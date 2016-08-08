//city,review_count,name,business_id,attributes.Price Range,state,stars,open
class business {
  String bid;
  String name;
  float stars;
  String city;
  
  business(TableRow t) {
    bid = t.getString("business_id");
    name = t.getString("name");
    stars = t.getFloat("stars");
    city = t.getString("city");
  }
}

String intToMonth(int month) {
  String monthString;
  switch (month) {
    case 1:  monthString = "January";
             break;
    case 2:  monthString = "February";
             break;
    case 3:  monthString = "March";
             break;
    case 4:  monthString = "April";
             break;
    case 5:  monthString = "May";
             break;
    case 6:  monthString = "June";
             break;
    case 7:  monthString = "July";
             break;
    case 8:  monthString = "August";
             break;
    case 9:  monthString = "September";
             break;
    case 10: monthString = "October";
             break;
    case 11: monthString = "November";
             break;
    case 12: monthString = "December";
             break;
    default: monthString = "Invalid month";
             break;
    }
    return monthString;
}

String getBName(String bid) {
  if (bid == null) {
    return "n/a";
  }
  business b = businesses.get(bid);
  if (b != null) {
    return b.name;
  }
  return "";
}

String getUName(String uid) {
  if (uid == null) {
    return "n/a";
  }
  return uid.substring(0, Math.min(uid.length(), 5));
}

void drawBusiness(int id, float x, float y) {
  float w = 200;
  float h = 300;
  float marginLeft = 10;
  float marginTop = 16;
  color fg = color(0);
  color bg = color(255);
  
  noStroke();
  fill(bg);
  rect(x, y, w, h);
  fill(fg);
  textAlign(LEFT, CENTER);
  
  // business name
  String bname = "KUNG FU TEA";
  if (id == 2) bname = "BREW TEA BAR";
  text(bname, x + marginLeft, y + marginTop);
  
  // rating
  fill(highlightColor);
  star(x + marginLeft + 10, y + marginTop + 22, 5, 10, 5);
  star(x + marginLeft + 30, y + marginTop + 22, 5, 10, 5);
  star(x + marginLeft + 50, y + marginTop + 22, 5, 10, 5);
  star(x + marginLeft + 70, y + marginTop + 22, 5, 10, 5);
  star(x + marginLeft + 90, y + marginTop + 22, 5, 10, 5);
  //text("*****", x + marginLeft, y + marginTop + 20);
  
  // price range
  fill(color(0));
  text("Price Range: $", x + marginLeft, y + marginTop + 45);
  
  // outdoor seating
  if (id == 1) text("Opened July 2014", x + marginLeft, y + marginTop + 65);
  else text("Opened July 2015", x + marginLeft, y + marginTop + 65);
  
  // neighborhood
  String hood = "Southwest";
  if (id == 2) hood = "Chinatown";
  text("Neighborhood: " + hood, x + marginLeft, y + marginTop + 85);
  
  // wi-fi
  text("Free Wi-fi", x + marginLeft, y + marginTop + 105);
  
  // outdoor seating
  if (id == 1) text("Outdoor Seating", x + marginLeft, y + marginTop + 125);
}

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}