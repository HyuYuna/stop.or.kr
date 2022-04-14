package egovframework.plani.custom.man.company.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.plani.custom.man.company.service.CompanyService;
import egovframework.plani.custom.man.company.vo.CompanyVO;
import egovframework.plani.template.brdartcl.service.BoardthmService;
import egovframework.plani.template.brdartcl.vo.BoardthmVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.metsys.service.AwardsDataService;
import egovframework.plani.template.man.metsys.vo.AwardsDataVO;
import egovframework.plani.template.multicms.service.MultiCmsService;
import egovframework.plani.template.multicms.vo.MultiCmsVO;

@Controller
@RequestMapping("/mancompany")
public class ManCompanyController {

	@Resource(name = "companyService")
	private CompanyService companyService;

	/** multiCmsService */
	@Resource(name = "multiCmsService")
	private MultiCmsService multiCmsService;

	/** 수상작 Service */
	@Resource(name = "awardsDataService")
	private AwardsDataService awardsDataService;

	/** BoardthmService */
	@Resource(name = "boardthmService")
	private BoardthmService boardthmService;

	/** ManlogService */
	@Resource(name = "manlogService")
	protected ManlogService manlogService;

	@RequestMapping("/companyList")
	public String companyList(final @ModelAttribute("companyVO") CompanyVO companyVO, Model model,
			HttpServletRequest request) throws Exception {

		int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}

		return "/mancompany/companyList";

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
	@RequestMapping("/xlsCompanyList")
	public void xlsCompanyList(@ModelAttribute("companyVO") CompanyVO companyVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
		ArrayList colinfoList = new ArrayList();

		String[][] col_name = { { "RN", "순번" }, { "DIV", "구분" }, { "SUBJECT", "제목" }, { "NAME", "기관명" },
				{ "WDT", "다운로드일" } };

		for (int i = 0; i < col_name.length; i++) {
			HashMap ifmap = new HashMap();
			ifmap.put("COL_NAME", col_name[i][0]);
			ifmap.put("COL_INFO", col_name[i][1]);
			colinfoList.add(ifmap);
		}

		List companyOrgList = companyService.xlsCompanyList(companyVO);

		/************************************************************
		 * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은
		 * 생략한다....
		 ************************************************************/
		List newsletterXlsList = new ArrayList();
		String xdiv = "";
		String xsubject = "";
		for (int i = 0; i < companyOrgList.size(); i++) {
			CompanyVO vo = (CompanyVO) companyOrgList.get(i);
			HashMap rsmap = new HashMap();
			rsmap.put("RN", vo.getRn());
			if (vo.getDiv().equals("BDIDX_3K0Ny2492D27W3273Vb3G2")) {
				xdiv = "영상자료";
				BoardthmVO rvo = new BoardthmVO();
				rvo.setCont_idx(vo.getSeq());
				rvo.setBrd_id("BDIDX_3K0Ny2492D27W3273Vb3G2");
				rvo.setTbl_nm("CMS_BRD_THM_IDX_CF68M3GZ");
				rvo = boardthmService.selectBoardthm(rvo);
				if (rvo != null)
					xsubject = rvo.getSubject();
				else
					continue;
			} else if (vo.getDiv().equals("multicms_pp")) {
				xdiv = "정기간행물";
				MultiCmsVO rvo = new MultiCmsVO();
				rvo.setMc_seq(vo.getSeq());
				rvo = multiCmsService.selectMultiCms(rvo);
				if (rvo != null)
					xsubject = rvo.getMc_title();
				else
					continue;
			} else if (vo.getDiv().equals("multicms_pd")) {
				xdiv = "발간자료";
				MultiCmsVO rvo = new MultiCmsVO();
				rvo.setMc_seq(vo.getSeq());
				rvo = multiCmsService.selectMultiCms(rvo);
				if (rvo != null)
					xsubject = rvo.getMc_title();
				else
					continue;
			} else if (vo.getDiv().equals("multicms_ck")) {
				xdiv = "캠페인KIT";
				MultiCmsVO rvo = new MultiCmsVO();
				rvo.setMc_seq(vo.getSeq());
				rvo = multiCmsService.selectMultiCms(rvo);
				if (rvo != null)
					xsubject = rvo.getMc_title();
				else
					continue;
			} else if (vo.getDiv().equals("complicity")) {
				xdiv = "공모전";
				AwardsDataVO rvo = new AwardsDataVO();
				rvo.setData_id(vo.getSeq());
				rvo = awardsDataService.selectAwardsData(rvo);
				if (rvo != null)
					xsubject = rvo.getSubject();
				else
					continue;

			}
			rsmap.put("DIV", xdiv);
			rsmap.put("NAME", vo.getName());
			rsmap.put("SUBJECT", xsubject);
			rsmap.put("WDT", vo.getWdt());

			newsletterXlsList.add(rsmap);
		}

		String fileName = "기관정보";

		// ////////////////////////////////////////////////////////////////////////////////////////////
		//
		// 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
		manlogService.insertManlog(request, "COMPANY_MAN", "기관관리", "기관 정보 엑셀저장", "X");
		//
		// ////////////////////////////////////////////////////////////////////////////////////////////

		xlsDownUtil.ExcelWrite(response, newsletterXlsList, colinfoList, fileName);
	}
}
