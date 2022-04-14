package egovframework.plani.custom.memsvc.dao;

import java.util.List;

import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface MemberDAO {

  /**
   * 사용자 정보을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertMember(MemberVO vo) throws Exception;

  /**
   * 사용자 정보을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateMember(MemberVO vo) throws Exception;

  /**
   * 사용자 마지막 로그인 시간을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateMemberLastlogin(MemberVO vo);

  /**
   * 사용자 마지막 로그아웃 시간 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer updateMemberLastlogout(MemberVO vo);

  /**
   * 사용자 정보을/를 수정한다.
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
   * 사용자 정보을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteMember(MemberVO vo) throws Exception;

  /**
   * 사용자 정보항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public MemberVO selectMember(MemberVO vo) throws Exception;

  /**
   * 사용자 정보항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public MemberVO selectMemberByDupInfo(MemberVO vo) throws Exception;

  /**
   * 로그인 정보를 체크 한다.
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
   * 사용자 정보목록의 총 개수를 구한다.
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
	 * 사용자 정보을/를 수정한다.
	 * 
	 * @param vo
	 *            - 수정할 조건이 담긴 VO
	 * @exception Exception
	 */
	public void updateIsLock(MemberVO vo) throws Exception;

	/**
	 * 사용자 정보을/를 수정한다.
	 * 
	 * @param vo
	 *            - 수정할 조건이 담긴 VO
	 * @exception Exception
	 */
	public void updateLockCount(MemberVO vo) throws Exception;

	/**
	 * 사용자 정보을/를 수정한다.
	 * 
	 * @param vo
	 *            - 수정할 조건이 담긴 VO
	 * @exception Exception
	 */
	public void resetPassword(MemberVO vo) throws Exception;

}
