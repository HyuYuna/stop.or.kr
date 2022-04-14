package egovframework.plani.template.man.metsys.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.man.metsys.dao.ContentsmanDAO;
import egovframework.plani.template.man.metsys.service.ContentsmanService;
import egovframework.plani.template.man.metsys.vo.ContentsmanVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 컨텐츠 관리에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.service.impl]
 *        [ContentsmanServiceImpl.java]
 *
 */
@Service("contentsmanService")
public class ContentsmanServiceImpl extends EgovAbstractServiceImpl implements ContentsmanService {

  /** ContentsmanDAO */
  @Resource(name = "contentsmanDAO")
  private ContentsmanDAO contentsmanDAO;


  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;


  /**
   * 컨텐츠 관리을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @param String
   * @exception Exception
   */
  @Override
  public int insertContentsman(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub

    return contentsmanDAO.insertContentsman(vo);
  }

  /**
   * 컨텐츠 관리을/를 등록한다. (새로운 버전으로 등록)
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @param Integer
   * @exception Exception
   */
  @Override
  public Integer insertContentsmanNewver(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub

    int oldkey = vo.getUcont_version();
    int newkey = contentsmanDAO.insertContentsmanNewver(vo);

    AtchfileVO fileVO = new AtchfileVO();
    fileVO.setAtckey_1st(EgovProperties.CONTENTS_UPLOAD_KEY);
    fileVO.setAtckey_2nd(vo.getUcont_id());
    fileVO.setAtckey_3rd(oldkey);

    atchfileService.insertAndCopyfiles(fileVO, newkey);

    return newkey;
  }

  /**
   * 컨텐츠 관리을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateContentsman(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub
    contentsmanDAO.updateContentsman(vo);
  }

  /**
   * 컨텐츠 관리을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateContentsmanMenunix(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub
    contentsmanDAO.updateContentsmanMenunix(vo);
  }

  /**
   * 컨텐츠 관리을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateContentsmanMenunixNull(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub
    contentsmanDAO.updateContentsmanMenunixNull(vo);
  }

  /**
   * 컨텐츠 관리을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteContentsman(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub
    contentsmanDAO.deleteContentsman(vo);
  }

  /**
   * 컨텐츠 관리항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return ContentsmanVO
   * @exception Exception
   */
  @Override
  public ContentsmanVO selectContentsman(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub
    return contentsmanDAO.selectContentsman(vo);
  }

  /**
   * 컨텐츠 관리 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectContentsmanList(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub
    return contentsmanDAO.selectContentsmanList(vo);
  }


  /**
   * 컨텐츠 관리 목록(메뉴연결목록)을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectContentsmanmenuList(ContentsmanVO vo) throws Exception {
    return contentsmanDAO.selectContentsmanmenuList(vo);
  }

  /**
   * 컨텐츠 관리 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectContentsmanRefmenuList(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub
    return contentsmanDAO.selectContentsmanRefmenuList(vo);
  }

  /**
   * 컨텐츠 관리목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectContentsmanListTotCnt(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub
    return contentsmanDAO.selectContentsmanListTotCnt(vo);
  }


  /**
   * 컨텐츠의 버전을 복원한다.
   * 
   * @param contentsmanVO : 복원할 정보
   * @exception Exception
   */
  @Override
  public void restoreContentsman(ContentsmanVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 상위버전에 첨부된 파일들을 삭제한다.
    List delList = contentsmanDAO.selectContentsmanRestorelist(vo);

    for (int i = 0; i < delList.size(); i++) {
      ContentsmanVO dvo = (ContentsmanVO) delList.get(i);
      AtchfileVO fileVO = new AtchfileVO();
      fileVO.setAtckey_1st(EgovProperties.CONTENTS_UPLOAD_KEY);
      fileVO.setAtckey_2nd(dvo.getUcont_id());
      fileVO.setAtckey_3rd(dvo.getUcont_version());
      atchfileService.deleteAtchfiles(fileVO);
    }

    contentsmanDAO.restoreContentsman(vo);

  }


}
