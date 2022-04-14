package egovframework.plani.custom.memsvc.dao;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
import java.util.List;
import javax.annotation.Resource;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import com.github.springtestdbunit.DbUnitTestExecutionListener;
import com.github.springtestdbunit.TransactionDbUnitTestExecutionListener;
import com.github.springtestdbunit.annotation.DatabaseOperation;
import com.github.springtestdbunit.annotation.DatabaseSetup;
import egovframework.plani.custom.memsvc.vo.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "member_sample.xml", type = DatabaseOperation.REFRESH)
public class MemberDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public MemberDAO memberDAO;

  private MemberVO vo;

  @Before
  public void setUp() throws Exception {
    vo = new MemberVO();
  }

  @Test
  public void testInsertMember() throws Exception {
    vo.setUser_id("live-now");
    vo.setUser_scrt("sF0VDkoxpaXzKSscJTHDhWTey0zNyZR+Rv9rk2rcsBI=");
    vo.setUser_nm("지금을살자");
    vo.setModifier("테스터");
    vo.setUser_email("YWRtaW5AcGxhbmkuY28ua3I");
    vo.setUser_birth("20180415");
    vo.setUser_cp_1("MDEw");
    vo.setUser_cp_2("Mjk1NQ==");
    vo.setUser_cp_3("MjIyMg==");
    vo.setUser_tel_1("MDEw");
    vo.setUser_tel_2("Mjk1NQ==");
    vo.setUser_tel_3("MjIyMg==");
    vo.setUser_zip("12345");
    vo.setWriter(vo.getUser_id());
    vo.setUser_auth_cd("U0005");
    vo.setAllow_ip("*");

    memberDAO.deleteMember(vo);
    memberDAO.insertMember(vo);
    MemberVO member = memberDAO.selectMember(vo);

    assertThat("회원 추가", "live-now", equalTo(member.getUser_id()));

    memberDAO.deleteMember(member);
  }

  @Test
  public void testUpdateMember() throws Exception {
    vo.setUser_id("abcde");
    MemberVO member = memberDAO.selectMember(vo);
    assertThat("관리자", equalTo(member.getUser_nm()));
    member.setUser_nm("슈퍼맨");
    member.setModifier("테스터");
    memberDAO.updateMember(member);
    member = memberDAO.selectMember(vo);

    assertThat("회원정보 갱신", "슈퍼맨", equalTo(member.getUser_nm()));
  }

  @Test
  @Ignore("LAST_LOGIN 값을 추출하는 프로퍼티가 없음")
  public void testUpdateMemberLastlogin() throws Exception {
    vo.setUser_id("abcde");
    MemberVO member = memberDAO.selectMember(vo);
    assertThat("last_login 값 추출", "abcde", equalTo(member.getUser_id()));
    memberDAO.updateMemberLastlogin(vo);
  }

  @Test
  public void testUpdateMemberAuth() throws Exception {
    vo.setUser_id("abcde");
    MemberVO member = memberDAO.selectMember(vo);
    assertThat("회원 권한 변경을 위한 현재 권한 확인", "U0000", equalTo(member.getUser_auth_cd()));
    member.setUser_auth_cd("U0001");
    memberDAO.updateMemberAuth(member);
    member = memberDAO.selectMember(vo);

    assertThat("회원 권한 변경", "U0001", equalTo(member.getUser_auth_cd()));
  }

  @Test
  @Ignore("전체 업데이트라 테스트가 애매함")
  public void testUpdateMemberValid() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("전체 업데이트라 테스트가 애매함")
  public void testUpdateMemberUnvalid() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  // TODO setUser_dup_info 값과 혼돈됨
  public void testUpdateMemberDupinfo() throws Exception {
    vo.setUser_dupinfo("11111");
    MemberVO member = memberDAO.selectMemberByDupInfo(vo);
    assertThat("dup_info 값 변경을 위해 회원 조회", "abcde", equalTo(member.getUser_id()));
    member.setUser_dup_info("33333");
    memberDAO.updateMemberDupinfo(member);
    vo.setUser_dupinfo("33333");
    member = memberDAO.selectMemberByDupInfo(vo);

    assertThat("dup_info 값 변경", "abcde", equalTo(member.getUser_id()));
  }

  @Test
  public void testDeleteMember() throws Exception {
    vo.setUser_id("abcde");
    MemberVO member = memberDAO.selectMember(vo);
    assertThat("삭제를 위해 회원 조회", "abcde", equalTo(member.getUser_id()));
    memberDAO.deleteMember(vo);

    assertThat("삭제후 아이디가 없어야 함", null, equalTo(memberDAO.selectMember(vo)));
  }

  @Test
  public void testSelectMember() throws Exception {
    vo.setUser_id("abcde");
    MemberVO member = memberDAO.selectMember(vo);

    assertThat("회원 조회", "abcde", equalTo(member.getUser_id()));
  }

  @Test
  // TODO setUser_dup_info 값과 혼돈됨
  public void testSelectMemberByDupInfo() throws Exception {
    vo.setUser_dupinfo("11111");
    MemberVO member = memberDAO.selectMemberByDupInfo(vo);

    assertThat("회원 dup_info 값 조회", "abcde", equalTo(member.getUser_id()));
  }

  @Test
  public void testCheckMember() throws Exception {
    vo.setUser_id("abcde");
    vo.setUser_scrt("Vlhsk6ibLW+uOSUanK0pmlpprSAb7IypY/6iCVOHELY=");
    MemberVO member = memberDAO.checkMember(vo);

    assertThat("로그인 정보", "abcde", equalTo(member.getUser_id()));
  }

  @Test
  // TODO 현재 사용되지 않는듯하고, selectMember 통해서도 구현될 듯 한데.. 굳이 따로 둘 필요성이 없어 보임
  public void testRecoverMember() throws Exception {
    vo.setUser_id("abcde");
    MemberVO member = memberDAO.recoverMember(vo);

    assertThat("사용자 정보 찾기", "abcde", equalTo(member.getUser_id()));
  }

  @Test
  public void testSelectMemberList() throws Exception {
    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);

    List<MemberVO> memberList = memberDAO.selectMemberList(vo);

    assertThat("회원이 2명이상 있어야 함", true, equalTo(memberList.size() >= 2));
  }

  @Test
  public void testSelectMemberListTotCnt() throws Exception {
    assertThat("회원이 총개수가 2이상 되어야 함", true, equalTo(memberDAO.selectMemberListTotCnt(vo) >= 2));
  }

  @Test
  public void testCheckDuplication() throws Exception {
    vo.setUser_id("abcde");
    assertThat("회원아이디가 있는 경우", 1, equalTo(memberDAO.checkDuplication(vo)));

    vo.setUser_id("-");
    assertThat("회원아이디가 없는 경우", 0, equalTo(memberDAO.checkDuplication(vo)));
  }

  @Test
  public void testXlsMemberList() throws Exception {
    List<MemberVO> memberList = memberDAO.xlsMemberList(vo);

    assertTrue("2개 이상의 회원이 등록되어야 정상", memberList.size() >= 2);
  }

}
