package egovframework.plani.template.project.service;

import java.util.List;

import egovframework.com.cmm.service.FileVO;
import egovframework.dev.cmm.service.CmmMap;
import egovframework.plani.template.project.vo.ProjectVO;


public interface ProjectService {

 
  /**
   * 뉴스레터 정보를 조회한다
   * 
   * @param vo-스케쥴 정보가 담긴 vo
   * @exception - Exception
   */
  public List<ProjectVO> selectProjectList(ProjectVO vo) throws Exception;

  /**
   * 뉴스레터 정보 목록의 총 개수를 구한다.
   * 
   * @param projectVO - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectProjectListTotCnt(ProjectVO vo) throws Exception;


	/**
	 * 뉴스레터 정보를 조회한다
	 * 
	 * @param vo-스케쥴
	 *            정보가 담긴 vo
	 * @exception -
	 *                Exception
	 */
	public List<ProjectVO> selectExcelList(ProjectVO vo) throws Exception;
	
	public Integer insertProjectBoardData(CmmMap param) throws Exception;
	public void insertSelectProjectBoardLog(CmmMap param) throws Exception;
	public CmmMap selectProjectBoardDataStats(CmmMap param) throws Exception;
	public CmmMap selectProjectBoardData(CmmMap param) throws Exception;
	public void updateProjectBoardDataRes(CmmMap param) throws Exception;
	public void updateProjectBoardDataReq(CmmMap param) throws Exception;
	public void insertProjectBoardFile(CmmMap param) throws Exception;
	public void deleteProjectBoardFile(CmmMap param) throws Exception;
	public void deleteProjectBoardData(CmmMap param) throws Exception;
	public String insertFileInfs(List<?> fvoList) throws Exception;
	public List<CmmMap> selectProjectBoardFileList(CmmMap param) throws Exception;
	public FileVO selectFileInf(FileVO fvo) throws Exception;
}
