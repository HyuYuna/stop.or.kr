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
package egovframework.plani.template.cmm.vo;

import java.io.Serializable;
import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : SampleDefaultVO.java
 * @Description : SampleDefaultVO Class
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
public class DefaultSearchVO implements Serializable {

  private static final long serialVersionUID = 5449770115329813385L;

  /** 검색타입 */
  protected String searchType = "";

  /** 페이지 처리 순번 */
  protected int rn;

  /** 검색조건 */
  protected String searchCondition = "";

  /** 검색Keyword */
  protected String searchKeyword = "";

  /** 검색 설정 쿼리 */
  protected String searchQuery = "";

  /** 검색 설정 쿼리 */
  protected String orderbyQuery = "";

  /** 검색사용여부 */
  protected String searchUseYn = "";

  /** 현재페이지 */
  protected int pageIndex = 1;

  /** 페이지갯수 */
  protected int pageUnit = 0;

  /** 페이지사이즈 */
  protected int pageSize = 0;

  /** 조회 시작일 (~부터) */
  protected String srchFromDT;

  /** 조회 종료일 (~까지) */
  protected String srchToDT;

  /** firstIndex */
  protected int firstIndex = 0;

  /** lastIndex */
  protected int lastIndex = 1;

  /** recordCountPerPage */
  protected int recordCountPerPage = 10;

  /** 작성자 */
  protected String writer;
  protected String writer_nm;

  /** 작성일 */
  protected String wdt;

  /** 수정자 */
  protected String modifier;
  protected String modifier_nm;

  /** 수정일 */
  protected String mdt;

  /** 페이지 조회 모드 */
  protected String edomweivgp = "R";

  /** 메뉴를 포함하고 있을때 메뉴 고유 코드 */
  protected String menu_nix; // 메뉴 고유코드
  protected String srch_menu_nix; // <== 메뉴 조회를 위한 메뉴고유코드

  /** 파일확인 키 (키값이 모두 노출되는 경우 아무파일이나 조회하는 것을 방지하기 위해 사용) */
  private String vchkcode;
  private String thumbcode;

  /** 모바일용 파일확인 키 (키값이 모두 노출되는 경우 아무파일이나 조회하는 것을 방지하기 위해 사용) */
  private String mvchkcode;

  /** 선택된 탭 순번 */
  private int seltab_idx;


  /** 이전글 */
  private String pre_atcl;
  private String pre_subj;

  /** 다음글 */
  private String next_atcl;
  private String next_subj;

  /** 메뉴 구분 (관리자 / 사용자) */
  private String mu_gub = "USR";
  private String srch_mu_gub = "USR";

  /** 사이트 구분 (대표웹 / 모바일 / 서브사이트) */
  private String mu_site = "CDIDX00002";
  private String srch_mu_site = "CDIDX00002";

  /** 언어 구분 (한국어 CDIDX00022 / 영어 CDIDX00023 / 중국어 CDIDX00024 / 일본어 CDIDX00025) */
  private String mu_lang = "CDIDX00022";
  private String srch_mu_lang = "CDIDX00022";

  /** Connect by 를 쓸 수 없을때, 결과 리스트를 계층적으로 정렬하기 위해 사용 */
  private int connectOrder = 0;

  //////////////////////////////////////
  // jqGrid 속성 Start
  //////////////////////////////////////
  /** 현재 페이지 번호 */
  protected int page = 1;

  /** 페이지당 레코드 수 */
  protected int rows = 15;

  /** 정렬 기준값 */
  protected String sidx = "";

  /** 정렬 방법 */
  protected String sord = "DESC";

  private String sortstr = "";
  //////////////////////////////////////
  // jqGrid 속성 End
  //////////////////////////////////////

  public int getRn() {
    return rn;
  }

  public void setRn(int rn) {
    this.rn = rn;
  }

  public int getFirstIndex() {
    return firstIndex;
  }

  public void setFirstIndex(int firstIndex) {
    this.firstIndex = firstIndex;
  }

  public int getLastIndex() {
    return lastIndex;
  }

  public void setLastIndex(int lastIndex) {
    this.lastIndex = lastIndex;
  }

  public int getRecordCountPerPage() {
    return recordCountPerPage;
  }

  public void setRecordCountPerPage(int recordCountPerPage) {
    this.recordCountPerPage = recordCountPerPage;
  }

  public String getSearchCondition() {
    return searchCondition;
  }

  public void setSearchCondition(String searchCondition) {
    this.searchCondition = searchCondition;
  }

  public String getSearchKeyword() {
    return searchKeyword;
  }

  public void setSearchKeyword(String searchKeyword) {
    this.searchKeyword = searchKeyword;
  }

  public String getSearchUseYn() {
    return searchUseYn;
  }

  public void setSearchUseYn(String searchUseYn) {
    this.searchUseYn = searchUseYn;
  }

  public int getPageIndex() {
    return pageIndex;
  }

  public void setPageIndex(int pageIndex) {
    this.pageIndex = pageIndex;
  }

  public int getPageUnit() {
    return pageUnit;
  }

  public void setPageUnit(int pageUnit) {
    this.pageUnit = pageUnit;
  }

  public int getPageSize() {
    return pageSize;
  }

  public void setPageSize(int pageSize) {
    this.pageSize = pageSize;
  }

  @Override
  public String toString() {
    return ToStringBuilder.reflectionToString(this);
  }


  public String getSearchQuery() {
    return searchQuery;
  }

  public void setSearchQuery(String searchQuery) {
    this.searchQuery = searchQuery;
  }

