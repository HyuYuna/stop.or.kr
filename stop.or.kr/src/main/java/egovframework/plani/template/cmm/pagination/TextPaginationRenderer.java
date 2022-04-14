package egovframework.plani.template.cmm.pagination;

import java.text.MessageFormat;
import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class TextPaginationRenderer extends AbstractPaginationRenderer {


  /**
   * PaginationRenderer
   * 
   * @see text 페이지네이션
   */
  public TextPaginationRenderer() {

    // String strWebDir = "/egovframework.guideprogram.basic/images/egovframework/cmmn/"; //
    // localhost
    // String strWebDir = "/###ARTIFACT_ID###/images/egovframework/cmmn/";
    /*
     * String strWebDir = "/images/egovframework/cmmn/"; firstPageLabel =
     * "<a href=\"#\" onclick=\"{0}({1}); return false;\">" + "<image src='" + strWebDir +
     * "btn_page_pre10.gif' border=0/></a>&#160;"; previousPageLabel =
     * "<a href=\"#\" onclick=\"{0}({1}); return false;\">" + "<image src='" + strWebDir +
     * "btn_page_pre1.gif' border=0/></a>&#160;"; currentPageLabel = "<strong>{0}</strong>&#160;";
     * otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
     * nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">" + "<image src='" +
     * strWebDir + "btn_page_next10.gif' border=0/></a>&#160;"; lastPageLabel =
     * "<a href=\"#\" onclick=\"{0}({1}); return false;\">" + "<image src='" + strWebDir +
     * "btn_page_next1.gif' border=0/></a>&#160;";
     */

    firstPageLabel = "<a href=\"javascript:{0}({1})\" class=\"arr first\">처음으로</a>";
    previousPageLabel = "<a href=\"javascript:{0}({1})\" class=\"arr prev\">이전</a>";
    currentPageLabel = "<strong class=\"active\">{1}</strong>";
    otherPageLabel = "<a href=\"javascript:{0}({1})\" onclick=\"{0}({1});return false; \">{2}</a>";
    nextPageLabel = "<a href=\"javascript:{0}({1})\"  class=\"arr next\">다음</a>";
    lastPageLabel = "<a href=\"javascript:{0}({1})\" class=\"arr last\">마지막으로</a>";

  }


  @Override
  public String renderPagination(PaginationInfo paginationInfo, String jsFunction) {
    // TODO Auto-generated method stub

    PlaniPaginationInfo pagination = (PlaniPaginationInfo) paginationInfo;

    StringBuffer strBuff = new StringBuffer();

    int firstPageNo = pagination.getFirstPageNo();
    int firstPageNoOnPageList = pagination.getFirstPageNoOnPageList();
    int totalPageCount = pagination.getTotalPageCount();
    int pageSize = pagination.getPageSize();
    int lastPageNoOnPageList = pagination.getLastPageNoOnPageList();
    int currentPageNo = pagination.getCurrentPageNo();
    int lastPageNo = pagination.getLastPageNo();
    String context = pagination.getContextPath() == null ? "" : pagination.getContextPath();

    // strBuff.append("<p>");

    // if(totalPageCount > pageSize){
    if (firstPageNoOnPageList > pageSize) {
      strBuff.append(MessageFormat.format(firstPageLabel,
          new Object[] {jsFunction, Integer.toString(firstPageNo), context}));
      strBuff.append(MessageFormat.format(previousPageLabel,
          new Object[] {jsFunction, Integer.toString(firstPageNoOnPageList - 1), context}));
    } else {
      strBuff.append(MessageFormat.format(firstPageLabel,
          new Object[] {jsFunction, Integer.toString(firstPageNo), context}));
      strBuff.append(MessageFormat.format(previousPageLabel,
          new Object[] {jsFunction, Integer.toString(firstPageNo), context}));
    }
    // }

    for (int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++) {
      if (i == currentPageNo) {
        strBuff.append(MessageFormat.format(currentPageLabel,
            new Object[] {jsFunction, Integer.toString(i)}));
      } else {
        strBuff.append(MessageFormat.format(otherPageLabel,
            new Object[] {jsFunction, Integer.toString(i), Integer.toString(i)}));
      }
    }

    // if(totalPageCount > pageSize){
    if (lastPageNoOnPageList < totalPageCount) {
      strBuff.append(MessageFormat.format(nextPageLabel,
          new Object[] {jsFunction, Integer.toString(firstPageNoOnPageList + pageSize), context}));
      strBuff.append(MessageFormat.format(lastPageLabel,
          new Object[] {jsFunction, Integer.toString(lastPageNo), context}));
    } else {
      strBuff.append(MessageFormat.format(nextPageLabel,
          new Object[] {jsFunction, Integer.toString(lastPageNo), context}));
      strBuff.append(MessageFormat.format(lastPageLabel,
          new Object[] {jsFunction, Integer.toString(lastPageNo), context}));
    }
    // }

    // strBuff.append("</p>");

    return strBuff.toString();
  }

}
