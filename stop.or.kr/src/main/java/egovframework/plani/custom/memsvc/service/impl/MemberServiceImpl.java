package egovframework.plani.custom.memsvc.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import egovframework.plani.custom.memsvc.dao.MemberDAO;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.UserInfoHelper;
import egovframework.plani.template.man.menuctgry.service.SysauthService;
import egovframework.plani.template.man.menuctgry.vo.SysauthVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("memberService")
public class MemberServiceImpl extends EgovAbstractServiceImpl implements MemberService {

  /** MemberDAO */
  @Resource(name = "memberDAO")
  private MemberDAO memberDAO;

  @Resource(name = "sysauthService")
  private SysauthService sysauthService;

  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 사용자 정보 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void insertMember(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 패스워드 암호화
    vo = encodeData(vo);
    vo.setUser_scrt(EgovFileScrty.encryptPassword(vo.getUser_scrt()));
    memberDAO.insertMember(vo);

  }

  /**
   * 사용자 정보 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateMember(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub
    if (!(vo.getUser_scrt() == null || "".equals(vo.getUser_scrt())))
      vo.setUser_scrt(EgovFileScrty.encryptPassword(vo.getUser_scrt()));

    vo = encodeData(vo);
    memberDAO.updateMember(vo);
  }


  /**
   * 사용자 마지막 로그인 시간을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateMemberLastlogin(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub

    memberDAO.updateMemberLastlogin(vo);
  }

  /**
   * 사용자 마지막 로그아웃 시간을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int updateMemberLastlogout(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub

    return memberDAO.updateMemberLastlogout(vo);
  }

  /**
   * 사용자 권한 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateMemberAuth(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub

    memberDAO.updateMemberAuth(vo);
  }

  /**
   * 모든 준회원을 일반회원으로 변경시킨다 : 회비가 유료 => 무료로 변경된 경우
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateMemberValid(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub

    memberDAO.updateMemberValid(vo);
  }

  /**
   * 모든 평생회원을 제외한 모든 정회원을 준회원으로 변경시킨다 : 회비가 무료 => 유료로 변경된 경우
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateMemberUnvalid(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub

    memberDAO.updateMemberUnvalid(vo);
  }

  /**
   * 본인인증 키값 없데이트
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateMemberDupinfo(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub
    memberDAO.updateMemberDupinfo(vo);
  }


  /**
   * 사용자 정보 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteMember(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub
    memberDAO.deleteMember(vo);
  }

  /**
   * 사용자 정보 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public MemberVO selectMember(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub

    MemberVO resultVO = memberDAO.selectMember(vo);
    resultVO = decodeData(resultVO);

    return resultVO;
  }

  /**
   * 사용자 정보 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public MemberVO selectMemberByDupInfo(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub

    MemberVO resultVO = memberDAO.selectMemberByDupInfo(vo);
    resultVO = decodeData(resultVO);

    return resultVO;
  }



  /**
   * 사용자 정보 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public MemberVO checkMember(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 패스워드 SHA256 암호화
    String pwd = vo.getUser_scrt();
    // System.out.println(EgovFileScrty.encryptPassword(pwd));

    vo.setUser_scrt(EgovFileScrty.encryptPassword(pwd));
    MemberVO chkVO = memberDAO.checkMember(vo);

    /*
     * // SHA256이 NULL인 경우 MD5도 체크한다. if(chkVO == null) {
     * vo.setUser_scrt(EgovFileScrty.encryptMD5(pwd)); chkVO = memberDAO.checkMember(vo);
     * 
     * // SHA256이아니라 MD5로 암호화 되어있는 경우 // SHA256으로 변경시킨다. if(chkVO != null) { MemberVO uVO = new
     * MemberVO(); uVO.setUser_id(vo.getUser_id()); uVO.setModifier(vo.getUser_id());
     * uVO.setUser_scrt(EgovFileScrty.encryptPassword(pwd)); uVO.setChk_flag("S");
     * memberDAO.updateMember(uVO); } }
     */

