package egovframework.plani.template.multicms.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.multicms.dao.MultiCmsDAO;
import egovframework.plani.template.multicms.service.MultiCmsService;
import egovframework.plani.template.multicms.vo.MultiCmsVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 게시물목록에 관한 CURD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.multicms.service.impl]
 *        [MultiCmsServiceImpl.java]
 *
 */
@Service("multiCmsService")
public class MultiCmsServiceImpl extends EgovAbstractServiceImpl implements MultiCmsService {

  /** multiCmsDAO */
  @Resource(name = "multiCmsDAO")
  private MultiCmsDAO multiCmsDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 게시물목록을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  @Override
  public Integer insertMultiCms(MultiCmsVO vo) throws Exception {
    // TODO Auto-generated method stub
    return multiCmsDAO.insertMultiCms(vo);
  }

  /**
   * 게시물목록을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateMultiCms(MultiCmsVO vo) throws Exception {
    // TODO Auto-generated method stub

    multiCmsDAO.updateMultiCms(vo);
  }

  /**
   * 게시물목록을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteMultiCms(MultiCmsVO vo) throws Exception {


    // TODO: 첨부파일 전체 삭제
    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st("MULTI_CMS");
    fvo.setAtckey_2nd(new Integer(vo.getMc_seq()).toString());
    fvo.setAtckey_3rd(1);
    atchfileService.deleteAtchfiles(fvo);

    AtchfileVO fvo_f = new AtchfileVO();
    fvo_f.setAtckey_1st("MULTI_CMS");
    fvo_f.setAtckey_2nd(new Integer(vo.getMc_seq()).toString());
    fvo_f.setAtckey_3rd(2);
    atchfileService.deleteAtchfiles(fvo_f);



    multiCmsDAO.deleteMultiCms(vo);
  }

  /**
   * 게시물목록항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return MultiCmsVO
   * @exception Exception
   */
  @Override
  public MultiCmsVO selectMultiCms(MultiCmsVO vo) throws Exception {
    // TODO Auto-generated method stub
    return multiCmsDAO.selectMultiCms(vo);
  }



  /**
   * 게시물목록 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectMultiCmsList(MultiCmsVO vo) throws Exception {
    // TODO Auto-generated method stub
    return multiCmsDAO.selectMultiCmsList(vo);
  }

  /**
   * 게시물목록목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectMultiCmsListTotCnt(MultiCmsVO vo) throws Exception {
    // TODO Auto-generated method stub
    return multiCmsDAO.selectMultiCmsListTotCnt(vo);
  }


}
