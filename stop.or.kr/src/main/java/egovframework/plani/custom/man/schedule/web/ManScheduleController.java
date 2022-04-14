package egovframework.plani.custom.man.schedule.web;

import java.util.List;

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

import egovframework.plani.custom.man.schedule.service.ScheduleService;
import egovframework.plani.custom.man.schedule.vo.ScheduleVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.man.log.service.ManlogService;

@Controller
@RequestMapping("/mansch")
public class ManScheduleController {

	@Resource(name = "scheduleService")
	private ScheduleService scheduleService;

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

	@RequestMapping("schList")
	public String schList(final @ModelAttribute("scheduleVO") ScheduleVO scheduleVO, Model model,
			HttpServletRequest request) throws Exception {

		int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}
		// 페이징 목록 처리
		crudTemplate.pagingList(request, model, scheduleVO, new CrudStrategy<ScheduleVO>() {
			@Override
			public int totalCount() throws Exception {
				return scheduleService.selectScheduleListTotCnt(scheduleVO);
			}

			@Override
			public List<ScheduleVO> pagingList() throws Exception {
				return scheduleService.selectScheduleList(scheduleVO);
			}
		});

		manlogService.insertManlog(request, "SCH_MAN", "달력관리", "달력 목록조회", "L");

		return "/mansch/schList";
	}

	public ScheduleVO common_form(ScheduleVO scheduleVO, Model model, HttpServletRequest request) throws Exception {

		ScheduleVO sch_vo = null;
		// srch_idx가 있따면, 게시글이 존재하는지 여부 판단.
		if (scheduleVO.getSch_idx() != 0) {
			sch_vo = scheduleService.selectSchedule(scheduleVO);
			if (sch_vo == null)
				throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST"));
		}
		return sch_vo;
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
	@RequestMapping(value = "schForm", method = RequestMethod.GET)
	public String Schform(@ModelAttribute("scheduleVO") ScheduleVO scheduleVO, Model model, HttpServletRequest request)
			throws Exception {

		// 공통함수
		ScheduleVO sch_vo = common_form(scheduleVO, model, request);
		if (sch_vo != null) {
			scheduleVO.setS_date(sch_vo.getS_date());
			scheduleVO.setE_date(sch_vo.getE_date());
			scheduleVO.setSubject(sch_vo.getSubject());
			manlogService.insertManlog(request, "SCH_MAN", "달력관리", "달력조회 [" + sch_vo.getSubject() + "]", "R");
		}

		return "/mansch/schForm";
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
	@RequestMapping(value = "schForm", method = RequestMethod.POST)
	@ResponseBody
	public Object Schform(@Valid ScheduleVO scheduleVO, BindingResult result, Model model, HttpServletRequest request)
			throws Exception {

		common_form(scheduleVO, model, request);

		// validation 적용하기.
		ResponseResultHelper responseResultHelper = new ResponseResultHelper(request, "/mansch/schForm");
		// 폼 유효성 검사
		if (result.hasErrors()) {
			return responseResultHelper.validation(result);
		}

		if (scheduleVO.getSch_idx() == 0) {
			// 등록
			scheduleService.insertSchedule(scheduleVO);
			manlogService.insertManlog(request, "SCH_MAN", "달력관리", "달력 추가 [" + scheduleVO.getSubject() + "]", "C");
		} else {
			// 수정
			scheduleService.updateSchedule(scheduleVO);
			manlogService.insertManlog(request, "SCH_MAN", "달력관리", "달력 변경 [" + scheduleVO.getSubject() + "]", "U");
		}

		return responseResultHelper.success(null, "완료되었습니다.",
				"/mansch/schList.do?srch_menu_nix=" + scheduleVO.getSrch_menu_nix(), null);
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
	@RequestMapping(value = "schDelete", method = RequestMethod.GET)
	public String schDelete(@ModelAttribute("scheduleVO") ScheduleVO scheduleVO, Model model,
			HttpServletRequest request) throws Exception {

		// 공통함수
		ScheduleVO sch_vo = common_form(scheduleVO, model, request);
		if (sch_vo == null)
			throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST"));
		scheduleService.deleteSchedule(sch_vo);
		manlogService.insertManlog(request, "SCH_MAN", "달력관리", "달력 삭제 [" + sch_vo.getSubject() + "]", "D");

		return "redirect:/mansch/schList.do?srch_menu_nix=" + scheduleVO.getSrch_menu_nix();

	}
}
