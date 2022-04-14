package egovframework.plani.template.man.menuctgry.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.man.menuctgry.dao.SyscodeDAO;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.vo.SyscodeVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("syscodeService")
public class SyscodeServiceImpl extends EgovAbstractServiceImpl implements SyscodeService {

  /** SyscodeDAO */
  @Resource(name = "syscodeDAO")
  private SyscodeDAO syscodeDAO;

  /**
   * 코드 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int insertSyscode(SyscodeVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 사용자가 코드 순서를 직접 지정한 경우에는 해당 순서를 포함한 후순위 코드들의 순서를 1씩 미룬다.
    if (vo.getCode_ord() != 1)
      syscodeDAO.updateSyscodeOrderP(vo);


    return syscodeDAO.insertSyscode(vo);
  }

  /**
   * 코드 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateSyscode(SyscodeVO vo) throws Exception {
    // TODO Auto-generated method stub

    SyscodeVO compVO = syscodeDAO.selectSyscode(vo);

    // 사용자가 코드 순서를 직접 지정하여 변경해야 할 경우
    if (compVO.getCode_ord() != vo.getCode_ord()) {
      // 원래 순서가 바꾸려고 하는 순서보다 앞인 경우
      if (compVO.getCode_ord() < vo.getCode_ord()) {
        // 원래 순서와 바꾸려고 하는 순서 사이에 있는 코드들의 순서를 1씩 앞당긴다.
        // 2순위를 5순위로 바꾸려고 하는 경우 2와 5 사이의 순서를 1씩 빼고,
        // 마지막으로 원래 바꾸려고 했던 2순위에 있는걸 원래 바꾸려고 했던 순서 5로 바꾸면 된다.
        // step 1) 1 2 3 4 5 6 7
        // step 2) 1 1 2 3 4 6 7
        // step 3) 1 5 2 3 4 6 7
        vo.setFrom_ord(compVO.getCode_ord());
        vo.setTo_ord(vo.getCode_ord());
        vo.setAdd_ord(-1);
      }

      // 원래 순서보다 바꾸려고 하는 순서가 더 뒤인 경우
      else {
        // from과 to의 순서와 해당되는 순서에 1씩 더한다는것만 다르고 동일함.
        vo.setFrom_ord(vo.getCode_ord());
        vo.setTo_ord(compVO.getCode_ord());
        vo.setAdd_ord(1);
      }
      syscodeDAO.updateSyscodeOrderM(vo);

      syscodeDAO.updateSyscode(vo);

    }

    else
      syscodeDAO.updateSyscode(vo);
  }

  /**
   * 코드 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSyscode(SyscodeVO vo) throws Exception {
    // TODO Auto-generated method stub
    syscodeDAO.deleteSyscode(vo);
  }

  /**
   * 코드 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public SyscodeVO selectSyscode(SyscodeVO vo) throws Exception {
    // TODO Auto-generated method stub
    return syscodeDAO.selectSyscode(vo);
  }

  /**
   * 코드 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectSyscodeList(SyscodeVO vo) throws Exception {
    // TODO Auto-generated method stub
    return syscodeDAO.selectSyscodeList(vo);
  }

  /**
   * 코드목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectSyscodeListTotCnt(SyscodeVO vo) throws Exception {
    // TODO Auto-generated method stub
    return syscodeDAO.selectSyscodeListTotCnt(vo);
  }

  /**
   * 코드 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List xlsSyscodeList(SyscodeVO vo) throws Exception {
    // TODO Auto-generated method stub
    return syscodeDAO.xlsSyscodeList(vo);
  }

}
