package egovframework.plani.template.release.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.release.dao.ReleaseDAO;
import egovframework.plani.template.release.service.ReleaseService;
import egovframework.plani.template.release.vo.ReleaseVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 정보공개목록에 관한 CURD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.release.service.impl]
 *        [ReleaseServiceImpl.java]
 *
 */
@Service("releaseService")
public class ReleaseServiceImpl extends EgovAbstractServiceImpl implements ReleaseService {

  /** ReleaseDAO */
  @Resource(name = "releaseDAO")
  private ReleaseDAO releaseDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 정보공개목록을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  @Override
  public Integer insertRelease(ReleaseVO vo) throws Exception {
    // TODO Auto-generated method stub
    return releaseDAO.insertRelease(vo);
  }

  /**
   * 정보공개목록을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateRelease(ReleaseVO vo) throws Exception {
    // TODO Auto-generated method stub

    releaseDAO.updateRelease(vo);
  }

  /**
   * 정보공개목록을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteRelease(ReleaseVO vo) throws Exception {
    // TODO Auto-generated method stub

    // TODO: 첨부파일 전체 삭제
    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st("Release");
    fvo.setAtckey_2nd(new Integer(vo.getRel_seq()).toString());
    fvo.setAtckey_3rd(1);
    atchfileService.deleteAtchfiles(fvo);

    releaseDAO.deleteRelease(vo);
  }

  /**
   * 정보공개목록항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return ReleaseVO
   * @exception Exception
   */
  @Override
  public ReleaseVO selectRelease(ReleaseVO vo) throws Exception {
    // TODO Auto-generated method stub
    return releaseDAO.selectRelease(vo);
  }

  /**
   * 정보공개목록항목을(공지) 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return ReleaseVO
   * @exception Exception
   */
  @Override
  public List selectNoticeReleaseList(ReleaseVO vo) throws Exception {
    // TODO Auto-generated method stub
    return releaseDAO.selectNoticeReleaseList(vo);
  }



  /**
   * 정보공개목록 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectReleaseList(ReleaseVO vo) throws Exception {
    // TODO Auto-generated method stub
    return releaseDAO.selectReleaseList(vo);
  }

  /**
   * 정보공개목록목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectReleaseListTotCnt(ReleaseVO vo) throws Exception {
    // TODO Auto-generated method stub
    return releaseDAO.selectReleaseListTotCnt(vo);
  }


}
