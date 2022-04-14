package egovframework.plani.template.survey.service.impl;

import java.util.List;
import java.util.StringTokenizer;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.survey.dao.SrvydataDAO;
import egovframework.plani.template.survey.service.SrvydataService;
import egovframework.plani.template.survey.vo.SrvydataVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 설문 데이터에 관한 CRUD를 처리한다
 * 
 * @class [ContextPath] [egovframework.plani.template.survey.service.impl]
 *        [SrvydataServiceImpl.java]
 *
 */
@Service("srvydataService")
public class SrvydataServiceImpl extends EgovAbstractServiceImpl implements SrvydataService {

  /** SrvydataDAO */
  @Resource(name = "srvydataDAO")
  private SrvydataDAO srvydataDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 설문 데이터 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void insertSrvydata(SrvydataVO vo) throws Exception {
    // TODO Auto-generated method stub

    int[] arr_ques_idx = vo.getArr_ques_idx();
    String[] arr_ques_type = vo.getArr_ques_type();
    String[] arr_answer = vo.getArr_answer();

    int data_idx = srvydataDAO.selectSrvydataKey(vo);
    vo.setData_idx(data_idx);

    if (arr_ques_idx != null) {
      for (int i = 0; i < arr_ques_idx.length; i++) {
        vo.setQuessub_idx(1);
        vo.setData_spl("");
        vo.setData_cont("");

        // 객관식 단답형
        if ("CDIDX00082".equals(arr_ques_type[i])) {
          vo.setQues_idx(arr_ques_idx[i]);

          // 선택된 값과 추가답변이 ##으로 이어져 있음..

          if (arr_answer[i].indexOf("##") >= 0) {
            StringTokenizer stok = new StringTokenizer(arr_answer[i], "##");
            if (stok.countTokens() == 2) {
              vo.setData_cont(stok.nextToken());
              vo.setData_spl(stok.nextToken());
            }
          } else
            vo.setData_cont(arr_answer[i]);

          srvydataDAO.insertSrvydata(vo);

        }
        // 객관식 복수형
        else if ("CDIDX00083".equals(arr_ques_type[i])) {
          vo.setQues_idx(arr_ques_idx[i]);
          int subidx = 1;

          // 여러개 선택된 값이 ##으로 이어져 있음..
          StringTokenizer stok = new StringTokenizer(arr_answer[i], "##");
          while (stok.hasMoreTokens()) {
            vo.setQuessub_idx(subidx++);
            vo.setData_cont(stok.nextToken());

            srvydataDAO.insertSrvydata(vo);
          }

        }
        // 주관식 단답형
        else if ("CDIDX00084".equals(arr_ques_type[i]) || "CDIDX00085".equals(arr_ques_type[i])) {
          vo.setQues_idx(arr_ques_idx[i]);
          vo.setData_cont(arr_answer[i]);

          srvydataDAO.insertSrvydata(vo);
        }
        // 만족도 선택형
        /*
         * else if ("CDIDX00085".equals(arr_ques_type[i])) { vo.setQues_idx(arr_ques_idx[i]); int
         * subidx = 1;
         * 
         * // 여러개 선택된 값이 ##으로 이어져 있음.. StringTokenizer stok = new StringTokenizer(arr_answer[i],
         * "##"); while (stok.hasMoreTokens()) { vo.setQuessub_idx(subidx++);
         * vo.setData_cont(stok.nextToken());
         * 
         * srvydataDAO.insertSrvydata(vo); } }
         */
        // 선호도 선택형
        else if ("CDIDX00086".equals(arr_ques_type[i])) {
          vo.setQues_idx(arr_ques_idx[i]);
          int subidx = 1;

          // 여러개 선택된 값이 ##으로 이어져 있음..
          StringTokenizer stok = new StringTokenizer(arr_answer[i], "##");
          while (stok.hasMoreTokens()) {
            vo.setQuessub_idx(subidx++);
            vo.setData_cont(stok.nextToken());

            srvydataDAO.insertSrvydata(vo);
          }
        }

      }

      // 응답자 명 저장
      // vo.setQuessub_idx(vo.getSrvy_nm_idx());
      // vo.setData_cont(vo.getSrvy_appl_nm());
      // srvydataDAO.insertSrvydata(vo);

      // 응답자 전화번호 저장
      // vo.setQuessub_idx(vo.getSrvy_cp_idx());
      // vo.setData_cont(EgovFileScrty.encode(vo.getSrvy_appl_cp()));
      // srvydataDAO.insertSrvydata(vo);

    }


  }

  /**
   * 설문 데이터 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateSrvydata(SrvydataVO vo) throws Exception {
    // TODO Auto-generated method stub
    srvydataDAO.updateSrvydata(vo);
  }

  /**
   * 설문 데이터 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSrvydata(SrvydataVO vo) throws Exception {
    // TODO Auto-generated method stub

    /*
     * // 첨부파일이 있는 경우 첨부파일을 모두 삭제하기.. AtchfileVO fileVO = new AtchfileVO();
     * fileVO.setAtckey_1st("BBB"); fileVO.setAtckey_2nd(new Integer(vo.get~~~).toString());
     * fileVO.setAtckey_3rd(1); atchfileService.deleteAtchfiles(fileVO);
     */

    srvydataDAO.deleteSrvydata(vo);
  }

  /**
   * 설문 데이터 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return SrvydataVO
   * @exception Exception
   */
  @Override
  public SrvydataVO selectSrvydata(SrvydataVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvydataDAO.selectSrvydata(vo);
  }

  /**
   * 설문 데이터 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectSrvydataList(SrvydataVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvydataDAO.selectSrvydataList(vo);
  }

  /**
   * 설문 데이터목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectSrvydataListTotCnt(SrvydataVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvydataDAO.selectSrvydataListTotCnt(vo);
  }

  /**
   * 설문 데이터 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List xlsSrvydataList(SrvydataVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvydataDAO.xlsSrvydataList(vo);
  }

  /**
   * 설문 데이터 키값 생성.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public int selectSrvydataKey(SrvydataVO vo) throws Exception {
    // TODO Auto-generated method stub
    return srvydataDAO.selectSrvydataKey(vo);
  }

  /**
   * 설문 주관식 답변 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectSrvydataCont(SrvydataVO vo) throws Exception {
    return srvydataDAO.selectSrvydataCont(vo);
  }

  /**
   * IP, 설문 번호 기준으로 갯수 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectSrvydataDupCnt(SrvydataVO vo) throws Exception {
    return srvydataDAO.selectSrvydataDupCnt(vo);
  }
}
