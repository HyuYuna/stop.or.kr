package egovframework.plani.template.cmm.utils;

import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;

import net.sf.json.JSONObject;


/**
 * IP 주소를 이용해 국가, 지역명을 구한다. (100% 정확한 정보가 아님)
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.cmm.utils] [IpInfoDbClient.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 6. 19. 오후 4:58:30
 * @version : 1.0
 */
public class IpInfoDbClient {

  private String apiKey = "b33e15b826f4387ff58f91e7b36eaa788ffcb7caf30c9cc78032a5bda867b313";
  String countryCode = null;
  String countryName = null;
  String cityName = null;

  public void getIpInfoDb(String ip_) throws Exception {
    if (countryCode == null) {

      String url = "http://api.ipinfodb.com/v3/ip-city/?format=json&key=" + apiKey;
      url += "&ip=" + ip_;
      HttpClient httpclient = null;

      try {

        if ("127.0.0.1".equals(ip_) || "localhost".equals(ip_) || ip_.startsWith("192.168.")) {
          countryCode = "KR";
          countryName = "KOREA, REPUBLIC OF";
          cityName = "TAEJON";
        } else {
          HttpParams params = new BasicHttpParams();

          HttpConnectionParams.setConnectionTimeout(params, 2000);
          HttpConnectionParams.setSoTimeout(params, 2000);
          httpclient = new DefaultHttpClient(params);
          HttpGet httpget = new HttpGet(url);

          ResponseHandler<String> responseHandler = new BasicResponseHandler();
          String responseBody = httpclient.execute(httpget, responseHandler);
          JSONObject jsonObject = JSONObject.fromObject(responseBody);

          String statusCode = (String) jsonObject.get("statusCode");
          if ("OK".equals(statusCode)) {
            countryCode = (String) jsonObject.get("countryCode");
            countryName = (String) jsonObject.get("countryName");
            cityName = (String) jsonObject.get("cityName");
          } else
            throw new Exception("로그인 지역정보를 가져오지 못했습니다.");
        }

      } catch (Exception e) {
        countryCode = "KR";
        countryName = "KOREA, REPUBLIC OF";
        cityName = "SEOUL";

        e.printStackTrace();
      } finally {
        if (httpclient != null)
          httpclient.getConnectionManager().shutdown();
      }
    }
  }


  public String getCountryCode() {
    return countryCode;
  }


  public void setContryCode(String countryCode) {
    this.countryCode = countryCode;
  }


  public String getCountryName() {
    return countryName;
  }


  public void setCountryName(String countryName) {
    this.countryName = countryName;
  }


  public String getCityName() {
    return cityName;
  }


  public void setCityName(String cityName) {
    this.cityName = cityName;
  }


  public static void main(String[] args) throws Exception {

    IpInfoDbClient client = new IpInfoDbClient();

    client.getIpInfoDb("210.105.85.4"); // 서울
    // client.getIpInfoDb("168.188.3.174"); 대전
    System.out.println(client.getCityName());
    System.out.println(client.getCountryCode());
    System.out.println(client.getCountryName());

  }

}