    return chkVO;
  }

  /**
   * 사용자 정보 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectMemberList(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub

    List resultVO = memberDAO.selectMemberList(vo);

    return resultVO;
  }

  /**
   * 사용자 정보목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectMemberListTotCnt(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub
    return memberDAO.selectMemberListTotCnt(vo);
  }


  /**
   * 사용자 정보정보의 중복 여부를 체크한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int checkDuplication(MemberVO vo) throws Exception {
    if (vo != null)
      vo = encodeData(vo);
    return memberDAO.checkDuplication(vo);
  }

  /**
   * 사용자 정보 찾기(아이디/패스워드)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public MemberVO recoverMember(MemberVO vo) throws Exception {
    if (vo != null)
      vo = encodeData(vo);
    return memberDAO.recoverMember(vo);
  }


  /**
   * 사용자 정보 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List xlsMemberList(MemberVO vo) throws Exception {
    // TODO Auto-generated method stub
    return memberDAO.xlsMemberList(vo);
  }


  /**
   * 특정데이타를 암호화 한다
   * 
   * @param vo - 조건이 담긴 VO
   * @exception Exception
   */
  private MemberVO encodeData(MemberVO vo) throws Exception {
    if (vo != null) {
      if (!(vo.getUser_cp_1() == null || "".equals(vo.getUser_cp_1())))
        vo.setUser_cp_1(EgovFileScrty.encode(vo.getUser_cp_1()));
      if (!(vo.getUser_cp_2() == null || "".equals(vo.getUser_cp_2())))
        vo.setUser_cp_2(EgovFileScrty.encode(vo.getUser_cp_2()));
      if (!(vo.getUser_cp_3() == null || "".equals(vo.getUser_cp_3())))
        vo.setUser_cp_3(EgovFileScrty.encode(vo.getUser_cp_3()));

      if (!(vo.getUser_tel_1() == null || "".equals(vo.getUser_tel_1())))
        vo.setUser_tel_1(EgovFileScrty.encode(vo.getUser_tel_1()));
      if (!(vo.getUser_tel_2() == null || "".equals(vo.getUser_tel_2())))
        vo.setUser_tel_2(EgovFileScrty.encode(vo.getUser_tel_2()));
      if (!(vo.getUser_tel_3() == null || "".equals(vo.getUser_tel_3())))
        vo.setUser_tel_3(EgovFileScrty.encode(vo.getUser_tel_3()));

      if (!(vo.getUser_email() == null || "".equals(vo.getUser_email())))
        vo.setUser_email(EgovFileScrty.encode(vo.getUser_email()));

      if (!(vo.getBizreg_no() == null || "".equals(vo.getBizreg_no())))
        vo.setBizreg_no(EgovFileScrty.encode(vo.getBizreg_no()));
    }

    return vo;
  }

  /**
   * 특정데이타를 복호화 한다
   * 
   * @param vo - 조건이 담긴 VO
   * @exception Exception
   */
  private MemberVO decodeData(MemberVO vo) throws Exception {
    if (vo != null) {
      if (!(vo.getUser_cp_1() == null || "".equals(vo.getUser_cp_1())))
        vo.setUser_cp_1(EgovFileScrty.decode(vo.getUser_cp_1()));
      if (!(vo.getUser_cp_2() == null || "".equals(vo.getUser_cp_2())))
        vo.setUser_cp_2(EgovFileScrty.decode(vo.getUser_cp_2()));
      if (!(vo.getUser_cp_3() == null || "".equals(vo.getUser_cp_3())))
        vo.setUser_cp_3(EgovFileScrty.decode(vo.getUser_cp_3()));

      if (!(vo.getUser_tel_1() == null || "".equals(vo.getUser_tel_1())))
        vo.setUser_tel_1(EgovFileScrty.decode(vo.getUser_tel_1()));
      if (!(vo.getUser_tel_2() == null || "".equals(vo.getUser_tel_2())))
        vo.setUser_tel_2(EgovFileScrty.decode(vo.getUser_tel_2()));
      if (!(vo.getUser_tel_3() == null || "".equals(vo.getUser_tel_3())))
        vo.setUser_tel_3(EgovFileScrty.decode(vo.getUser_tel_3()));

      if (!(vo.getUser_email() == null || "".equals(vo.getUser_email())))
        vo.setUser_email(EgovFileScrty.decode(vo.getUser_email()));

      if (!(vo.getBizreg_no() == null || "".equals(vo.getBizreg_no())))
        vo.setBizreg_no(EgovFileScrty.decode(vo.getBizreg_no()));
    }

    return vo;
  }

  /**
   * 페이지 리턴타입에 따른 URL반환
   * 
   * @param request - 세션정보
   * @param pg_ret_type - 리턴타입 구분
   * @exception Exception
   */

  @Override
  public String getReturnUrl(HttpServletRequest request, String pg_ret_type) throws Exception {

    String return_url = "";

    if ("A".equals(pg_ret_type)) {
      return_url =
          "redirect:/brdartcl/boardarticleMoveView.do?srch_menu_nix=6tLw23K0&brd_id=BDIDX_X046yB2sOXl6KC69nT7A4H&edomweivgp=A";
    } else if ("B".equals(pg_ret_type)) {
      return_url =
          "redirect:/brdartcl/boardarticleMoveView.do?brd_id=BDIDX_19tS6X844893CxnCqoNMRP&srch_menu_nix=1q0L0R27&edomweivgp=A&srch_mu_lang=CDIDX00023";
    } else if ("".equals(pg_ret_type)) {
      String referer =
          (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_RETURN_URL");
      if (null == referer || "null".equals(referer) || "".equals(referer)) {
        return_url = "redirect:/contents/siteMain.do";
      } else {
        referer = referer.replaceAll(request.getContextPath(), "");
        return_url = "redirect:" + referer;
      }
    }


    return return_url;
  }

  /**
   * 관리자 회원 등록/수정 model
   */
  @Override
  public void setView(Model model, String id, boolean isModify, MemberVO resultVO) throws Exception {
    if (isModify == false) {
      // 등록
      model.addAttribute("isModify", false);
      // 권한 상세 유형 조회
      SysauthVO authVO = new SysauthVO();
      authVO.setUp_auth_cd("M0000");
      authVO.setUse_yn("Y");
      List authcode = sysauthService.selectSysauthList(authVO);
      model.addAttribute("authcode", authcode);
    } else { // 수정
      model.addAttribute("isModify", true);
      // System.out.println("수정");
      // 세션 사용자 정보
      MemberVO sessionUserData = UserInfoHelper.getLoginData();
      String userid = sessionUserData.getUser_id();
      // 총괄 관리자가 아니고, 자신의 아이디와 같지 않은 사람의 데이터 조회 시도
			if (sessionUserData.getUser_auth_lv() > 2 && !id.equals(userid)) {
        throw new Exception(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES"));
      }
      resultVO.setUp_auth_cd(resultVO.getUser_auth_cd().substring(0, 1) + "0000");
      model.addAttribute("memberVO", resultVO);
      // 권한 상세 유형 조회
      SysauthVO authVO = new SysauthVO();
      authVO.setUp_auth_cd(resultVO.getUser_auth_cd().substring(0, 1) + "0000");
      authVO.setUse_yn("Y");
      List authcode = sysauthService.selectSysauthList(authVO);
      model.addAttribute("authcode", authcode);
    }
    // 권한 상위 유형 조회
    SysauthVO authVO = new SysauthVO();
    authVO.setUp_auth_cd("");
    authVO.setUse_yn("Y");
    List upauthcode = sysauthService.selectSysauthList(authVO);
    // 손님(Guest)은 선택 권한에서 제외시킨다.
    for (int i = 0; i < upauthcode.size(); i++) {
      SysauthVO tVO = (SysauthVO) upauthcode.get(i);
      if (tVO.getAuth_lv() == 0 || tVO.getAuth_lv() == 10001)
        upauthcode.remove(i);
    }
    model.addAttribute("upauthcode", upauthcode);
    // 첨부파일 목록 가져오기
    AtchfileVO fileVO = new AtchfileVO();
    fileVO.setAtckey_1st("USR_LOGO");
    fileVO.setAtckey_2nd(id);
    fileVO.setAtckey_3rd(1);
    List fileList = atchfileService.selectAtchfileList(fileVO);
    model.addAttribute("atchfileList", fileList);
  }

	/**
	 * 사용자정보를 수정한다.
	 * 
	 * @param vo
	 *            - 수정할 조건이 담긴 VO
	 * @exception Exception
	 */
	@Override
	public void updateIsLock(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub

		memberDAO.updateIsLock(vo);
	}

	/**
	 * 사용자정보를 수정한다.
	 * 
	 * @param vo
	 *            - 수정할 조건이 담긴 VO
	 * @exception Exception
	 */
	@Override
	public void updateLockCount(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub

		memberDAO.updateLockCount(vo);
	}

	/**
	 * 사용자 정보 을/를 수정한다.
	 * 
	 * @param vo
	 *            - 수정할 조건이 담긴 VO
	 * @exception Exception
	 */
	@Override
	public void resetPassword(MemberVO vo) throws Exception {

		vo.setUser_scrt(EgovFileScrty.encryptPassword(vo.getUser_scrt()));

		vo = encodeData(vo);
		memberDAO.resetPassword(vo);
	}
}
