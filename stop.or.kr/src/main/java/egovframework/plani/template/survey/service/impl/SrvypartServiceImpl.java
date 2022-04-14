package egovframework.plani.template.survey.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.survey.dao.SrvypartDAO;
import egovframework.plani.template.survey.service.SrvypartService;
import egovframework.plani.template.survey.vo.SrvypartVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 설문 파트에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.survey.service.impl]
 *        [SrvypartServiceImpl.java]
 *
 */

@Service("srvypartService")
public class SrvypartServiceImpl extends EgovAbstractServiceImpl implements SrvypartService {

  /** SrvypartDAO */
  @Resource(name = "srvypartDAO")
  private SrvypartDAO srvypartDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 설문 파트 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public Integer insertSrvypart(SrvypartVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 일반파트인 경우 개인정보 안내메시지 삭제
    if ("CDIDX00063".equals(vo.getPart_type()))
      vo.setPart_psn_info("");

    return srvypartDAO.insertSrvypart(vo);
  }

  /**
   * 설문 파트 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateSrvypart(SrvypartVO vo) throws Exception {
    // TODO Auto-generated method stub
    // 일반파트인 경우 개인정보 안내메시지 삭제
    if ("CDIDX00063".equals(vo.getPart_type()))
      vo.setPart_psn_info("");

    srvypartDAO.updateSrvypart(vo);
  }

  /**
   * 설문 파트 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSrvypart(SrvypartVO vo) throws Exception {
    // TODO Auto-generated method stub

    /*
     * // 첨부파일이 있는 경우 첨부파일을 모두 삭제하기.. AtchfileVO fileVO = new AtchfileVO();
     * fileVO.setAtckey_1st("BBB"); fileVO.setAtckey_2nd(new Integer(vo.get~~~).toString());
     * fileVO.setAtckey_3rd(1); atchfileService.deleteAtchfiles(fileVO);
     */

    srvypartDAO.deleteSrvypart(vo);
  }

  /**
   * 설문 파트 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return SrvypartVO
   * @exception Exception
   */
  @Override
  public SrvypartVO selectSrvypart(SrvypartVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvypartDAO.selectSrvypart(vo);
  }

  /**
   * 설문 파트 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectSrvypartList(SrvypartVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvypartDAO.selectSrvypartList(vo);
  }

  /**
   * 설문 챕터목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectSrvypartListTotCnt(SrvypartVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvypartDAO.selectSrvypartListTotCnt(vo);
  }

  /**
   * 설문 파트 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List xlsSrvypartList(SrvypartVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvypartDAO.xlsSrvypartList(vo);
  }

}
