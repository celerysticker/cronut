// Read data file and generate line plot data
void loadTrend(int index) {
  String filename = trends[index].filename;
  //print("load " + filename + "\n");
  data = loadTable(filename, "header");
  nreviews[index] = min(100000, data.getRowCount());
  
  // initialize trendPts to all zeroes
  for (int i = 0; i < nyears; i++) {
    for (int j = 1; j < 13; j++) {
      trendPts[index][i][j] = 0;
    }
  }
  
  int actualNReviews = 0;
  for (int i = 0; i < nreviews[index]; i++) { // loop through data
    review r = new review(data.getRow(i));
    if (r.year >= 2011) {
      //reviews[i] = r;
      reviews[index][actualNReviews] = new review(data.getRow(i));
      trendPts[index][r.year - min_year][r.month]++;
      actualNReviews++;
    }
  }
  nreviews[index] = actualNReviews;
}

void loadBusiness(){
  String filename = "businesses.csv";
  //print("load " + filename + "\n");
  data = loadTable(filename, "header");
  int nbus = data.getRowCount();
  
  businesses = new HashMap();
  
  for (int i = 0; i < nbus; i++) { // loop through data
   business b = new business(data.getRow(i));
   businesses.put(b.bid, b);
  }
}