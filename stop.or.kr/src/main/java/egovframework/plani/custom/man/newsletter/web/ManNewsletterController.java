package egovframework.plani.custom.man.newsletter.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.man.log.service.ManlogService;

@Controller
@RequestMapping("/mannewsletter")
public class ManNewsletterController {

	@Resource(name = "newsletterService")
	private NewsletterService newsletterService;
	@Resource
	private CrudTemplate crudTemplate;

	/** ManlogService */
	@Resource(name = "manlogService")
	protected ManlogService manlogService;

	/**
	 * 리스트 페이지 출력
	 * 
	 * @param scheduleVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */

	@RequestMapping("newsletterList")
	public String newsletterList(final @ModelAttribute("newsletterVO") NewsletterVO newsletterVO, Model model,
			HttpServletRequest request) throws Exception {

		int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}
		// 페이징 목록 처리
		crudTemplate.pagingList(request, model, newsletterVO, new CrudStrategy<NewsletterVO>() {
			@Override
			public int totalCount() throws Exception {
				return newsletterService.selectNewsletterListTotCnt(newsletterVO);
			}

			@Override
			public List<NewsletterVO> pagingList() throws Exception {
				return newsletterService.selectNewsletterList(newsletterVO);
			}
		});

		manlogService.insertManlog(request, "NEWSLETTER_MAN", "메인 뉴스레터 관리", "메인 뉴스레터 조회", "L");

