package egovframework.plani.template.webtoon.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.webtoon.service.WebtoonCategoryService;
import egovframework.plani.template.webtoon.service.WebtoonService;
import egovframework.plani.template.webtoon.vo.WebtoonCategoryVO;
import egovframework.plani.template.webtoon.vo.WebtoonVO;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.dev.cmm.util.StringUtil;

/**
 * 카드뉴스 컨트롤러 - 사용자
 * 
 * 
 *
 */
@Controller
@RequestMapping("/webtoon")
public class WebtoonUsrController {

	@Resource(name = "webtoonService")
	private WebtoonService webtoonService;

	@Resource
	private CrudTemplate crudTemplate;

	/** AtchfileService */
	@Resource(name = "atchfileService")
	private AtchfileService atchfileService;

	@Resource(name = "webtoonCategoryService")
	private WebtoonCategoryService webtoonCategoryService;

	/**
	 * 사용자 목록
	 * 
	 * @param cardNewsVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/webtoonUsrList")
	public String webtoonUsrList(@ModelAttribute("webtooncategoryVO") final WebtoonCategoryVO webtooncategoryVO,
			HttpServletRequest request, Model model) throws Exception {

		webtooncategoryVO.setPageUnit(12);

		// 페이징 목록 처리
		crudTemplate.pagingList(request, model, webtooncategoryVO, new CrudStrategy<WebtoonCategoryVO>() {
			@Override
			public int totalCount() throws Exception {
				return webtoonCategoryService.selectWebtoonCategoryListTotCnt(webtooncategoryVO);
			}

			@Override
			public List<WebtoonCategoryVO> pagingList() throws Exception {
				return webtoonCategoryService.selectWebtoonCategoryList(webtooncategoryVO);
			}
		});

		model.addAttribute("pageIndex", webtooncategoryVO.getPageIndex());

		return "/webtoon/webtoonUsrList";
	}

	// @RequestMapping("/webtoonUsrList")
	// public String webtoonUsrList(@ModelAttribute("webtoonVO") final WebtoonVO
	// webtoonVO,
	// HttpServletRequest request, Model model) throws Exception {
	//
	//
	//
	// List webtoonNoticeList =
	// webtoonService.selectNoticeWebtoonList(webtoonVO);
	//
	// webtoonVO.setPageUnit(12);
	//
	// // 페이징 목록 처리
	// crudTemplate.pagingList(request, model, webtoonVO, new
	// CrudStrategy<WebtoonVO>() {
	// @Override
	// public int totalCount() throws Exception {
	// return webtoonService.selectWebtoonListTotCnt(webtoonVO);
	// }
	//
	// @Override
	// public List<WebtoonVO> pagingList() throws Exception {
	// return webtoonService.selectWebtoonList(webtoonVO);
	// }
	// });
	//
	//
	// model.addAttribute("webtoonNoticeList", webtoonNoticeList);
	// model.addAttribute("pageIndex", webtoonVO.getPageIndex());
	//
	// /* 카테고리별 1회 값 셋팅 */
	// webtoonVO.setCategory("01"); // 불어라 비바람
	// WebtoonVO resultVO = webtoonService.selectDescSeq(webtoonVO);
	// /* 카테고리별 1회 값 셋팅 */
	// webtoonVO.setCategory("02"); // 여행
	// WebtoonVO resultVO2 = webtoonService.selectDescSeq(webtoonVO);
	//
	// model.addAttribute("result", resultVO);
	// model.addAttribute("result2", resultVO2);
	//
	// return "/webtoon/webtoonUsrList";
	// }

	@RequestMapping("/webtoonUsrView")
	public String webtoonUsrView(@ModelAttribute("webtoonVO") WebtoonVO webtoonVO, HttpServletRequest request,
			Model model) throws Exception {

		String pageIndex = request.getParameter("pageIndex");
		if (StringUtils.isEmpty(pageIndex) == false) {
			model.addAttribute("pageIndex", pageIndex);
		} else {
			model.addAttribute("pageIndex", 1);
		}

		String rn = request.getParameter("nownm");
		if (StringUtils.isEmpty(rn) == true) {
			throw new CmmnException(MessageHelper
					.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);
		}
		//20191106 취약점조치로 int형으로 변환
		int seq = StringUtil.parseInt(request.getParameter("seq"));
		int cate = StringUtil.parseInt(request.getParameter("cate"));
		System.out.println("cate#"+request.getParameter("cate"));
		System.out.println("cate#"+cate);
		

		if (StringUtils.isEmpty(seq) == false) {
			
			// 첨부파일
			AtchfileVO fVo = new AtchfileVO();
			fVo.setAtckey_1st("WEBTOON");
			fVo.setAtckey_2nd(Integer.toString(seq));
			fVo.setAtckey_3rd(1);

			List fileList = atchfileService.selectAtchfileList(fVo);
			model.addAttribute("atchfileList", fileList);

			webtoonVO.setCn_seq(seq);
			webtoonVO.setCategory(Integer.toString(cate));
			WebtoonVO resultVO = webtoonService.selectWebtoon(webtoonVO);
			model.addAttribute("webtoonVO", resultVO);

			// 조회수 업데이트
			webtoonVO.setHits(resultVO.getHits() + 1);
			webtoonService.updateWebtoonCount(webtoonVO);

		}

		// 하위 리스트 가져오기
		int firstIndex = Integer.parseInt(rn) > 4 ? Integer.parseInt(rn) - 4 : 0;
		webtoonVO.setFirstIndex(firstIndex);
		webtoonVO.setRecordCountPerPage(9);
		//webtoonVO.setSearchCondition(request.getParameter("cate"));//20191106 취약점조치로 제거
		List underList = webtoonService.selectWebtoonList(webtoonVO);
		model.addAttribute("underList", underList);

		return "/webtoon/webtoonUsrView";
	}
}
