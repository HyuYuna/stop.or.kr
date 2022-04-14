package egovframework.plani.template.survey.service.impl;


import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.survey.dao.SrvymainDAO;
import egovframework.plani.template.survey.service.SrvymainService;
import egovframework.plani.template.survey.vo.SrvymainVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 설문 메인에 관한 CRUD를 처리한다
 * 
 * @class [ContextPath] [egovframework.plani.template.survey.service.impl]
 *        [SrvymainServiceImpl.java]
 *
 */
@Service("srvymainService")
public class SrvymainServiceImpl extends EgovAbstractServiceImpl implements SrvymainService {

  /** SrvymainDAO */
  @Resource(name = "srvymainDAO")
  private SrvymainDAO srvymainDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 설문 메인 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @param request
   * @return Integer
   * @exception Exception
   */
  @Override
  public Integer insertSrvymain(HttpServletRequest request, SrvymainVO vo) throws Exception {
    // TODO Auto-generated method stub
    int srvy_idx = srvymainDAO.insertSrvymain(vo);
    List linklist =
        atchfileService.uploadProcFormfiles(request, "SRVYPOP", new Integer(srvy_idx).toString(),
            1, "GNR");
    return srvy_idx;
  }

  /**
   * 설문 메인 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @param request
   * @exception Exception
   */
  @Override
  public void updateSrvymain(HttpServletRequest request, SrvymainVO vo) throws Exception {
    // TODO Auto-generated method stub
    srvymainDAO.updateSrvymain(vo);
    List linklist =
        atchfileService.uploadProcFormfiles(request, "SRVYPOP",
            new Integer(vo.getSrvy_idx()).toString(), 1, "GNR");
  }

  /**
   * 설문 메인 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSrvymain(SrvymainVO vo) throws Exception {
    // TODO Auto-generated method stub

    srvymainDAO.deleteSrvymain(vo);

    // 첨부파일이 있는 경우 첨부파일을 모두 삭제하기..
    AtchfileVO fileVO = new AtchfileVO();
    fileVO.setAtckey_1st("SRVYPOP");
    fileVO.setAtckey_2nd(new Integer(vo.getSrvy_idx()).toString());
    fileVO.setAtckey_3rd(1);
    atchfileService.deleteAtchfiles(fileVO);

  }

  /**
   * 설문 메인 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return SrvymainVO
   * @exception Exception
   */
  @Override
  public SrvymainVO selectSrvymain(SrvymainVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvymainDAO.selectSrvymain(vo);
  }

  /**
   * 설문 메인 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectSrvymainList(SrvymainVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvymainDAO.selectSrvymainList(vo);
  }

  /**
   * 설문 메인목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectSrvymainListTotCnt(SrvymainVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvymainDAO.selectSrvymainListTotCnt(vo);
  }

  /**
   * 설문 메인 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List xlsSrvymainList(SrvymainVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvymainDAO.xlsSrvymainList(vo);
  }

}