		return "/mannewsletter/newsletterList";
	}

	public NewsletterVO common_form(NewsletterVO newsletterVO, Model model, HttpServletRequest request)
			throws Exception {
		// System.out.println("newsletterVOnewsletterVOnewsletterVO" +
		// newsletterVO);
		NewsletterVO newsletter_vo = null;
		// srch_idx가 있따면, 게시글이 존재하는지 여부 판단.
		if (newsletterVO.getNew_idx() != 0) {
			newsletter_vo = newsletterService.selectNewsletter(newsletterVO);
			if (newsletter_vo == null)
				throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST"));
		}
		return newsletter_vo;
	}

	/**
	 * 쓰기 페이지
	 * 
	 * @param scheduleVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */
	@RequestMapping(value = "newsletterForm", method = RequestMethod.GET)
	public String newsletterForm(@ModelAttribute("newsletterVO") NewsletterVO newsletterVO, Model model,
			HttpServletRequest request) throws Exception {

		// 공통함수
		NewsletterVO newsletter_vo = common_form(newsletterVO, model, request);
		if (newsletter_vo != null) {
			newsletterVO.setEmail(newsletter_vo.getEmail());
			newsletterVO.setDeldt(newsletter_vo.getDeldt());
			newsletterVO.setWdt(newsletter_vo.getWdt());
			manlogService.insertManlog(request, "NEWSLETTER_MAN", "메인 뉴스레터관리",
					"메인 뉴스레터 조회 [" + newsletter_vo.getEmail() + "]", "R");
		}

		return "/mannewsletter/newsletterForm";
	}

	/**
	 * 쓰기 페이지 저장
	 * 
	 * @param scheduleVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */
	@RequestMapping(value = "newsletterForm", method = RequestMethod.POST)
	@ResponseBody
	public Object newsletterForm(@Valid NewsletterVO newsletterVO, BindingResult result, Model model,
			HttpServletRequest request) throws Exception {

		common_form(newsletterVO, model, request);

		// validation 적용하기.
		ResponseResultHelper responseResultHelper = new ResponseResultHelper(request, "/mannewsletter/newsletterForm");
		// 폼 유효성 검사
		if (result.hasErrors()) {
			return responseResultHelper.validation(result);
		}

		if (newsletterVO.getNew_idx() == 0) {
			// 등록
			newsletterService.insertNewsletter(newsletterVO);
			manlogService.insertManlog(request, "NEWSLETTER_MAN", "메인 뉴스레터관리",
					"메인 뉴스레터 추가 [" + newsletterVO.getEmail() + "]", "C");
		} else {
			// 수정
			newsletterVO.setSrch_mu_gub("MAN");
			newsletterService.updateNewsletter(newsletterVO);
			manlogService.insertManlog(request, "NEWSLETTER_MAN", "메인 뉴스레터관리",
					"메인 뉴스레터 변경 [" + newsletterVO.getEmail() + "]", "U");
		}

		return responseResultHelper.success(null, "완료되었습니다.",
				"/mannewsletter/newsletterList.do?srch_menu_nix=" + newsletterVO.getSrch_menu_nix(), null);
	}

	/**
	 * 삭제 페이지
	 * 
	 * @param scheduleVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */
	@RequestMapping(value = "newsletterDelete", method = RequestMethod.GET)
	public String newsletterDelete(@ModelAttribute("newsletterVO") NewsletterVO newsletterVO, Model model,
			HttpServletRequest request) throws Exception {

		// 공통함수
		NewsletterVO newsletter_vo = common_form(newsletterVO, model, request);
		if (newsletter_vo == null)
			throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST"));
		newsletterService.deleteNewsletter(newsletterVO);
		manlogService.insertManlog(request, "NEWSLETTER_MAN", "메인 뉴스레터관리",
				"메인 뉴스레터 삭제 [" + newsletter_vo.getEmail() + "]", "D");

		return "redirect:/mannewsletter/newsletterList.do?srch_menu_nix=" + newsletterVO.getSrch_menu_nix();

	}

	/**
	 * 사용자 목록의 엑셀 다운로드 요청을 처리한다.
	 * 
	 * @param usrVO
	 *            : 엑셀 다운로드 할 조건이 담긴 사용자 VO
	 * @param request
	 * @param model
	 * @exception Exception
	 */
	@RequestMapping("/xlsNewsletterList")
	public void xlsNewsletterList(@ModelAttribute("newsletterVO") NewsletterVO newsletterVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
		ArrayList colinfoList = new ArrayList();

		String[][] col_name = { { "RN", "순번" }, { "EMAIL", "이메일" }, { "WDT", "등록일" }, { "DELDT", "취소일" },
				{ "MDT", "수정일" }, { "AGREE", "재동의" } };

		for (int i = 0; i < col_name.length; i++) {
			HashMap ifmap = new HashMap();
			ifmap.put("COL_NAME", col_name[i][0]);
			ifmap.put("COL_INFO", col_name[i][1]);
			colinfoList.add(ifmap);
		}



		List newsletterOrgList = newsletterService.selectExcelList(newsletterVO);

		/************************************************************
		 * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은
		 * 생략한다....
		 ************************************************************/
		List newsletterXlsList = new ArrayList();
		for (int i = 0; i < newsletterOrgList.size(); i++) {
			NewsletterVO vo = (NewsletterVO) newsletterOrgList.get(i);

			HashMap rsmap = new HashMap();
			rsmap.put("RN", vo.getRn());
			rsmap.put("EMAIL", vo.getEmail());
			rsmap.put("WDT", vo.getWdt());
			rsmap.put("DELDT", vo.getDeldt());
			rsmap.put("MDT", vo.getMdt());
			rsmap.put("AGREE", vo.getAgree());

			newsletterXlsList.add(rsmap);
		}

		String fileName = "메인 뉴스레터 정보";
		String reason=newsletterVO.getReason();//20200608 사유 추가
		// ////////////////////////////////////////////////////////////////////////////////////////////
		//
		// 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
		manlogService.insertManlog(request, "NEWSLETTER_MAN", "메인 뉴스레터관리", "메인뉴스레터 목록 엑셀저장(사유:"+reason+")", "X");
		//
		// ////////////////////////////////////////////////////////////////////////////////////////////

		xlsDownUtil.ExcelWrite(response, newsletterXlsList, colinfoList, fileName);
	}

}
