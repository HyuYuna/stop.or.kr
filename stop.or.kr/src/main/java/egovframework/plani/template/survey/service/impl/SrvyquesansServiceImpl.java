package egovframework.plani.template.survey.service.impl;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.survey.dao.SrvyquesansDAO;
import egovframework.plani.template.survey.service.SrvyquesansService;
import egovframework.plani.template.survey.vo.SrvyquesansVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 설문 질문/답변에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.survey.service.impl]
 *        [SrvyquesansServiceImpl.java]
 *
 */
@Service("srvyquesansService")
public class SrvyquesansServiceImpl extends EgovAbstractServiceImpl implements SrvyquesansService {

  /** SrvyquesansDAO */
  @Resource(name = "srvyquesansDAO")
  private SrvyquesansDAO srvyquesansDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 설문 질문 / 답변 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void mergeSrvyquesans(HttpServletRequest request, SrvyquesansVO vo) throws Exception {
    // TODO Auto-generated method stub

    int[] arr_ques_idx = vo.getArr_ques_idx();
    int[] arr_quesans_idx = vo.getArr_quesans_idx();
    String[] arr_quesans_cont = vo.getArr_quesans_cont();
    String[] arr_quesans_type = vo.getArr_quesans_type();
    // int[] arr_ans_ord = vo.getArr_ans_ord();
    String[] arr_ans_need_spl = vo.getArr_ans_need_spl();

    int ans_ord = 0;
    if (arr_ques_idx != null) {
      int ques_idx = 0;
      for (int i = 0; i < arr_quesans_cont.length; i++) {
        if (i == 0) {
          ques_idx = arr_ques_idx[0];

          // 질문번호가 생성되지 않은 경우 생성한다.
          if (ques_idx == 0)
            ques_idx = srvyquesansDAO.selectSrvyquesansQuesidx(vo);
        }

        SrvyquesansVO insVO = new SrvyquesansVO();

        insVO.setQues_idx(ques_idx);
        insVO.setQuesans_idx(arr_quesans_idx[i]);
        insVO.setSrvy_idx(vo.getSrvy_idx());
        insVO.setPart_idx(vo.getPart_idx());
        insVO.setQuesans_type(arr_quesans_type[i]);
        insVO.setQuesans_cont(arr_quesans_cont[i]);
        insVO.setQues_type(vo.getQues_type());
        insVO.setAns_need_spl(arr_ans_need_spl[i]);
        insVO.setAns_ord(ans_ord);
        insVO.setWriter(vo.getWriter());

        if (arr_quesans_cont[i] == null || "".equals(arr_quesans_cont[i].trim())) {
          // srvyquesansDAO.deleteSrvyquesans(insVO);
        } else {
          srvyquesansDAO.mergeSrvyquesans(insVO);
          ans_ord++;
        }
      }

      // 질문 타입이 만족도 선택형이나 선호도 선택형이 아닌 경우 관계된 첨부 파일을 삭제한다.
      if (!vo.getQues_type().equals("CDIDX00085") && !vo.getQues_type().equals("CDIDX00086")) {
        AtchfileVO atchfileVO = new AtchfileVO();
        atchfileVO.setAtckey_1st("SRVY_QUESANS");
        atchfileVO.setAtckey_2nd(new Integer(vo.getSrvy_idx()).toString());
        atchfileVO.setAtckey_3rd(ques_idx);
        for (int i = 0; i < arr_quesans_cont.length; i++) {
          atchfileVO.setAtckey_4th(i);
          atchfileService.deleteAtchFilePair(atchfileVO);
        }
      }

      List linklist =
          atchfileService.uploadProcFormfiles(request, "SRVY_QUESANS",
              new Integer(vo.getSrvy_idx()).toString(), ques_idx, "GNR");

    }


  }


  /**
   * 설문 질문 / 답변 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSrvyquesans(SrvyquesansVO vo) throws Exception {
    // TODO Auto-generated method stub

    /*
     * // 첨부파일이 있는 경우 첨부파일을 모두 삭제하기.. AtchfileVO fileVO = new AtchfileVO();
     * fileVO.setAtckey_1st("BBB"); fileVO.setAtckey_2nd(new Integer(vo.get~~~).toString());
     * fileVO.setAtckey_3rd(1); atchfileService.deleteAtchfiles(fileVO);
     */
    srvyquesansDAO.deleteSrvyquesans(vo);

    // 순서가 비면 안되기때문에
    // 순서를 채워준다.
    srvyquesansDAO.updateSrvyquesansOrd(vo);
  }


  /**
   * 설문 질문 / 답변 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSrvyquesansGroup(SrvyquesansVO vo) throws Exception {
    // TODO Auto-generated method stub

    /*
     * // 첨부파일이 있는 경우 첨부파일을 모두 삭제하기.. AtchfileVO fileVO = new AtchfileVO();
     * fileVO.setAtckey_1st("BBB"); fileVO.setAtckey_2nd(new Integer(vo.get~~~).toString());
     * fileVO.setAtckey_3rd(1); atchfileService.deleteAtchfiles(fileVO);
     */

    srvyquesansDAO.deleteSrvyquesansGroup(vo);
  }

  /**
   * 설문 질문 / 답변 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return SrvyquesansVO
   * @exception Exception
   */
  @Override
  public SrvyquesansVO selectSrvyquesans(SrvyquesansVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvyquesansDAO.selectSrvyquesans(vo);
  }

  /**
   * 설문 질문 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectSrvyquesList(SrvyquesansVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvyquesansDAO.selectSrvyquesList(vo);
  }

  /**
   * 설문 질문 / 답변 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectSrvyquesansList(SrvyquesansVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvyquesansDAO.selectSrvyquesansList(vo);
  }

  /**
   * 설문 질문 / 답변목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectSrvyquesansListTotCnt(SrvyquesansVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvyquesansDAO.selectSrvyquesansListTotCnt(vo);
  }

  /**
   * 설문 질문 / 답변 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List xlsSrvyquesansList(SrvyquesansVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvyquesansDAO.xlsSrvyquesansList(vo);
  }

  /**
   * 설문 결과를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectSrvyquesansResult(SrvyquesansVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvyquesansDAO.selectSrvyquesansResult(vo);
  }


  /**
   * 설문 질문 / 답변 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectXlsSrvyquesansList(SrvyquesansVO vo) {
    // TODO Auto-generated method stub
    return srvyquesansDAO.selectXlsSrvyquesansList(vo);
  }

}
