package egovframework.plani.template.cmm.web;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;
import egovframework.plani.template.man.popup.service.PopupService;
import egovframework.plani.template.man.popup.vo.PopupVO;

@Controller
public class FindPostcodeController {
  /** PopupService */
  @Resource(name = "popupService")
  private PopupService popupService;

  /**
   * 우편번호 찾기 epost 우편번호 찾기 api 신청 정보 email: dev@plani.co.kr 성명: 플랜아이
   */
  @RequestMapping(value = "/findZipcode.do")
  public void findZipcode(HttpServletResponse response, DefaultSearchVO vo) throws Exception {
    String query = vo.getSearchKeyword();
    String regKey = "4613e4dcc42517fd71369040413195"; // 우체국 사이트에서 받은 api 키
    String location = "http://biz.epost.go.kr/KpostPortal/openapi?regkey=" + regKey
        + "&target=post&query=" + URLEncoder.encode(query, "euc-kr"); // 요청 URL
    System.out.println(location);
    BufferedOutputStream out = null;

    java.net.URL url = new java.net.URL(location);
    java.net.URLConnection connection = url.openConnection();
    // connection.addRequestProperty("Referer", "http://localhost"); //그냥 아무거나 넣은 것입니다.
    connection.setRequestProperty("accept-language", "ko"); // 문자셋을 euc-kr을 이용하므로 이게 빠지면 제대로 안나옵니다.

    String line;

    out = new BufferedOutputStream(response.getOutputStream());
    // java.io.BufferedReader reader = new java.io.BufferedReader(new
    // java.io.InputStreamReader(connection.getInputStream()));

    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    InputStream in = connection.getInputStream();

    byte[] readbytes = new byte[1024];
    int redcnt = 0;

    while ((redcnt = in.read(readbytes)) > 0) {
      baos.write(readbytes, 0, redcnt);
    }
    String xmlData = baos.toString("euc-kr");
    xmlData = xmlData.replaceAll("\n", "");
    out.write(xmlData.getBytes("euc-kr"));

    // System.out.println(xmlData);
    response.setContentType("text/xml; charset=euc-kr");
    out.flush();
  }

  /**
   * 유효 팝업 목록 조회
   */
  @RequestMapping(value = "/findValidPopup.do")
  public void selectValidPopupList(HttpServletResponse response, PopupVO vo) throws Exception {
    /*
     * String popType = vo.getPop_type(); BufferedOutputStream out = null; if(popType == null ||
     * popType.equals("")) throw new Exception("팝업 구분자 누락[W|Z]");
     * 
     * ArrayList<PopupVO> resultList =
     * (ArrayList<PopupVO>)popupService.selectValidPopupList(popType);
     * response.setContentType("text/xml; charset=utf-8"); out = new
     * BufferedOutputStream(response.getOutputStream()); StringBuffer sb = new StringBuffer();
     * 
     * sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?><result>");
     * 
     * String storePath = EgovProperties.GLOBALS_FILEUPLOAD_PATH;
     * 
     * for(int i=0; i<resultList.size(); i++){ PopupVO pvo = (PopupVO)resultList.get(i);
     * 
     * String pop_w = pvo.getPop_w() == null || pvo.getPop_w().equals("") ? "0" : pvo.getPop_w();
     * String pop_h = pvo.getPop_h() == null || pvo.getPop_h().equals("") ? "0" : pvo.getPop_h();
     * 
     * 
     * 
     * sb.append("<popup>");
     * 
     * sb.append("<seq>" + pvo.getSeq() + "</seq>"); sb.append("<popTitle><![CDATA[" +
     * (pvo.getPop_title() == null ? "" : pvo.getPop_title()) + "]]></popTitle>");
     * sb.append("<popAlt><![CDATA[" + (pvo.getPop_alt() == null ? "" : pvo.getPop_alt()) +
     * "]]></popAlt>"); sb.append("<popX><![CDATA[" + (pvo.getPop_x() == null ? "0" :
     * pvo.getPop_x()) + "]]></popX>"); sb.append("<popY><![CDATA[" + (pvo.getPop_y() == null ? "0"
     * : pvo.getPop_y()) + "]]></popY>");
     * 
     * // 이미지가 있을 경우 if(pvo.getAtch_idx() > 0){ try{ if(pop_w.equals("0") || pop_h.equals("0")){
     * BufferedImage bi = ImageIO.read(new File(storePath + pvo.getFpath() + "/" + pvo.getFname()));
     * if(pop_w.equals("0")) pop_w = new Integer(bi.getWidth()).toString(); if(pop_h.equals("0"))
     * pop_h = new Integer(bi.getHeight()).toString(); } } catch(Exception e){
     * System.out.println("물리적 위치에서 파일정보를 확인할 수 없습니다."); }
     * 
     * sb.append("<popImage><![CDATA[/atchfile/imageAtchfile.do?brd_id=POPUP&cont_idx=" +
     * pvo.getSeq() + "&atch_idx=" + pvo.getAtch_idx() + "]]></popImage>"); } else{
     * if(pop_w.equals("0")) pop_w = "300"; if(pop_h.equals("0")) pop_h = "350";
     * sb.append("<popImage></popImage>"); }
     * 
     * sb.append("<popW><![CDATA[" + pop_w + "]]></popW>"); sb.append("<popH><![CDATA[" + pop_h +
     * "]]></popH>"); sb.append("<popLink><![CDATA[" + (pvo.getPop_link() == null ? "" :
     * pvo.getPop_link()) + "]]></popLink>"); sb.append("<popTarget><![CDATA[" +
     * (pvo.getPop_target() == null ? "" : pvo.getPop_target()) + "]]></popTarget>");
     * sb.append("<popContent><![CDATA[" + (pvo.getPop_content() == null ? "" :
     * pvo.getPop_content()) + "]]></popContent>");
     * 
     * sb.append("</popup>"); }
     * 
     * sb.append("</result>");
     * 
     * out.write(sb.toString().getBytes("utf-8")); out.flush();
     */
  }
}
