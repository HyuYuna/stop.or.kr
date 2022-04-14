package egovframework.plani.custom.memsvc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import egovframework.plani.custom.memsvc.vo.MemberVO;

public interface MemberService {

  /**
   * 사용자 정보 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public void insertMember(MemberVO vo) throws Exception;

  /**
   * 사용자 정보 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateMember(MemberVO vo) throws Exception;

  /**
   * 사용자 마지막 로그인 시간 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateMemberLastlogin(MemberVO vo) throws Exception;

  /**
   * 사용자 마지막 로그아웃 시간 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @return
   * @exception Exception
   */
  public int updateMemberLastlogout(MemberVO vo) throws Exception;

  /**
   * 사용자 권한 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateMemberAuth(MemberVO vo) throws Exception;

  /**
   * 모든 준회원을 일반회원으로 변경시킨다 : 회비가 유료 => 무료로 변경된 경우
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateMemberValid(MemberVO vo) throws Exception;

  /**
   * 모든 평생회원을 제외한 모든 정회원을 준회원으로 변경시킨다 : 회비가 무료 => 유료로 변경된 경우
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateMemberUnvalid(MemberVO vo) throws Exception;

  /**
   * 본인인증 키값 없데이트
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateMemberDupinfo(MemberVO vo) throws Exception;

  /**
   * 사용자 정보 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteMember(MemberVO vo) throws Exception;

  /**
   * 사용자 정보 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public MemberVO selectMember(MemberVO vo) throws Exception;

  /**
   * 사용자 정보 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public MemberVO selectMemberByDupInfo(MemberVO vo) throws Exception;



  /**
   * 로그인 정보를 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public MemberVO checkMember(MemberVO vo) throws Exception;

  /**
   * 사용자 정보 찾기(아이디/패스워드)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public MemberVO recoverMember(MemberVO vo) throws Exception;

  /**
   * 사용자 정보 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectMemberList(MemberVO vo) throws Exception;

  /**
   * 사용자 정보 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectMemberListTotCnt(MemberVO vo) throws Exception;

  /**
   * 사용자 정보정보의 중복 여부를 체크한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int checkDuplication(MemberVO vo) throws Exception;

  /**
   * 사용자 정보 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List xlsMemberList(MemberVO vo) throws Exception;


  /**
   * 페이지 리턴타입에 따른 URL반환
   * 
   * @param request - 세션정보
   * @param pg_ret_type - 리턴타입 구분
   * @exception Exception
   */
  public String getReturnUrl(HttpServletRequest request, String pg_ret_type) throws Exception;

  /**
   * 뷰페이지 정보 셋
   * 
   * @param request
   * @throws Exception
   */
  public void setView(Model model, String id, boolean isModify, MemberVO memberVO) throws Exception;

	/**
	 * 회원정보 수정
	 * 
	 * @param vo
	 *            - 수정할 조건이 담긴 VO
	 * @exception Exception
	 */
	public void updateIsLock(MemberVO vo) throws Exception;

	/**
	 * 회원정보 수정
	 * 
	 * @param vo
	 *            - 수정할 조건이 담긴 VO
	 * @exception Exception
	 */
	public void updateLockCount(MemberVO vo) throws Exception;

	/**
	 * 사용자 정보 을/를 수정한다.
	 * 
	 * @param vo
	 *            - 수정할 조건이 담긴 VO
	 * @exception Exception
	 */
	public void resetPassword(MemberVO vo) throws Exception;

}
