import java.util.HashSet;

// data
int ntrends = 5;
trend[] trends;
boolean[] highlightTrend;
Table data;
int[] nreviews;
review[][] reviews;
int nyears = 5;
int[][][] trendPts;
int currTrend = -1;
String highlightBID = "";
String highlightUID = "";
boolean[] showTrend;
HashSet<String> selectedBs;
HashMap<String, business> businesses;
String removeBID = null;

// values
boolean trendview = true;
boolean compareview = false;
boolean dotview = false;
float marginX = 100;
float marginY = 100;
float minX = marginX;
float maxX = 0;
float minY = marginY;
float maxY = 0;
float axisY = 500;

// colors
color bg = color(100);
color white = color(255, 130);
color boba = color(135, 204, 105);
color cronut = color(255, 255, 157);
color pumpkin = color(190, 235, 159);
color berry = color(121, 189, 143);
color mint = color(0, 163, 136);
color highlightColor = color(255, 97, 56);
color highlightColor2 = color(228, 221, 255);

void setup() {
  size(1100,600);
  maxX = width - 2 * marginX;
  maxY = height - marginY;
  //boba = highlightColor;
  trends = new trend[] {new trend("BOBA", "reviews-boba-2011.csv", boba),
                        new trend("CRONUT", "reviews-cronut.csv", cronut),
                        new trend("PUMPKIN", "reviews-pumpkin.csv", pumpkin),
                        new trend("STRAWBERRY", "reviews-strawberry.csv", berry),
                        new trend("ACAI", "reviews-acai.csv", mint)};
  highlightTrend = new boolean[] {false, false, false, false, false};
  showTrend = new boolean[] {true, true, true, true, true};
  nreviews = new int[ntrends];
  reviews = new review[5][100000]; // max nreviews 100k
  trendPts = new int[5][nyears][13]; // 5 years, 12 months per year (1-indexed)
  for (int i = 0; i < nyears; i++) {
    loadTrend(i);
  }
  loadBusiness();
  reset();
}

void draw() {
  // reset background
  reset();
  
  // drawCompare();
  
  if (trendview) {
   drawAxes();
   drawSearchBar(minX, 50, "Search (press enter)", color(255, 100));
   int offset = 0;
   for (int i = 0; i < 5; i++) {
     if (showTrend[i]) {
       drawTrendLine(i);
       // dressing it up with buttons
       String label = trends[i].name;
       color c = trends[i].getColor();
       drawSearchButton(maxX + (marginX / 2), 100 + offset, label, c, i);
     }
     offset += 50;
   }
  }
  else if (dotview) {
   drawAxes();
   drawTrend(currTrend);
  }
  else if (compareview) {
   drawCompare();
  }
  else {
   drawAxes();
   drawTrend(currTrend);
  }

}

void mouseClicked() {
  // change from trendview to dotview
  if (trendview && currTrend >= 0) {
    selectedBs = new HashSet<String>();
    trendview = false;
    dotview = true;
  }
  if (removeBID != null) {
    selectedBs.remove(removeBID);
    removeBID = null;
  }
  
}