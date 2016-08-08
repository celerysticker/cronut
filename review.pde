// user_id,review_id,text,votes.cool,business_id,votes.funny,stars,date,type,votes.useful
int min_year = 2011;
int maxPosX = (2015 - min_year) * 365 + 12 * 31;

class review {
  String user_id;
  String review_id;
  String business_id;
  String text;
  int votes_cool;
  int votes_funny;
  int votes_useful;
  int stars;
  String datestring;
  String[] date;
  int year = -1;
  int month = -1;
  int day = -1;
  float pos;
  String type;
  float x;
  float y;
  
  review(TableRow t) {
    user_id = t.getString("user_id");
    review_id = t.getString("review_id");
    business_id = t.getString("business_id");
    stars = t.getInt("stars");
    datestring = t.getString("date");
    if (datestring != null) {
     date = datestring.split("-");
     // process date
     year = Integer.parseInt(date[0]);
     month = Integer.parseInt(date[1]);
     day = Integer.parseInt(date[2]);
    }
    pos = (year - min_year) * 365 + month * 31; // + day
    x = map(pos, 0,maxPosX, minX,maxX);
    y = 550 - (stars * 90) + random(-40, 40);
    
  }
}