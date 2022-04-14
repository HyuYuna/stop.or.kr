package egovframework.plani.template.man.metsys.web;

import static org.junit.Assert.fail;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
import javax.servlet.http.HttpServletRequest;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.RequestPostProcessor;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.rte.fdl.property.EgovPropertyService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml",
    "file:src/main/webapp/WEB-INF/config/egovframework/springmvc/dispatcher-servlet.xml"})
@WebAppConfiguration
public class ModeurControllerTest {

  private MockMvc mockMvc;

  @Mock
  private MemberService memberService;

  @Mock
  private ManlogService manlogService;

  @Mock
  private EgovPropertyService propertiesService;

  @InjectMocks
  private ModeurController modeurController;

  private MemberVO memberVO;
  private String sessionId;

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

    sessionId = "3"; // 임의의 세션ID

    this.mockMvc = MockMvcBuilders.standaloneSetup(modeurController).alwaysDo(print()).build();

    when(propertiesService.getInt("pageUnit")).thenReturn(10);
    when(propertiesService.getInt("pageSize")).thenReturn(15);

  }

  @Test
  public void testModeurList() throws Exception {
    doNothing().when(manlogService).insertManlog(any(HttpServletRequest.class), eq("USR_MAN"),
        eq("사용자관리"), eq("사용자 목록조회"), eq("L"));

    mockMvc.perform(get("/modeur/modeurList.do").param("pageIndex", "1")
        .sessionAttr("SESS_USR_INFO", memberVO).with(new RequestPostProcessor() {
          @Override
          public MockHttpServletRequest postProcessRequest(MockHttpServletRequest request) {
            request.setRequestedSessionId(sessionId);
            return request;
          }
        })).andExpect(status().isOk()).andExpect(view().name("/modeur/modeurList"));

    verify(manlogService).insertManlog(any(HttpServletRequest.class), eq("USR_MAN"), eq("사용자관리"),
        eq("사용자 목록조회"), eq("L"));
  }

  @Test
  public void testModeurView() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testRmvModeur() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testMdfModeur() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testAddModeur() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testModeurScrtcheck() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testXlsModeurList() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testWithdrawalList() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testRmvWithdrawal() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testXlsWithdrawalSave() throws Exception {
    fail("Not yet implemented");
  }

}
