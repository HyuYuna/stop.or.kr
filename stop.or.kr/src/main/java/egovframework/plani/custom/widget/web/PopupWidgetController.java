package egovframework.plani.custom.widget.web;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import egovframework.plani.template.man.popup.service.PopupService;
import egovframework.plani.template.man.popup.vo.PopupVO;

@Controller
public class PopupWidgetController {

  /** PopupService */
  @Resource(name = "popupService")
  protected PopupService popupService;

  /**
   * 팝업위젯처리
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/widgets/popup")
  public String popup(HttpServletRequest request, Model model) throws Exception {

    String popup_cnt = request.getParameter("popup_cnt");

    // 메인 팝업창 정보 조회
    PopupVO popVO = new PopupVO();
    popVO.setPop_type("W");
    List popupList = popupService.selectValidPopupList(popVO);

    // Cookie[] cookies = request.getCookies();
    HttpSession session = request.getSession();


    if (popupList.size() > 0) {

      // 팝업정보 리스트
      for (int p = popupList.size() - 1; p >= 0; p--) {

        PopupVO rowVo = (PopupVO) popupList.get(p);
        String sessionValue =
            (String) session.getAttribute("popup_day_close_" + rowVo.getPop_seq());

        Integer seq = rowVo.getPop_seq();

        if (sessionValue != null) {

          // 세션있는 팝업 안뜨게 삭제
          popupList.remove(p);
        }

      }
    }



    model.addAttribute("popupList", popupList);
    return "/custom/widget/kor/popup";


  }


  /**
   * 팝업 하루동안 안보기 세션처리
   * 
   * @param request
   * @param response
   * @return
   * @throws Exception
   */
  @RequestMapping("/widgets/setPopCookie")
  @ResponseBody
  public String setPopupCookie(HttpServletRequest request, HttpServletResponse response)
      throws Exception {

    String seq = request.getParameter("seq");

    // Cookie cookie = new Cookie("popup_day_close_" + seq, "1");
    // cookie.setMaxAge(60 * 60 * 24);
    // cookie.setPath("/"); // 모든 경로에서 접근 가능하도록
    // response.addCookie(cookie); // 쿠키저장

    HttpSession session = request.getSession();
    response.setContentType("text/html; charset=UTF-8");
    session.setAttribute("popup_day_close_" + seq, seq);
    session.setMaxInactiveInterval(60 * 60 * 24);

    // session.invalidate();



    return "SUCCESS";
  }


  /**
   * 팝업존 위젯처리
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/widgets/popupzone")
  public String popupzone(HttpServletRequest request, Model model) throws Exception {

    String popup_cnt = request.getParameter("popup_cnt");
    String srch_mu_lang = request.getParameter("srch_mu_lang");
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;
    String lang = "kor";

    // 메인 팝업창 정보 조회
    PopupVO popVO = new PopupVO();
    popVO.setPop_type("Z");
    List popupList = popupService.selectValidPopupList(popVO);

    model.addAttribute("popupList", popupList);

    if ("CDIDX00022".equals(srch_mu_lang) == false) {
      lang = "eng";
    }

    return "/custom/widget/" + lang + "/popupzone";

  }

  /**
   * 비쥬얼 위젯 처리
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/widgets/visual")
  public String visual(HttpServletRequest request, Model model) throws Exception {


    String popup_cnt = request.getParameter("visual_cnt");
    String srch_mu_lang = request.getParameter("srch_mu_lang");
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;
    String lang =
        request.getParameter("language") == null ? "kor" : request.getParameter("language");
    String pop_type =
        request.getParameter("pop_type") == null ? "V" : request.getParameter("pop_type");
    // 메인 팝업창 정보 조회
    PopupVO popVO = new PopupVO();
    popVO.setPop_type(pop_type);
    List visualList = popupService.selectValidPopupList(popVO);

    System.out.println(visualList);

    model.addAttribute("visualList", visualList);
    model.addAttribute("visual_size", visualList.size());

    return "/custom/widget/" + lang + "/visual";

  }


  /**
   * 비쥬얼 위젯 처리
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/widgets/complicityVisual")
  public String complicityVisual(HttpServletRequest request, Model model) throws Exception {

    String popup_cnt = request.getParameter("visual_cnt");
    String srch_mu_lang = request.getParameter("srch_mu_lang");
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;

    // 메인 팝업창 정보 조회
    PopupVO popVO = new PopupVO();
    popVO.setPop_type("C");
    List visualList = popupService.selectValidPopupList(popVO);

    model.addAttribute("visualList", visualList);
    model.addAttribute("visual_size", visualList.size());


    System.out.println("visualList.size()" + visualList.size());
    return "/custom/widget/complicity/kor/visual";

  }
}
