package egovframework.plani.template.man.log.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.log.vo.ManlogVO;

@Controller
@RequestMapping("/manlog")
public class ManlogController {

  @Resource(name = "manlogService")
  private ManlogService manlogService;

  @Resource
  private CrudTemplate crudTemplate;

  /**
   * 관리자로그 목록을 조회한다.
   * 
   * @param manlogVO : 조회할 정보
   * @exception Exception
   */
  @RequestMapping("/manlogList")
  public String manlogList(final ManlogVO manlogVO, HttpServletRequest request, Model model)
      throws Exception {

    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "LOG_MAN", "로그관리", "로그 목록조회", "L");

    // 페이징 목록 처리
    crudTemplate.pagingList(request, model, manlogVO, new CrudStrategy<ManlogVO>() {
      @Override
      public int totalCount() throws Exception {
        return manlogService.selectManlogListTotCnt(manlogVO);
      }

      @Override
      public List<ManlogVO> pagingList() throws Exception {
        return manlogService.selectManlogList(manlogVO);
      }
    });

    return "/modeec/logmanList";

  }


  /**
   * 관리자로그 목록의 엑셀 다운로드 요청을 처리한다.
   * 
   * @param manlogVO : 수정할 정보
   * @exception Exception
   */
  @RequestMapping("/xlsManlogSave")
  public void xlsManlogSave(ManlogVO manlogVO, HttpServletRequest request,
      HttpServletResponse response) throws Exception {

    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    List<Map<String, String>> colinfoList = new ArrayList<>();

    String[][] col_name = {{"RN", "순번"}, {"LOG_IDX", "일련번호"}, {"LOG_KEY", "로그 KEY"},
        {"LOG_KEY_NM", "로그 KEY 설명"}, {"LOG_KEY_DEST", "로그 상세"}, {"LOG_JOB_GB", "작업구분"},
        {"LOG_RADDR", "IP 주소"}, {"LOG_UID", "행위자 ID"}, {"LOG_UID", "행위자명"}, {"LOG_DT", "기록일"}};

    for (int i = 0; i < col_name.length; i++) {
      Map<String, String> ifmap = new HashMap<>();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    List<ManlogVO> manlogOrgList = manlogService.xlsManlogList(manlogVO);

    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
     ************************************************************/
    List manlogXlsList = new ArrayList();
    for (int i = 0; i < manlogOrgList.size(); i++) {
      ManlogVO vo = manlogOrgList.get(i);

      HashMap rsmap = new HashMap();
      rsmap.put("RN", vo.getRn());
      rsmap.put("LOG_IDX", vo.getLog_idx());
      rsmap.put("LOG_KEY", vo.getLog_key());
      rsmap.put("LOG_KEY_NM", vo.getLog_key_nm());
      rsmap.put("LOG_KEY_DEST", vo.getLog_key_dest());
      rsmap.put("LOG_JOB_GB", vo.getLog_job_gb());
      rsmap.put("LOG_RADDR", EgovFileScrty.decode(vo.getLog_raddr()));
      rsmap.put("LOG_UID", vo.getLog_uid());
      rsmap.put("LOG_DT", vo.getLog_dt());

      manlogXlsList.add(rsmap);
    }

    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "LOG_MAN", "로그관리", "로그 목록 엑셀저장", "X");

    String fileName = "관리자로그";
    xlsDownUtil.ExcelWrite(response, manlogXlsList, colinfoList, fileName);
  }
}

