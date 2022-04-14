package egovframework.plani.template.project.service.impl;

import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.FileVO;
import egovframework.dev.cmm.service.CmmMap;
import egovframework.dev.cmm.service.CmmService;
import egovframework.plani.template.project.dao.ProjectDAO;
import egovframework.plani.template.project.service.ProjectService;
import egovframework.plani.template.project.vo.ProjectVO;

@Service("projectService")
public class ProjectServiceImpl implements ProjectService {

  @Resource(name = "projectDAO")
  private ProjectDAO projectDAO;

  @Override
  public List<ProjectVO> selectProjectList(ProjectVO vo) throws Exception {
    // TODO Auto-generated method stub
    return projectDAO.selectProjectList(vo);
  }

  @Override
  public int selectProjectListTotCnt(ProjectVO vo) throws Exception {
    // TODO Auto-generated method stub
    return projectDAO.selectProjectListTotCnt(vo);
  }

	@Override
	public List<ProjectVO> selectExcelList(ProjectVO vo) throws Exception {
		// TODO Auto-generated method stub
		return projectDAO.selectExcelList(vo);
	}
	
	@Override
  public Integer insertProjectBoardData(CmmMap param) throws Exception {
		return projectDAO.insertProjectBoardData(param);
  }
	
	@Override
  public void insertSelectProjectBoardLog(CmmMap param) throws Exception {
	projectDAO.insertSelectProjectBoardLog(param);
  }

  public CmmMap selectProjectBoardDataStats(CmmMap param) throws Exception {
	  return projectDAO.selectProjectBoardDataStats(param);
  }
  
  public CmmMap selectProjectBoardData(CmmMap param) throws Exception {
	  return projectDAO.selectProjectBoardData(param);
  }
  
  public List<CmmMap> selectProjectBoardFileList(CmmMap param) throws Exception {
	  return projectDAO.selectProjectBoardFileList(param);
  }
  
  public void updateProjectBoardDataRes(CmmMap param) throws Exception {
	  projectDAO.updateProjectBoardDataRes(param);
  }
  
  public void updateProjectBoardDataReq(CmmMap param) throws Exception {
	  projectDAO.updateProjectBoardDataReq(param);
  }
  
  public void insertProjectBoardFile(CmmMap param) throws Exception {
	  projectDAO.insertProjectBoardFile(param);
  }
  
  public void deleteProjectBoardFile(CmmMap param) throws Exception {
	  projectDAO.deleteProjectBoardFile(param);
  }
  
  public void deleteProjectBoardData(CmmMap param) throws Exception {
	  projectDAO.deleteProjectBoardData(param);
  }
  
  public String insertFileInfs(List<?> fileList) throws Exception {
		String atchFileId = "";

		if (fileList.size() != 0) {
			
			FileVO vo = (FileVO) fileList.get(0);
			atchFileId = vo.getAtchFileId();

			Iterator<?> iter = fileList.iterator();
			while (iter.hasNext()) {
				vo = (FileVO) iter.next();

				projectDAO.insertFileDetail(vo);
			}
		}
		if (atchFileId == "") {
			atchFileId = null;
		}
		return atchFileId;
	}

  public FileVO selectFileInf(FileVO fvo) throws Exception{
	  return projectDAO.selectFileInf(fvo);
  }
}
