package egovframework.plani.template.man.menuctgry.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.man.menuctgry.dao.SyscategoryDAO;
import egovframework.plani.template.man.menuctgry.service.SyscategoryService;
import egovframework.plani.template.man.menuctgry.vo.SyscategoryVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("syscategoryService")
public class SyscategoryServiceImpl extends EgovAbstractServiceImpl implements SyscategoryService {

  /** SyscategoryDAO */
  @Resource(name = "syscategoryDAO")
  private SyscategoryDAO syscategoryDAO;

  /**
   * 시스템 카테고리을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int insertSyscategory(SyscategoryVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 사용자가 카테고리 순서를 직접 지정한 경우에는 해당 순서를 포함한 후순위 카테고리들의 순서를 1씩 미룬다.
    if (vo.getCtgry_ord() != 1)
      syscategoryDAO.updateSyscategoryOrderP(vo);

    return syscategoryDAO.insertSyscategory(vo);
  }

  /**
   * 시스템 카테고리을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateSyscategory(SyscategoryVO vo) throws Exception {
    // TODO Auto-generated method stub

    SyscategoryVO compVO = syscategoryDAO.selectSyscategory(vo);


    // 사용자가 카테고리 순서를 직접 지정하여 변경해야 할 경우
    if (compVO.getCtgry_ord() != vo.getCtgry_ord()) {
      // 원래 순서가 바꾸려고 하는 순서보다 앞인 경우
      if (compVO.getCtgry_ord() < vo.getCtgry_ord()) {
        // 원래 순서와 바꾸려고 하는 순서 사이에 있는 카테고리들의 순서를 1씩 앞당긴다.
        // 2순위를 5순위로 바꾸려고 하는 경우 2와 5 사이의 순서를 1씩 빼고,
        // 마지막으로 원래 바꾸려고 했던 2순위에 있는걸 원래 바꾸려고 했던 순서 5로 바꾸면 된다.
        // step 1) 1 2 3 4 5 6 7
        // step 2) 1 1 2 3 4 6 7
        // step 3) 1 5 2 3 4 6 7
        vo.setFrom_ord(compVO.getCtgry_ord());
        vo.setTo_ord(vo.getCtgry_ord());
        vo.setAdd_ord(-1);
      }

      // 원래 순서보다 바꾸려고 하는 순서가 더 뒤인 경우
      else {
        // from과 to의 순서와 해당되는 순서에 1씩 더한다는것만 다르고 동일함.
        vo.setFrom_ord(vo.getCtgry_ord());
        vo.setTo_ord(compVO.getCtgry_ord());
        vo.setAdd_ord(1);
      }
      syscategoryDAO.updateSyscategoryOrderM(vo);

      syscategoryDAO.updateSyscategory(vo);

    }

    else
      syscategoryDAO.updateSyscategory(vo);
  }


  /**
   * 시스템 카테고리을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSyscategory(SyscategoryVO vo) throws Exception {
    // TODO Auto-generated method stub
    syscategoryDAO.deleteSyscategory(vo);
  }

  /**
   * 시스템 카테고리항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public SyscategoryVO selectSyscategory(SyscategoryVO vo) throws Exception {
    // TODO Auto-generated method stub
    return syscategoryDAO.selectSyscategory(vo);
  }

  /**
   * 시스템 카테고리 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectSyscategoryList(SyscategoryVO vo) throws Exception {
    // TODO Auto-generated method stub
    return syscategoryDAO.selectSyscategoryList(vo);
  }

  /**
   * 시스템 카테고리목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectSyscategoryListTotCnt(SyscategoryVO vo) throws Exception {
    // TODO Auto-generated method stub
    return syscategoryDAO.selectSyscategoryListTotCnt(vo);
  }

}
