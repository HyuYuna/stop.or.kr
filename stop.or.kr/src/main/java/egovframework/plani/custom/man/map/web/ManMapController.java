package egovframework.plani.custom.man.map.web;

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

import egovframework.plani.custom.man.map.service.MapService;
import egovframework.plani.custom.man.map.vo.MapVO;
import egovframework.plani.custom.man.map.vo.ZipcodeVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.man.log.service.ManlogService;

@Controller
@RequestMapping("/manmap")
public class ManMapController {

	@Resource(name = "mapService")
	private MapService mapService;

	@Resource
	private CrudTemplate crudTemplate;

	/** ManlogService */
	@Resource(name = "manlogService")
	protected ManlogService manlogService;

	/**
	 * 기관정보 main mapList
	 * 
	 * @param ZipcodeVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */
	@RequestMapping(value = "mapList")
	public String mapList(@ModelAttribute("mapVO") final MapVO mapVO, Model model, HttpServletRequest request)
			throws Exception {

		int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}
		mapVO.setSrch_mu_gub("MAN");
		// 페이징 목록 처리
		crudTemplate.pagingList(request, model, mapVO, new CrudStrategy<MapVO>() {
			@Override
			public int totalCount() throws Exception {
				return mapService.selectMapListTotCnt(mapVO);
			}

			@Override
			public List<MapVO> pagingList() throws Exception {
				return mapService.selectMapList(mapVO);
			}
		});

		manlogService.insertManlog(request, "MAP_MAN", "지원기관 관리", "지원관리 조회", "L");

		return "/manmap/mapList";

	}

	public MapVO common_form(MapVO mapvo, Model model, HttpServletRequest request) throws Exception {

		MapVO map_vo = null;
		// srch_idx가 있따면, 게시글이 존재하는지 여부 판단.
		if (mapvo.getMap_idx() != 0) {
			map_vo = mapService.selectMidMap(mapvo);
			if (map_vo == null)
				throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST"));
		}
		return map_vo;
	}

	/**
	 * 기관정보 main mapForm
	 * 
	 * @param ZipcodeVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */
	@RequestMapping(value = "mapForm", method = RequestMethod.GET)
	public String mapForm(@ModelAttribute("mapVO") MapVO mapVO, Model model, HttpServletRequest request)
			throws Exception {

		MapVO map = common_form(mapVO, model, request);
		ZipcodeVO zipcode = new ZipcodeVO();

		List sidolist = null;
		List gugunlist = null;

		if (map != null) {
			zipcode.setSido(map.getSido());
			zipcode.setGugun(map.getGugun());
		}

		sidolist = mapService.selectMapSidoList(zipcode);

		if (zipcode.getSido() != null) {
			gugunlist = mapService.selectMapGugunList(zipcode);

		}

		model.addAttribute("sidolist", sidolist);
		model.addAttribute("gugunlist", gugunlist);

		if (map != null) {
			mapVO.setCategory(map.getCategory());
			mapVO.setAddr(map.getAddr());
			mapVO.setName(map.getName());
			mapVO.setSido(map.getSido());
			mapVO.setGugun(map.getGugun());
			mapVO.setTel(map.getTel());
			mapVO.setWdt(map.getWdt());
			mapVO.setUrlx(map.getUrlx());
			mapVO.setUrly(map.getUrly());
		}
		return "/manmap/mapForm";

	}

	/**
	 * 기관정보 쓰기 페이지 저장
	 * 
	 * @param ZipcodeVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */
	@RequestMapping(value = "mapForm", method = RequestMethod.POST)
	@ResponseBody
	public Object mapForm(@Valid MapVO mapVO, BindingResult result, Model model, HttpServletRequest request)
			throws Exception {

		common_form(mapVO, model, request);

		// validation 적용하기.
		ResponseResultHelper responseResultHelper = new ResponseResultHelper(request, "/manmap/mapForm");
		// 폼 유효성 검사
		if (result.hasErrors()) {
			return responseResultHelper.validation(result);
		}

		if (mapVO.getMap_idx() == 0) {
			mapService.insertMap(mapVO);
			manlogService.insertManlog(request, "MAP_MAN", "지원기관관리", "지원기관 추가 [" + mapVO.getName() + "]", "C");
		} else {
			// 업데이트
			mapService.updateMap(mapVO);
			manlogService.insertManlog(request, "MAP_MAN", "지원기관관리", "지원기관  변경 [" + mapVO.getName() + "]", "U");
		}

		return responseResultHelper.success(null, "완료되었습니다.",
				"/manmap/mapList.do?srch_menu_nix=" + mapVO.getSrch_menu_nix(), null);
	}

	/**
	 * 기관정보 ajax gugun search
	 * 
	 * @param ZipcodeVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */
	@RequestMapping(value = "mapSearchGugunList")
	@ResponseBody
	public List mapSearchGugunList(@ModelAttribute("zipcodeVO") ZipcodeVO zipcodeVO, Model model,
			HttpServletRequest request) throws Exception {

		// List sido = mapService.selectMapSidoList(zipcodeVO);
		List gugun = null;
		if (zipcodeVO.getSido() != null) {
			gugun = mapService.selectMapGugunList(zipcodeVO);

		}
		return gugun;
	}

	/**
	 * 기관정보 DELETE
	 * 
	 * @param MapVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */
	@RequestMapping(value = "mapDelete")
	public String mapDelete(@ModelAttribute("mapVO") MapVO mapVO, Model model, HttpServletRequest request)
			throws Exception {

		MapVO map = common_form(mapVO, model, request);

		if (map == null)
			throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST"));

		mapService.deleteMap(mapVO);
		manlogService.insertManlog(request, "MAP_MAN", "지원기관관리", "지원기관 삭제 [" + map.getName() + "]", "D");

		return "redirect:/manmap/mapList.do?srch_menu_nix=" + mapVO.getSrch_menu_nix();
	}

}
