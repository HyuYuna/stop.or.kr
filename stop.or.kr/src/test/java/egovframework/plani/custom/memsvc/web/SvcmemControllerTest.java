package egovframework.plani.custom.memsvc.web;

import static org.junit.Assert.fail;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
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
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.man.stat.service.CommstatService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml",
    "file:src/main/webapp/WEB-INF/config/egovframework/springmvc/dispatcher-servlet.xml"})
@WebAppConfiguration
public class SvcmemControllerTest {

  private MockMvc mockMvc;

  @Mock
  private MemberService memberService;

  @Mock
  private CommstatService commstatService;

  @InjectMocks
  private SvcmemController svcmemController;

  private MemberVO memberVO;

  /**
   * 인증 및 권한을 우회하기 위해서 내부 클래스로 인터셉터 클래스
   * 
   */
  public class AuthenticInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
        Object handler) throws Exception {

      // Cookie[] cookies = request.getCookies();

      // String loginsess_id = request.getRequestedSessionId();
      // String loginsess_id2 = request.getSession().getId();

      // if (cookies != null) {
      // for (Cookie cookie : cookies) {
      // System.out.println(cookie.getName() + " ===> " + cookie.getValue());
      // }
      // }

      String loginsess_id = request.getSession().getId();
      String loginsess_ip = request.getRemoteAddr();
      memberVO.setLoginsess_id(loginsess_id);
      memberVO.setLoginsess_ip(loginsess_ip);

      request.getSession().setAttribute("SESS_USR_INFO", memberVO);
      // request.getSession().setAttribute("USER_AUTH_SESS", "");

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
    memberVO.setUser_auth_cd("A0001");

    this.mockMvc = MockMvcBuilders.standaloneSetup(svcmemController)
        .addInterceptors(new AuthenticInterceptor()).alwaysDo(print()).build();
  }

  @Test
  public void testSiteLogin() throws Exception {
    mockMvc.perform(get("/svcmem/siteLogin.do")).andExpect(status().isOk())
        .andExpect(view().name("/svcmem/siteLogin"));
  }

  @Test
  // todo MetsysController 에 static 메소드로 서비스처럼 활용하고 있는 것은 좋은 형태가 아님
  // MetsysController.setSessionValues (static) 매소드는 목업이 되지 않아서 테스트 대응 불가
  public void testSiteLogin_post() throws Exception {

    when(memberService.selectMember(any(MemberVO.class))).thenReturn(memberVO);
    when(memberService.checkMember(any(MemberVO.class))).thenReturn(memberVO);
    doNothing().when(memberService).updateMemberLastlogin(any(MemberVO.class));
    doNothing().when(commstatService).insertCommstat(any(HttpServletRequest.class), eq("LOGIN_USR"),
        eq("사용자로그인"), eq(""));

    // 아이디 및 비밀번호 폼검증시 에러 발생
    String user_id = "";
    String user_scrt = "12345";

    MockHttpServletRequestBuilder postQuery =
        post("/svcmem/siteLogin.do").param("user_id", user_id).param("user_scrt", user_scrt);

    mockMvc.perform(postQuery).andExpect(model().attributeHasFieldErrors("loginVO", "user_id"));

    user_id = "abcde";
    user_scrt = "";

    postQuery =
        post("/svcmem/siteLogin.do").param("user_id", user_id).param("user_scrt", user_scrt);

    mockMvc.perform(postQuery).andExpect(model().attributeHasFieldErrors("loginVO", "user_scrt"));

    // 정상 로그인
    user_id = "abcde";
    user_scrt = "12345";

    // postQuery =
    // post("/svcmem/siteLogin.do").param("user_id", user_id).param("user_scrt", user_scrt);
    // mockMvc.perform(postQuery).andExpect(content().string("/"));

    // 정지 또는 탈퇴회원 인 경우
    memberVO.setUser_auth_cd("G0002");
    postQuery =
        post("/svcmem/siteLogin.do").param("user_id", user_id).param("user_scrt", user_scrt);
    mockMvc.perform(postQuery).andExpect(content().string("CMMN"));

  }

  @Test
  @Ignore("미사용")
  public void testSiteLoginProc() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testMemJoinStep01() throws Exception {
    mockMvc.perform(get("/svcmem/memJoinStep01.do")).andExpect(status().isOk())
        .andExpect(view().name("/svcmem/memJoinStep01"));
  }

  @Test
  public void testSiteLogout() throws Exception {
    mockMvc.perform(get("/svcmem/siteLogout.do"))
        .andExpect(redirectedUrl("/svcmem/siteLogin.do?srch_menu_nix=05I2d7YX"));
  }

  @Test
  @Ignore("본인인증에서 사용하여 접근하는 부분이 있어 수정이 필요함")
  // tgtact, srch_menu_nix, pg_ret_type 3개 인자만 실질적으로 사용됨
  // returnURL, param_r2 2개 인자를 사용하고 있는 곳이 없음
  public void testSysmemPagemove() throws Exception {
    String tgtact = "memJoinStep01";
    String result = "/svcmem/" + tgtact;

    mockMvc.perform(get("/svcmem/sysmemPagemove.do").param("tgtact", tgtact))
        .andExpect(content().string(result));
  }

  @Test
  @Ignore("본인인증에서 사용하여 접근하는 부분이 있어 수정이 필요함")
  public void testUsrcertForm() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("본인인증에서 사용하여 접근하는 부분이 있어 수정이 필요함")
  public void testSuccessHpAndCert() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("본인인증에서 사용하여 접근하는 부분이 있어 수정이 필요함")
  public void testClosePopAndRedirect() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("본인인증에서 사용하여 접근하는 부분이 있어 수정이 필요함")
  public void testFailHpAndCert() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("본인인증에서 사용하여 접근하는 부분이 있어 수정이 필요함")
  public void testClosePop() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("본인인증에서 사용하여 접근하는 부분이 있어 수정이 필요함")
  public void testAuthPageView() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("본인인증에서 사용하여 접근하는 부분이 있어 수정이 필요함")
  public void testParentAuthInfo() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testSiteMapView() throws Exception {
    mockMvc.perform(get("/svcmem/siteMapView.do")).andExpect(status().isOk())
        .andExpect(view().name("/svcmem/siteMap"));
  }

  @Test
  @Ignore("미사용")
  public void testJumpcodeOper() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  @Ignore("sysmemPagemove.do 로 접근하는 부분이 있어 수정이 필요함")
  public void testWithdrawMember() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testRecoverMember() throws Exception {

    // 아이디
    memberVO.setUser_recover_type("ID");

    when(memberService.recoverMember(any(MemberVO.class))).thenReturn(memberVO);

    mockMvc
        .perform(get("/svcmem/recoverMember.do")
            .param("user_recover_type", memberVO.getUser_recover_type())
            .param("user_nm", memberVO.getUser_nm()).param("user_birth", memberVO.getUser_birth()))
        .andExpect(status().isOk()).andExpect(content().string(memberVO.getUser_id()));

    verify(memberService).recoverMember(any(MemberVO.class));

    // 비밀번호
    memberVO.setUser_recover_type("PWD");
    memberVO.setUser_email("test@test.com");

    doNothing().when(memberService).updateMember(any(MemberVO.class));

    mockMvc
        .perform(get("/svcmem/recoverMember.do")
            .param("user_recover_type", memberVO.getUser_recover_type())
            .param("user_email", memberVO.getUser_email()).param("user_nm", memberVO.getUser_nm())
            .param("user_birth", memberVO.getUser_birth()))
        .andExpect(status().isOk()).andExpect(content().string(memberVO.getUser_email()));

    verify(memberService).updateMember(any(MemberVO.class));
    verify(memberService, times(2)).recoverMember(any(MemberVO.class));
  }

  @Test
  @Ignore("sysmemPagemove.do 로 접근하는 부분은 본인확인에서 사용되는 부분이라 사용성 없음")
  public void testGetReturnUrl() throws Exception {
    fail("Not yet implemented");
  }

}
