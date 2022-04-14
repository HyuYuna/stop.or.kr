/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */
package egovframework.plani.template.cmm.pagination;

import java.text.MessageFormat;
import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : ImagePaginationRenderer.java
 * @Description : ImagePaginationRenderer Class
 * @Modification Information
 * @ @ 수정일 수정자 수정내용 @ --------- --------- ------------------------------- @ 2009.03.16 최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 * 
 *      Copyright (C) by MOPAS All right reserved.
 */
public class DftPaginationRenderer extends AbstractPaginationRenderer {

  /**
   * PaginationRenderer
   * 
   * @see 개발프레임웍크 실행환경 개발팀
   */
  public DftPaginationRenderer() {

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

    firstPageLabel =
        "<a href=\"javascript:{0}({1})\" class=\"prev\"><img src=\"{2}/images/template/paging/btn_first.gif\" alt=\"처음\" /></a>";
    previousPageLabel =
        "<a href=\"javascript:{0}({1})\" class=\"prev\"><img src=\"{2}/images/template/paging/btn_prev.gif\" alt=\"이전\" /></a>";
    currentPageLabel = "<a href=\"javascript:{0}({1})\" class=\"active\">{1}</a>";
    otherPageLabel = "<a href=\"javascript:{0}({1})\" onclick=\"{0}({1});return false; \">{2}</a>";
    nextPageLabel =
        "<a href=\"javascript:{0}({1})\"  class=\"next\"><img src=\"{2}/images/template/paging/btn_next.gif\" alt=\"다음\" /></a>";
    lastPageLabel =
        "<a href=\"javascript:{0}({1})\" class=\"next\"><img src=\"{2}/images/template/paging/btn_end.gif\" alt=\"마지막\" /></a>";

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

    strBuff.append("<span>");

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
        strBuff.append(
            MessageFormat.format(currentPageLabel, new Object[] {jsFunction, Integer.toString(i)}));
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

    strBuff.append("</span>");

    return strBuff.toString();
  }

}
