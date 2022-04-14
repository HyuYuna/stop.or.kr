package egovframework.plani.template.cmm.pagination;

import java.text.MessageFormat;
import javax.servlet.ServletContext;
import org.springframework.web.context.ServletContextAware;
import egovframework.plani.template.cmm.utils.CommonUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class PlaniPaginationRenderer extends AbstractPaginationRenderer
    implements ServletContextAware {

  private ServletContext servletContext;

  /**
   * PaginationRenderer
   * 
   * @see text 페이지네이션
   */
  public PlaniPaginationRenderer() {
    firstPageLabel = "<a href=\"{0}\" class=\"arr first\">처음으로</a>";
    previousPageLabel = "<a href=\"{0}\" class=\"arr prev\">이전</a>";
    currentPageLabel = "<strong class=\"active\">{0}</strong>";
    otherPageLabel = "<a href=\"{0}\">{1}</a>";
    nextPageLabel = "<a href=\"{0}\" class=\"arr next\">다음</a>";
    lastPageLabel = "<a href=\"{0}\" class=\"arr last\">마지막으로</a>";
  }

  public void initVariables() {
    firstPageLabel = "<a href=\"{0}\" class=\"prev\"><img src=\"" + servletContext.getContextPath()
        + "/images/template/paging/btn_first.gif\" alt=\"{1}\" /></a>";
    previousPageLabel =
        "<a href=\"{0}\" class=\"prev\"><img src=\"" + servletContext.getContextPath()
            + "/images/template/paging/btn_prev.gif\" alt=\"{1}\" /></a>";
    currentPageLabel = "<a href=\"{0}\" class=\"active\">{1}</a>";
    otherPageLabel = "<a href=\"{0}\">{1}</a>";
    nextPageLabel = "<a href=\"{0}\"  class=\"next\"><img src=\"" + servletContext.getContextPath()
        + "/images/template/paging/btn_next.gif\" alt=\"{1}\" /></a>";
    lastPageLabel = "<a href=\"{0}\" class=\"next\"><img src=\"" + servletContext.getContextPath()
        + "/images/template/paging/btn_end.gif\" alt=\"{1}\" /></a>";
  }

  @Override
  public void setServletContext(ServletContext servletContext) {
    this.servletContext = servletContext;
    this.initVariables();
  }

  @Override
  public String renderPagination(PaginationInfo paginationInfo, String jsFunction) {
    String pageIndex = CommonUtil.getUrl(null, "pageIndex={0}", true);
    // System.out.println(pageIndex);
    // MessageFormat.format(pageIndex, new Object[] {Integer.toString(firstPageNo)})
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

    strBuff.append("<span>");

    if (firstPageNoOnPageList > pageSize) {
      strBuff.append(MessageFormat.format(firstPageLabel,
          new Object[] {
              MessageFormat.format(pageIndex, new Object[] {Integer.toString(firstPageNo)}),
              MessageHelper.getMessage("PAGE.FIRST"), context}));

      strBuff.append(MessageFormat.format(previousPageLabel,
          new Object[] {
              MessageFormat.format(pageIndex,
                  new Object[] {Integer.toString(firstPageNoOnPageList - 1)}),
              MessageHelper.getMessage("PAGE.PREV"), context}));
    } else {
      strBuff.append(MessageFormat.format(firstPageLabel,
          new Object[] {
              MessageFormat.format(pageIndex, new Object[] {Integer.toString(firstPageNo)}),
              MessageHelper.getMessage("PAGE.FIRST"), context}));
      strBuff.append(MessageFormat.format(previousPageLabel,
          new Object[] {
              MessageFormat.format(pageIndex, new Object[] {Integer.toString(firstPageNo)}),
              MessageHelper.getMessage("PAGE.PREV"), context}));
    }

    for (int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++) {
      if (i == currentPageNo) {
        strBuff
            .append(
                MessageFormat.format(currentPageLabel,
                    new Object[] {
                        MessageFormat.format(pageIndex, new Object[] {Integer.toString(i)}),
                        Integer.toString(i)}));
      } else {
        strBuff
            .append(
                MessageFormat.format(otherPageLabel,
                    new Object[] {
                        MessageFormat.format(pageIndex, new Object[] {Integer.toString(i)}),
                        Integer.toString(i)}));
      }
    }

    if (lastPageNoOnPageList < totalPageCount) {
      strBuff.append(MessageFormat.format(nextPageLabel,
          new Object[] {
              MessageFormat.format(pageIndex,
                  new Object[] {Integer.toString(firstPageNoOnPageList + pageSize)}),
              MessageHelper.getMessage("PAGE.NEXT"), context}));
      strBuff.append(MessageFormat.format(lastPageLabel,
          new Object[] {
              MessageFormat.format(pageIndex, new Object[] {Integer.toString(lastPageNo)}),
              MessageHelper.getMessage("PAGE.END"), context}));
    } else {
      strBuff.append(MessageFormat.format(nextPageLabel,
          new Object[] {
              MessageFormat.format(pageIndex, new Object[] {Integer.toString(lastPageNo)}),
              MessageHelper.getMessage("PAGE.NEXT"), context}));
      strBuff.append(MessageFormat.format(lastPageLabel,
          new Object[] {
              MessageFormat.format(pageIndex, new Object[] {Integer.toString(lastPageNo)}),
              MessageHelper.getMessage("PAGE.END"), context}));
    }

    strBuff.append("</span>");

    return strBuff.toString();
  }

}
