/**
 * @class : [KTSTA] [egovframework.plani.cmm.pagination] [PlaniPaginationInfo.java]
 * @roll_definition :
 * @author : byunghanhan @ PLANI
 * @create_date : 오전 11:51:41
 * @version : 오전 11:51:41
 */
package egovframework.plani.template.cmm.pagination;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @class : [KTSTA] [egovframework.plani.cmm.pagination] [PlaniPaginationInfo.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 9. 24. 오전 11:51:41
 * @version : 1.0
 */
public class PlaniPaginationInfo extends PaginationInfo {

  private String contextPath;

  /**
   * PaginationInfo를 사용할때 처음,이전,다음,마지막 버튼의 이미지 패스를 잡기 위해 ContextPath가 필요하다.. ContextPath 값을 넘겨주기 위해서
   * PaginationInfo를 상속받는 클래스를 새로 생성한다.
   */
  public PlaniPaginationInfo() {
    // TODO Auto-generated constructor stub
  }

  public String getContextPath() {
    return contextPath;
  }

  public void setContextPath(String contextPath) {
    this.contextPath = contextPath;
  }

}
