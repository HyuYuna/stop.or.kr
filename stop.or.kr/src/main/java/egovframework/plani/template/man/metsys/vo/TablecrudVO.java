package egovframework.plani.template.man.metsys.vo;

import egovframework.plani.template.cmm.vo.DefaultSearchVO;

/**
 * 테이블 정보 VO : 컬럼명을 통한 VO 자동 생성에 사용함.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.metsys.vo] [TablecrudVO.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오전 11:35:36
 * @version : 1.0
 */
public class TablecrudVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  /** 소유자 */
  private String owner;

  /** 테이블 접두어 */
  private String table_prefix_01;
  private String table_prefix_02;

  /** 테이블 명 */
  private String table_schema;

  /** 테이블 명 */
  private String table_name;

  /** 컬럼 명 */
  private String column_name;

  /** 데이터 타입 */
  private String data_type;

  /** 데이터 길이 */
  private int data_length;

  /** 널 허용 여부 */
  private String nullable;

  /** 주석 */
  private String comments;

  /** PK 여부 */
  private String constraint_type;

  public String getOwner() {
    return owner;
  }

  public void setOwner(String owner) {
    this.owner = owner;
  }

  public String getTable_name() {
    return table_name;
  }

  public void setTable_name(String table_name) {
    this.table_name = table_name;
  }

  public String getColumn_name() {
    return column_name;
  }

  public void setColumn_name(String column_name) {
    this.column_name = column_name;
  }

  public String getData_type() {
    return data_type;
  }

  public void setData_type(String data_type) {
    this.data_type = data_type;
  }

  public int getData_length() {
    return data_length;
  }

  public void setData_length(int data_length) {
    this.data_length = data_length;
  }

  public String getNullable() {
    return nullable;
  }

  public void setNullable(String nullable) {
    this.nullable = nullable;
  }

  public String getComments() {
    return comments;
  }

  public void setComments(String comments) {
    this.comments = comments;
  }

  public String getConstraint_type() {
    return constraint_type;
  }

  public void setConstraint_type(String constraint_type) {
    this.constraint_type = constraint_type;
  }

  public String getTable_schema() {
    return table_schema;
  }

  public void setTable_schema(String table_schema) {
    this.table_schema = table_schema;
  }

  public String getTable_prefix_01() {
    return table_prefix_01;
  }

  public void setTable_prefix_01(String table_prefix_01) {
    this.table_prefix_01 = table_prefix_01;
  }

  public String getTable_prefix_02() {
    return table_prefix_02;
  }

  public void setTable_prefix_02(String table_prefix_02) {
    this.table_prefix_02 = table_prefix_02;
  }



}

