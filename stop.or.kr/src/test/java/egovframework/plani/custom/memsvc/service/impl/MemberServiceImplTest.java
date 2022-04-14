package egovframework.plani.custom.memsvc.service.impl;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.not;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.List;
import javax.annotation.Resource;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import egovframework.plani.custom.memsvc.dao.MemberDAO;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml",
    "file:src/main/webapp/WEB-INF/config/egovframework/springmvc/dispatcher-servlet.xml"})
@WebAppConfiguration
public class MemberServiceImplTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  private MemberVO memberVO;

  @Mock
  private MemberDAO memberDAO;

  @InjectMocks
  private MemberService memberService = new MemberServiceImpl();

  @Resource
  private MemberService realMemberService;

  @Before
  public void setUp() throws Exception {
    MockitoAnnotations.initMocks(this);
    this.memberVO = new MemberVO();
  }

  @Test
  public void testInsertMember() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");
    memberVO.setUser_scrt("12345");
    memberVO.setUser_email("test@test.com");

    // WHEN
    when(memberDAO.insertMember(memberVO)).thenReturn(1);
    memberService.insertMember(memberVO);

    // THEN
    verify(memberDAO).insertMember(memberVO);
  }

  @Test
  public void testUpdateMember() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");

    // WHEN
    doNothing().when(memberDAO).updateMember(memberVO);
    memberService.updateMember(memberVO);

    // THEN
    verify(memberDAO).updateMember(memberVO);
  }

  @Test
  public void testUpdateMemberLastlogin() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");

    // WHEN
    doNothing().when(memberDAO).updateMemberLastlogin(memberVO);
    memberService.updateMemberLastlogin(memberVO);

    // THEN
    verify(memberDAO).updateMemberLastlogin(memberVO);
  }

  @Test
  public void testUpdateMemberAuth() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");

    // WHEN
    doNothing().when(memberDAO).updateMemberAuth(memberVO);
    memberService.updateMemberAuth(memberVO);

    // THEN
    verify(memberDAO).updateMemberAuth(memberVO);
  }

  @Test
  public void testUpdateMemberValid() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");

    // WHEN
    doNothing().when(memberDAO).updateMemberValid(memberVO);
    memberService.updateMemberValid(memberVO);

    // THEN
    verify(memberDAO).updateMemberValid(memberVO);
  }

  @Test
  public void testUpdateMemberUnvalid() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");

    // WHEN
    doNothing().when(memberDAO).updateMemberUnvalid(memberVO);
    memberService.updateMemberUnvalid(memberVO);

    // THEN
    verify(memberDAO).updateMemberUnvalid(memberVO);
  }

  @Test
  public void testUpdateMemberDupinfo() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");

    // WHEN
    doNothing().when(memberDAO).updateMemberDupinfo(memberVO);
    memberService.updateMemberDupinfo(memberVO);

    // THEN
    verify(memberDAO).updateMemberDupinfo(memberVO);
  }

  @Test
  public void testDeleteMember() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");

    // WHEN
    doNothing().when(memberDAO).deleteMember(memberVO);
    memberService.deleteMember(memberVO);

    // THEN
    verify(memberDAO).deleteMember(memberVO);
  }

  @Test
  public void testSelectMember() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");
    memberVO.setUser_email("dGVzdEB0ZXN0LmNvbQ==");
    memberVO.setUser_cp_1("MDEw");

    // WHEN
    when(memberDAO.selectMember(memberVO)).thenReturn(memberVO);
    MemberVO mVO = memberService.selectMember(memberVO);

    // THEN
    verify(memberDAO).selectMember(memberVO);
    assertThat("이메일 주소", mVO.getUser_email(), equalTo("test@test.com"));
    assertThat("휴대폰1", mVO.getUser_cp_1(), equalTo("010"));
  }

  @Test
  public void testSelectMemberByDupInfo() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");
    memberVO.setUser_email("dGVzdEB0ZXN0LmNvbQ==");
    memberVO.setUser_cp_1("MDEw");

    // WHEN
    when(memberDAO.selectMemberByDupInfo(memberVO)).thenReturn(memberVO);
    MemberVO mVO = memberService.selectMemberByDupInfo(memberVO);

    // THEN
    verify(memberDAO).selectMemberByDupInfo(memberVO);
    assertThat("이메일 주소", mVO.getUser_email(), equalTo("test@test.com"));
    assertThat("휴대폰1", mVO.getUser_cp_1(), equalTo("010"));
  }

  @Test
  public void testCheckMember() throws Exception {
    // GIVEN
    memberVO.setUser_id("abcde");
    memberVO.setUser_scrt("12345");

    // WHEN
    when(memberDAO.checkMember(memberVO)).thenReturn(memberVO);
    MemberVO mVO = memberService.checkMember(memberVO);

    // THEN
    verify(memberDAO).checkMember(memberVO);
    assertThat("abcde", equalTo(memberVO.getUser_id()));
    assertThat("WZRHGrsBESr8wYFZ9sx0tPURuZgG2lmzyvWpwXPKz8U=", equalTo(memberVO.getUser_scrt()));
  }

  @Test
  public void testSelectMemberList() throws Exception {
    memberVO.setFirstIndex(0);
    memberVO.setLastIndex(10);
    memberVO.setRecordCountPerPage(15);
    List<MemberVO> memberList = realMemberService.selectMemberList(memberVO);
    assertThat("회원이 2명이상 있어야 함", true, equalTo(memberList.size() >= 2));
  }

  @Test
  public void testSelectMemberListTotCnt() throws Exception {
    assertThat("회원이 총개수가 2이상 되어야 함", true,
        equalTo(realMemberService.selectMemberListTotCnt(memberVO) >= 2));
  }

  @Test
  public void testCheckDuplication() throws Exception {
    // GIVEN & WHEN
    when(memberDAO.checkDuplication(memberVO)).thenReturn(10);

    // THEN
    assertThat("검색된 개수", 10, equalTo(memberService.checkDuplication(memberVO)));
    verify(memberDAO).checkDuplication(memberVO);
  }

  @Test
  public void testRecoverMember() throws Exception {
    // GIVEN
    memberVO.setUser_id("abc");
    memberVO.setUser_email("test@test.com");
    memberVO.setUser_cp_1("010");

    // WHEN
    when(memberDAO.recoverMember(memberVO)).thenReturn(memberVO);
    MemberVO mVO = memberService.recoverMember(memberVO);

    // THEN
    verify(memberDAO).recoverMember(memberVO);

    assertThat("암호화된 이메일 주소", mVO.getUser_email(), equalTo("dGVzdEB0ZXN0LmNvbQ=="));
    assertThat("암호화된 휴대폰1", mVO.getUser_cp_1(), equalTo("MDEw"));
  }

  @Test
  public void testXlsMemberList() throws Exception {
    // GIVEN & WHEN
    List memberList = realMemberService.xlsMemberList(memberVO);

    // THEN
    assertThat("2개 이상의 회원이 등록되어야 정상", true, equalTo(memberList.size() >= 2));
  }

  @Test
  // TODO 서비스 계층에서 HttpServletRequest 객체를 사용하는 것은 좋은 형태가 아님 ( 서비스 계층은 웹에서 뿐이 아닌 다른 측에서도 사용될 수 있기에 )
  public void testGetReturnUrl() throws Exception {

    // GIVEN
    MockHttpServletRequest request = new MockHttpServletRequest();
    String referer = "http://google.com";
    MockHttpSession session = new MockHttpSession();
    session.putValue("SESS_RETURN_URL", referer);
    request.setSession(session);

    // WHEN & THEN
    assertThat("A 파라미터", memberService.getReturnUrl(request, "A"), equalTo(
        "redirect:/brdartcl/boardarticleMoveView.do?srch_menu_nix=6tLw23K0&brd_id=BDIDX_X046yB2sOXl6KC69nT7A4H&edomweivgp=A"));

    assertThat("B 파라미터", memberService.getReturnUrl(request, "B"), equalTo(
        "redirect:/brdartcl/boardarticleMoveView.do?brd_id=BDIDX_19tS6X844893CxnCqoNMRP&srch_menu_nix=1q0L0R27&edomweivgp=A&srch_mu_lang=CDIDX00023"));

    assertThat("잘못된 파라미터", memberService.getReturnUrl(request, "C"), not(equalTo(
        "redirect:/brdartcl/boardarticleMoveView.do?srch_menu_nix=6tLw23K0&brd_id=BDIDX_X046yB2sOXl6KC69nT7A4H&edomweivgp=A")));

    assertThat("파라미터 없고 리퍼럴 있음", memberService.getReturnUrl(request, ""),
        equalTo("redirect:" + referer));

    request.setSession(null);
    assertThat("파리미터 없음", memberService.getReturnUrl(request, ""),
        equalTo("redirect:/contents/siteMain.do"));

  }

}
