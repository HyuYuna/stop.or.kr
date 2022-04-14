package egovframework.plani.custom.memsvc.web;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import egovframework.plani.custom.memsvc.vo.LoginVO;

@Controller
public class TestkingController {

  // primitive 타입
  private int var;
  static private int s_var = 3;

  // reference 타입
  private LoginVO loginVO = new LoginVO();
  static private LoginVO sLoginVO = new LoginVO();

  public void xyz() {
    var = 5;
  }

  @RequestMapping("/contents/test_var")
  @ResponseBody
  public String test_var(LoginVO loginVO, HttpServletRequest request) {
    xyz();
    var++;
    return String.valueOf(var);
  }

  @RequestMapping("/contents/test_var2")
  @ResponseBody
  public String test_var2(LoginVO loginVO, HttpServletRequest request) {
    var++;
    return String.valueOf(var);
    // s_var++;
    // return String.valueOf(s_var);
  }

  @RequestMapping("/contents/test_setid/{id}")
  @ResponseBody
  public String test_setid(@PathVariable String id) {
    this.loginVO.setUser_id(id);
    return id + " 로 id 셋팅됨(non static)";
  }

  @RequestMapping("/contents/test_getid")
  @ResponseBody
  public String test_getid() throws Exception {

    return this.loginVO.getUser_id();
  }

  @RequestMapping("/contents/test_setid2/{id}")
  @ResponseBody
  public String test_setid2(@PathVariable String id) {
    this.sLoginVO.setUser_id(id);
    return id + " 로 id 셋팅됨(static)";
  }

  @RequestMapping("/contents/test_getid2")
  @ResponseBody
  public String test_getid2() {
    return this.sLoginVO.getUser_id();
  }

}