  public String getOrderbyQuery() {
    return orderbyQuery;
  }

  public void setOrderbyQuery(String orderbyQuery) {
    this.orderbyQuery = orderbyQuery;
  }

  public String getSrchFromDT() {
    return srchFromDT;
  }

  public void setSrchFromDT(String srchFromDT) {
    this.srchFromDT = srchFromDT;
  }

  public String getSrchToDT() {
    return srchToDT;
  }

  public void setSrchToDT(String srchToDT) {
    this.srchToDT = srchToDT;
  }

  public String getWriter() {
    return writer;
  }

  public void setWriter(String writer) {
    this.writer = writer;
  }

  public String getWdt() {
    return wdt;
  }

  public void setWdt(String wdt) {
    this.wdt = wdt;
  }

  public String getModifier() {
    return modifier;
  }

  public void setModifier(String modifier) {
    this.modifier = modifier;
  }

  public String getMdt() {
    return mdt;
  }

  public void setMdt(String mdt) {
    this.mdt = mdt;
  }

  public String getEdomweivgp() {
    return edomweivgp;
  }

  public void setEdomweivgp(String edomweivgp) {
    this.edomweivgp = edomweivgp;
  }

  public String getSrch_menu_nix() {
    return srch_menu_nix;
  }

  public void setSrch_menu_nix(String srch_menu_nix) {
    this.srch_menu_nix = srch_menu_nix;
  }

  public String getMenu_nix() {
    return menu_nix;
  }

  public void setMenu_nix(String menu_nix) {
    this.menu_nix = menu_nix;
  }

  public int getRows() {
    return rows;
  }

  public void setRows(int rows) {
    this.rows = rows;
  }

  public void setSortstr(String sortstr) {
    this.sortstr = sortstr;
  }

  public String getSidx() {
    return sidx;
  }

  public void setSidx(String sidx) {
    this.sidx = sidx;
  }

  public String getSord() {
    return sord;
  }

  public void setSord(String sord) {
    this.sord = sord;
  }

  public int getPage() {
    return page;
  }

  public void setPage(int page) {
    this.page = page;
  }

  public String getSortstr() {
    String retVal = "";

    if (sidx != null && !"".equals(sidx)) {
      retVal = "ORDER BY ";
      String[] idx = sidx.split(",");
      for (int i = 0; i < idx.length; i++) {
        if (i == 0)
          retVal += idx[i] + " " + sord;
        else
          retVal += "," + idx[i] + " " + sord;
      }
    }
    sortstr = retVal;
    return sortstr;
  }

  public String getVchkcode() {
    return vchkcode;
  }

  public void setVchkcode(String vchkcode) {
    this.vchkcode = vchkcode;
  }

  public String getPre_atcl() {
    return pre_atcl;
  }

  public void setPre_atcl(String pre_atcl) {
    this.pre_atcl = pre_atcl;
  }

  public String getPre_subj() {
    return pre_subj;
  }

  public void setPre_subj(String pre_subj) {
    this.pre_subj = pre_subj;
  }

  public String getNext_atcl() {
    return next_atcl;
  }

  public void setNext_atcl(String next_atcl) {
    this.next_atcl = next_atcl;
  }

  public String getNext_subj() {
    return next_subj;
  }

  public void setNext_subj(String next_subj) {
    this.next_subj = next_subj;
  }

  public String getMvchkcode() {
    return mvchkcode;
  }

  public void setMvchkcode(String mvchkcode) {
    this.mvchkcode = mvchkcode;
  }

  public String getMu_gub() {
    return mu_gub;
  }

  public void setMu_gub(String mu_gub) {
    this.mu_gub = mu_gub;
  }

  public String getMu_lang() {
    return mu_lang;
  }

  public void setMu_lang(String mu_lang) {
    this.mu_lang = mu_lang;
  }

  public int getConnectOrder() {
    return connectOrder;
  }

  public void setConnectOrder(int connectOrder) {
    this.connectOrder = connectOrder;
  }

  public int getSeltab_idx() {
    return seltab_idx;
  }

  public void setSeltab_idx(int seltab_idx) {
    this.seltab_idx = seltab_idx;
  }

  public String getSearchType() {
    return searchType;
  }

  public void setSearchType(String searchType) {
    this.searchType = searchType;
  }

  public String getMu_site() {
    return mu_site;
  }

  public void setMu_site(String mu_site) {
    this.mu_site = mu_site;
  }

  public String getWriter_nm() {
    return writer_nm;
  }

  public void setWriter_nm(String writer_nm) {
    this.writer_nm = writer_nm;
  }

  public String getModifier_nm() {
    return modifier_nm;
  }

  public void setModifier_nm(String modifier_nm) {
    this.modifier_nm = modifier_nm;
  }

  public String getSrch_mu_gub() {
    return srch_mu_gub;
  }

  public void setSrch_mu_gub(String srch_mu_gub) {
    this.srch_mu_gub = srch_mu_gub;
  }

  public String getSrch_mu_site() {
    return srch_mu_site;
  }

  public void setSrch_mu_site(String srch_mu_site) {
    this.srch_mu_site = srch_mu_site;
  }

  public String getSrch_mu_lang() {
    return srch_mu_lang;
  }

  public void setSrch_mu_lang(String srch_mu_lang) {
    this.srch_mu_lang = srch_mu_lang;
  }

  public String getThumbcode() {
    return thumbcode;
  }

  public void setThumbcode(String thumbcode) {
    this.thumbcode = thumbcode;
  }



}
