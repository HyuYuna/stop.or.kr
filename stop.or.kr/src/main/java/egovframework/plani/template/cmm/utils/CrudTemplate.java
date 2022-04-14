package egovframework.plani.template.cmm.utils;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 
 * LIST, CRUD를 구현함에 있어 반복된 코드를 줄이고자 "템플릿/콜백"패턴을 활용
 * 
 * @author gangja
 *
 */
@Component
public class CrudTemplate {

	@Resource(name = "propertiesService")
	private EgovPropertyService propertiesService;

	private PlaniPaginationInfo paginationInfo;

	CrudTemplate() {
		this.setPaginationInfo(new PlaniPaginationInfo());
	}

	public void setPaginationInfo(PlaniPaginationInfo paginationInfo) {
		this.paginationInfo = paginationInfo;
	}

	/**
	 * 목록 페이징에 전달하고자 하는 DTO 객체 초기화 처리
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @param dto
	 *            페이징 처리를 위한 필요한 속성을 가진 DTO 객체
	 * @return 페이징 처리에서 요구되는 속성으로 변경된 DTO 객체
	 */
	public <T extends DefaultSearchVO> T pagingInitDto(HttpServletRequest request, T dto) {

		if (dto.getPageSize() == 0) { // 페이징 번호 개수
			dto.setPageSize(propertiesService.getInt("pageSize"));
		}

		if (dto.getPageUnit() == 0) { // 페이지당 게시물 수
			dto.setPageUnit(propertiesService.getInt("pageUnit"));
		}

		paginationInfo.setContextPath(request.getContextPath());
		paginationInfo.setCurrentPageNo(dto.getPageIndex());
		paginationInfo.setRecordCountPerPage(dto.getPageUnit());
		paginationInfo.setPageSize(dto.getPageSize());

		dto.setFirstIndex(paginationInfo.getFirstRecordIndex());
		dto.setLastIndex(paginationInfo.getLastRecordIndex());
		dto.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// 기간 검색
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String nowdt = sf.format(new Date());
		if (StringUtils.isBlank(dto.getSrchFromDT()) || StringUtils.isBlank(dto.getSrchToDT())) {
			dto.setSrchFromDT(nowdt);
			dto.setSrchToDT(nowdt);
		}

		return dto;
	}

	/**
	 * 목록 페이징 처리
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @param model
	 *            뷰에서 사용하는 모델
	 * @param dto
	 *            페이징 처리를 위한 필요한 속성을 가진 DTO 객체
	 * @param crudStrategy
	 *            실제 비지니스를 수행하는 클래스
	 * @return 데이터 List<DTO> 목록
	 * @throws Exception
	 */
	public <T extends DefaultSearchVO> List<T> pagingList(HttpServletRequest request, Model model, T dto,
			CrudStrategy<T> crudStrategy) throws Exception {

		this.pagingInitDto(request, dto);

		paginationInfo.setTotalRecordCount(crudStrategy.totalCount());

		List<T> dataList = crudStrategy.pagingList();
		model.addAttribute("resultList", dataList);
		model.addAttribute("paginationInfo", paginationInfo);

		NumberFormat nf = NumberFormat.getInstance();
		model.addAttribute("curPage", nf.format(paginationInfo.getCurrentPageNo()));
		model.addAttribute("totCnt", paginationInfo.getTotalRecordCount());
		model.addAttribute("totPage", nf.format(paginationInfo.getTotalPageCount()));

		return dataList;
	}

}
