package egovframework.plani.custom.memsvc.web;

import static org.junit.Assert.fail;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml",
    "file:src/main/webapp/WEB-INF/config/egovframework/springmvc/dispatcher-servlet.xml"})
@WebAppConfiguration
public class MemberControllerTest {

  private MockMvc mockMvc;

  @Mock
  private MemberService memberService;

  @InjectMocks
  private MemberController memberController;

  private MemberVO memberVO;

  /**
   * 인증 및 권한을 우회하기 위해서 내부 클래스로 인터셉터 클래스
   * 
   */
  public class AuthenticInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
        Object handler) throws Exception {

      String loginsess_id = request.getSession().getId();
      String loginsess_ip = request.getRemoteAddr();
      memberVO.setLoginsess_id(loginsess_id);
      memberVO.setLoginsess_ip(loginsess_ip);

      request.getSession().setAttribute("SESS_USR_INFO", memberVO);

      return true;
    }
  }

  @Before
  public void setUp() throws Exception {
    MockitoAnnotations.initMocks(this);

    memberVO = new MemberVO();
    memberVO.setUser_id("abcde");
    memberVO.setUser_auth_lv(11);
    memberVO.setLoginsess_os("Windows");
    memberVO.setLoginsess_bw("Chrome");
    memberVO.setUser_nm("관리자");
    memberVO.setUser_birth("19850101");

    this.mockMvc = MockMvcBuilders.standaloneSetup(memberController)
        .addInterceptors(new AuthenticInterceptor()).alwaysDo(print()).build();
  }

  @Test
  @Ignore("미사용")
  public void testMemberList() {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("미사용")
  public void testMemberView() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testSysmemInputmove() {
    fail("Not yet implemented");
  }

  @Test
  public void testAddMember() {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("미사용")
  public void testRmvMember() {
    fail("Not yet implemented");
  }

  @Test
  public void testMdfMember() {
    fail("Not yet implemented");
  }

  @Test
  public void testChkdupMember() {
    fail("Not yet implemented");
  }

  @Test
  public void testPreCheckMember() {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("미사용")
  public void testXlsMemberSave() {
    fail("Not yet implemented");
  }

  @Test
  public void testSendPinCode() {
    fail("Not yet implemented");
  }

  @Test
  public void testCheckPinCode() {
    fail("Not yet implemented");
  }

  @Test
  public void testChangePwForm() {
    fail("Not yet implemented");
  }

  @Test
  public void testChangePw() {
    fail("Not yet implemented");
  }

  @Test
  public void testCheckMemberScrt() {
    fail("Not yet implemented");
  }

}
