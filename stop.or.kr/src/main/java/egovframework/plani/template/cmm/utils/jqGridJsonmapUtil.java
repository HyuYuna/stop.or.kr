package egovframework.plani.template.cmm.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;

/**
 * jqGrid에 넘겨줄 jsonmap 생성
 * 
 * @class : [KTSTA] [egovframework.plani.cmm.utils] [jqGridJsonmapUtil.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 10. 24. 오후 6:56:21
 * @version : 1.0
 */
public class jqGridJsonmapUtil {

  /** Logger */
  Logger logger = Logger.getLogger(getClass().getName());

  /** 현재 페이지 번호 */
  private String CUR_PAGE = "page";

  /** 총 페이지 수 */
  private String TOT_PAGE = "total";

  /** 총 레코드 수 */
  private String RCD_CNT = "records";

  /** 데이터 */
  private String ROWS_DATA = "rows";

  /** Json Map */
  private Map<String, Object> jsonmap;

  public jqGridJsonmapUtil() {
    this.jsonmap = new HashMap<String, Object>();
  }

  public void setJsonMap(int cur_page, int tot_pate, int rcd_cnt, List<Object> resultList) {
    jsonmap.put(CUR_PAGE, new Integer(cur_page));
    jsonmap.put(TOT_PAGE, new Integer(tot_pate));
    jsonmap.put(RCD_CNT, new Integer(rcd_cnt));
    jsonmap.put(ROWS_DATA, resultList);
  }

  public Map<String, Object> getJsonmap() {
    return jsonmap;
  }

  public void setJsonmap(Map<String, Object> jsonmap) {
    this.jsonmap = jsonmap;
  }

  public String getCUR_PAGE() {
    return CUR_PAGE;
  }

  public void setCUR_PAGE(String cUR_PAGE) {
    CUR_PAGE = cUR_PAGE;
  }

  public String getTOT_PAGE() {
    return TOT_PAGE;
  }

  public void setTOT_PAGE(String tOT_PAGE) {
    TOT_PAGE = tOT_PAGE;
  }

  public String getRCD_CNT() {
    return RCD_CNT;
  }

  public void setRCD_CNT(String rCD_CNT) {
    RCD_CNT = rCD_CNT;
  }

  public String getROWS_DATA() {
    return ROWS_DATA;
  }

  public void setROWS_DATA(String rOWS_DATA) {
    ROWS_DATA = rOWS_DATA;
  }


}
