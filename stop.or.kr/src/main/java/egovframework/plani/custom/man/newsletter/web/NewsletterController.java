package egovframework.plani.custom.man.newsletter.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import egovframework.plani.custom.man.newsletter.service.NewsletterService;
import egovframework.plani.custom.man.newsletter.vo.NewsletterVO;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;

@Controller
@RequestMapping("/newsletter")
public class NewsletterController {

  @Resource(name = "newsletterService")
  private NewsletterService newsletterService;



  /**
   * 이메일 수신 거부 페이지
   * 
   * @param newsletterVO
   * @param model
   * @param request
   * @exception Exception
   * @return String
   * 
   */
  @RequestMapping(value = "newsletterForm", method = RequestMethod.GET)
  public String newsletterForm(@ModelAttribute("newsletterVO") NewsletterVO newsletterVO,
      Model model, HttpServletRequest request) throws Exception {
    return "/newsletter/newsletterForm";
  }

  /**
   * 이메일 수신 거부 저장 등록 액션
   * 
   * @param newsletterVO
   * @param model
   * @param request
   * @exception Exception
   * @return String
   * 
   */
  @RequestMapping(value = "newsletterFormAdd", method = RequestMethod.POST)
  @ResponseBody
  public Object newsletterFormAdd(@Valid NewsletterVO newsletterVO, BindingResult result,
      Model model, HttpServletRequest request) throws Exception {


    // validation 적용하기.
    ResponseResultHelper responseResultHelper = new ResponseResultHelper(request, "/");

    // 폼 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    if (request.getParameter("agree") == null || request.getParameter("agree").equals("N")) {
      return responseResultHelper.error("", MessageHelper.getMessage("info.noagree.msg"), null,
          null);
    }

    /* 이미 저장된 메일 계정인지 중복체킹 */
    int e_cnt = emailcheck(newsletterVO);

    if (e_cnt > 0)
      return responseResultHelper.error("", MessageHelper.getMessage("info.already.regist"), null,
          null);

    newsletterService.insertNewsletter(newsletterVO);



    return responseResultHelper.success(null, "뉴스래터가 신청 완료 되었습니다.", "/", null);
  }


  /**
   * 이메일 수신 거부 수정 등록 액션
   * 
   * @param newsletterVO
   * @param model
   * @param request
   * @exception Exception
   * @return String
   * 
   */
  @RequestMapping(value = "newsletterFormMdf", method = RequestMethod.POST)
  @ResponseBody
  public Object newsletterFormMdf(@Valid NewsletterVO newsletterVO, BindingResult result,
      Model model, HttpServletRequest request) throws Exception {


    // validation 적용하기.
    ResponseResultHelper responseResultHelper = new ResponseResultHelper(request, "/");

    // 폼 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    /* 이미 저장된 메일 계정인지 체킹 */
    int e_cnt = emailcheck(newsletterVO);

    if (e_cnt <= 0)
      return responseResultHelper
          .error("", MessageHelper.getMessage("info.nodata.msg"), null, null);

    /* 현재시간이 수신거부 취소 시간이 됨 */
    Calendar calendar = Calendar.getInstance();
    java.util.Date date = calendar.getTime();
    String today = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date));
    newsletterVO.setDeldt(today);
    newsletterVO.setSrch_mu_gub("USR");
    newsletterService.updateNewsletter(newsletterVO);


    return responseResultHelper.success(null, "완료되었습니다.", "/", null);

  }

  /**
   * 이메일 체크
   * 
   */

  public int emailcheck(NewsletterVO newsletterVO) throws Exception {

    /* 이미 저장된 메일 계정인지 체킹 */
    return newsletterService
        .selectNewsletterCheckEmail(newsletterVO.getEmail().replaceAll(" ", ""));
  }
  
  /**
   * 이메일 수신 재동의 페이지
   * 
   * @param newsletterVO
   * @param model
   * @param request
   * @exception Exception
   * @return String
   * 
   */
  @RequestMapping(value = "newsletterReForm", method = RequestMethod.GET)
  public String newsletterReForm(@ModelAttribute("newsletterVO") NewsletterVO newsletterVO,
      Model model, HttpServletRequest request) throws Exception {
    return "/newsletter/agree1";
  }
  
  /**
   * 이메일 수신 재동의 등록 액션
   * 
   * @param newsletterVO
   * @param model
   * @param request
   * @exception Exception
   * @return String
   * 
   */
  @RequestMapping(value = "newsletterReFormAdd", method = RequestMethod.POST)
  public String newsletterReFormAdd(@Valid NewsletterVO newsletterVO, BindingResult result,
      Model model, HttpServletRequest request) throws Exception {

    newsletterService.updateNewsletterReForm(newsletterVO);
    model.addAttribute("agree", request.getParameter("agree"));


    return "/newsletter/agree2";

  }
}
