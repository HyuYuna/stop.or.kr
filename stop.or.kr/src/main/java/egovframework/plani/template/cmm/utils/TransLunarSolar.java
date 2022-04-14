package egovframework.plani.template.cmm.utils;

import com.ibm.icu.util.Calendar;
import com.ibm.icu.util.ChineseCalendar;

/**
 * 양력과 음력 날짜를 상호 변환한다.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.cmm.utils] [TransLunarSolar.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 8. 30. 오후 5:25:30
 * @version : 1.0
 * @from : http://rothmans.wordpress.com/
 */
public class TransLunarSolar {

  private Calendar cal;
  private ChineseCalendar cc;

  public TransLunarSolar() {
    // default TimeZone, Locale 을 사용..
    cal = Calendar.getInstance();
    cc = new ChineseCalendar();
  }

  /**
   * 음력을 양력으로 변환한다.
   * 
   * @param yyyymmdd
   * @return
   */
  public synchronized String toLunar(String yyyymmdd) {
    if (yyyymmdd == null)
      return "";

    String date = yyyymmdd.trim();
    if (date.length() != 8) {
      if (date.length() == 4)
        date = date + "0101";
      else if (date.length() == 6)
        date = date + "01";
      else if (date.length() > 8)
        date = date.substring(0, 8);
      else
        return "";
    }

    cal.set(Calendar.YEAR, Integer.parseInt(date.substring(0, 4)));
    cal.set(Calendar.MONTH, Integer.parseInt(date.substring(4, 6)) - 1);
    cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(date.substring(6)));

    cc.setTimeInMillis(cal.getTimeInMillis());

    // ChinessCalendar.YEAR 는 1~60 까지의 값만 가지고 , ChinessCalendar.EXTENDED_YEAR 는 Calendar.YEAR 값과
    // 2637 만큼의 차이를 가진다..
    int y = cc.get(ChineseCalendar.EXTENDED_YEAR) - 2637;
    int m = cc.get(ChineseCalendar.MONTH) + 1;
    int d = cc.get(ChineseCalendar.DAY_OF_MONTH);

    StringBuffer ret = new StringBuffer();
    if (y < 1000)
      ret.append("0");
    else if (y < 100)
      ret.append("00");
    else if (y < 10)
      ret.append("000");
    ret.append(y);

    if (m < 10)
      ret.append("0");
    ret.append(m);

    if (d < 10)
      ret.append("0");
    ret.append(d);

    return ret.toString();
  }

  /**
   * 음력을 양력으로 변환한다.
   * 
   * @param yyyymmdd
   * @return
   */
  public synchronized String fromLunar(String yyyymmdd) {
    if (yyyymmdd == null)
      return "";

    String date = yyyymmdd.trim();
    if (date.length() != 8) {
      if (date.length() == 4)
        date = date + "0101";
      else if (date.length() == 6)
        date = date + "01";
      else if (date.length() > 8)
        date = date.substring(0, 8);
      else
        return "";
    }

    cc.set(ChineseCalendar.EXTENDED_YEAR, Integer.parseInt(date.substring(0, 4)) + 2637);
    cc.set(ChineseCalendar.MONTH, Integer.parseInt(date.substring(4, 6)) - 1);
    cc.set(ChineseCalendar.DAY_OF_MONTH, Integer.parseInt(date.substring(6)));

    cal.setTimeInMillis(cc.getTimeInMillis());

    int y = cal.get(Calendar.YEAR);
    int m = cal.get(Calendar.MONTH) + 1;
    int d = cal.get(Calendar.DAY_OF_MONTH);

    StringBuffer ret = new StringBuffer();
    if (y < 1000)
      ret.append("0");
    else if (y < 100)
      ret.append("00");
    else if (y < 10)
      ret.append("000");
    ret.append(y);

    if (m < 10)
      ret.append("0");
    ret.append(m);

    if (d < 10)
      ret.append("0");
    ret.append(d);

    return ret.toString();
  }

  public static void main(String args[]) {
    TransLunarSolar lc = new TransLunarSolar();
    // 양력 => 음력
    System.out.println("양력 => 음력 변환");
    System.out.println(lc.toLunar("20130830"));

    // 음력 => 양력
    System.out.println("음력 => 양력 변환");
    System.out.println(lc.fromLunar("20130101"));
  }
}
