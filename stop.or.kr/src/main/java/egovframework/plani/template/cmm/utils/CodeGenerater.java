package egovframework.plani.template.cmm.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;
import java.util.List;
import javax.annotation.Resource;
import egovframework.plani.template.cmm.vo.GenActfilesVO;
import egovframework.plani.template.cmm.web.Globals;
import egovframework.plani.template.man.metsys.service.TablecrudService;
import egovframework.plani.template.man.metsys.vo.TablecrudVO;

/**
 * 액션파일을 자동 생성한다. 특정 개체가 추가될때 필요한 기본 코드(CURD)를 자동 생성 함..
 * 
 * @class : [egovframework] [plani.template.cmm.utils] [CodeGenerater.java]
 * @author : ByunghanHan
 * @date : 2011. 2. 10. 오후 4:46:40
 */
public class CodeGenerater {
  private GenActfilesVO genVO = null;
  private String pkgnm_ctrl = null;
  private String pkgnm_man_ctrl = null;
  private String clsnm_ctrl = null;
  private String pkgnm_vo = null;
  private String clsnm_vo = null;
  private String pkgnm_svc = null;
  private String clsnm_svc = null;
  private String pkgnm_impl = null;
  private String clsnm_impl = null;
  private String pkgnm_dao = null;
  private String clsnm_dao = null;
  private String pkgnm_sqlmap = null;
  private String clsnm_sqlmap = null;

  private String baseacttable = null;

  private List<TablecrudVO> tablecrudList = null;

  private boolean useClob = false;

  /** TablecrudService */
  @Resource(name = "tablecrudService")
  private TablecrudService tablecrudService;

  public CodeGenerater(GenActfilesVO gvo, List<TablecrudVO> tablelist) throws Exception {
    genVO = gvo;

    baseacttable = gvo.getBaseacttable();
    tablecrudList = tablelist;

    String ctrl = genVO.getCtrl(); // controller 파일 설정
    pkgnm_ctrl = ctrl.substring(0, ctrl.lastIndexOf(".")); // 설정에서 패키지 명 구하기
    String ctrl_man = genVO.getCtrl_man(); // controller 파일 설정
    pkgnm_man_ctrl = ctrl_man.substring(0, ctrl_man.lastIndexOf(".")); // 설정에서 패키지 명 구하기
    clsnm_ctrl = ctrl.substring(ctrl.lastIndexOf(".") + 1, ctrl.length()); // 설정에서 클래스 명 구하기

    String vo = genVO.getVo(); // vo 파일 설정
    pkgnm_vo = vo.substring(0, vo.lastIndexOf(".")); // 설정에서 패키지 명 구하기
    clsnm_vo = vo.substring(vo.lastIndexOf(".") + 1, vo.length()); // 설정에서 클래스 명 구하기

    String svc = genVO.getSvc(); // svc 파일 설정
    pkgnm_svc = svc.substring(0, svc.lastIndexOf(".")); // 설정에서 패키지 명 구하기
    clsnm_svc = svc.substring(svc.lastIndexOf(".") + 1, svc.length()); // 설정에서 클래스 명 구하기

    String impl = genVO.getImpl(); // impl 파일 설정
    pkgnm_impl = impl.substring(0, impl.lastIndexOf(".")); // 설정에서 패키지 명 구하기
    clsnm_impl = impl.substring(impl.lastIndexOf(".") + 1, impl.length()); // 설정에서 클래스 명 구하기

    String dao = genVO.getDao(); // dao 파일 설정
    pkgnm_dao = dao.substring(0, dao.lastIndexOf(".")); // 설정에서 패키지 명 구하기
    clsnm_dao = dao.substring(dao.lastIndexOf(".") + 1, dao.length()); // 설정에서 클래스 명 구하기

    String sqlmap = genVO.getSqlmap(); // sqlmap 파일 설정
    pkgnm_sqlmap = sqlmap.substring(0, sqlmap.lastIndexOf(".")); // 설정에서 패키지 명 구하기
    clsnm_sqlmap = sqlmap.substring(sqlmap.lastIndexOf(".") + 1, sqlmap.length()); // 설정에서 클래스 명 구하기

  }

  public void genereateSrcAll() throws Exception {
    String ctrlpath = getPkg2RealPathJava(genVO.getSrc(), genVO.getCtrl());
    String vopath = getPkg2RealPathJava(genVO.getSrc(), genVO.getVo());
    String svcpath = getPkg2RealPathJava(genVO.getSrc(), genVO.getSvc());
    String implpath = getPkg2RealPathJava(genVO.getSrc(), genVO.getImpl());
    String daopath = getPkg2RealPathJava(genVO.getSrc(), genVO.getDao());
    String sqlmappath = getPkg2RealPathSqlmap(genVO.getSrc(), genVO.getSqlmap());

    generateCtlr(ctrlpath, "U");
    generateVO(vopath);
    generateSvc(svcpath);
    generateImpl(implpath);
    generateDAO(daopath);
    generateSqlmap(sqlmappath);
  }


  public void deleteAll() throws Exception {
    String ctrlpath = getPkg2RealPathJava(genVO.getSrc(), genVO.getCtrl());
    String ctrl_manpath = getPkg2RealPathJava(genVO.getSrc(), genVO.getCtrl_man());
    String vopath = getPkg2RealPathJava(genVO.getSrc(), genVO.getVo());
    String svcpath = getPkg2RealPathJava(genVO.getSrc(), genVO.getSvc());
    String implpath = getPkg2RealPathJava(genVO.getSrc(), genVO.getImpl());
    String daopath = getPkg2RealPathJava(genVO.getSrc(), genVO.getDao());
    String sqlmappath = getPkg2RealPathSqlmap(genVO.getSrc(), genVO.getSqlmap());

    deleteFile(ctrlpath);
    deleteFile(ctrl_manpath);
    deleteFile(vopath);
    deleteFile(svcpath);
    deleteFile(implpath);
    deleteFile(daopath);
    deleteFile(sqlmappath);
    // deleteFile(ctrlpath.substring(0, ctrlpath.lastIndexOf(genVO.getDir()) +
    // genVO.getDir().length()) ); 너무 위험해서 사용하지 않기로...
  }

  private void generateCtlr(String realpath, String mu_gub) throws Exception {
    // 파일이 이미 존재하는경우 삭제한다.
    deleteFile(realpath);

    File pathdir = new File(realpath.substring(0, realpath.lastIndexOf("/")));
    if (!pathdir.exists())
      pathdir.mkdirs();

    StringBuffer sb_ = new StringBuffer();

    // 템플릿 파일을 로드한다.
    String tmplfilepath = genVO.getSrc();
    String actprefix = "";
    if (mu_gub.equals("M")) {
      tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/java_tmpl/controller_man.tmpl");
      actprefix = "/manact";
    } else {
      tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/java_tmpl/controller_user.tmpl");
      actprefix = "/usract";
    }


    FileReader tmplfile = new FileReader(new File(tmplfilepath));

    int ch;
    while ((ch = tmplfile.read()) >= 0) {
      sb_.append((char) ch);
    }
    tmplfile.close();

    // 템플릿 파일에서 필요한 내용을 새로 생성되는 내용에 맞게 치환한다.
    replaceArgs(sb_);
    EgovWebUtil.replaceallSB(sb_, "{##PKG_NM##}", pkgnm_ctrl);
    EgovWebUtil.replaceallSB(sb_, "{##PKG_MAN_NM##}", pkgnm_man_ctrl);

    // 엑셀저장 컬럼 정의 부분
    String coldef = "";
    coldef += "{\"RN\",\t\t\"순번\"},\n";
    for (int i = 0; i < tablecrudList.size(); i++) {
      TablecrudVO tVO = (TablecrudVO) tablecrudList.get(i);
      coldef += "\t\t\t{\"" + tVO.getColumn_name() + "\",\t\t\"" + tVO.getComments() + "\"}";
      coldef += ((i + 1) == tablecrudList.size()) ? "\n" : ",\n";
    }

    // 엑셀저장 컬럼 값 설정 부분
    String colset = "";
    colset += "rsmap.put(\"RN\", vo.getRn());\n";
    for (int i = 0; i < tablecrudList.size(); i++) {
      TablecrudVO tVO = (TablecrudVO) tablecrudList.get(i);
      colset += "\t\t\trsmap.put(\"" + tVO.getColumn_name() + "\", vo.get"
          + getUpper1stChar(tVO.getColumn_name().toLowerCase()) + "());\n";
    }

    EgovWebUtil.replaceallSB(sb_, "{##EXCEL_COLDEF_ITER##}", coldef);
    EgovWebUtil.replaceallSB(sb_, "{##EXCEL_COLSET_ITER##}", colset);
    EgovWebUtil.replaceallSB(sb_, "{##MANACT_PREFIX##}", actprefix);
    EgovWebUtil.replaceallSB(sb_, "{##USRACT_PREFIX##}", actprefix);

    try {

      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

  }

  private void generateVO(String realpath) throws Exception {
    // 파일이 이미 존재하는경우 삭제한다.
    deleteFile(realpath);

    File pathdir = new File(realpath.substring(0, realpath.lastIndexOf("/")));
    if (!pathdir.exists())
      pathdir.mkdirs();

    StringBuffer sb_ = new StringBuffer();

    sb_.append("package " + pkgnm_vo + ";\n");
    sb_.append("\n");
    sb_.append("import egovframework.plani.template.cmm.vo.DefaultSearchVO;\n");
    sb_.append("\n");
    sb_.append("public class " + clsnm_vo + " extends DefaultSearchVO {\n");
    sb_.append("\n");
    sb_.append("\tprivate static final long serialVersionUID = 1L;\n");
    sb_.append("\n");

    StringBuffer getsetStr = new StringBuffer();

    for (int i = 0; i < tablecrudList.size(); i++) {
      TablecrudVO tVO = (TablecrudVO) tablecrudList.get(i);

      String colName = tVO.getColumn_name().toLowerCase();
      if ("writer".equals(colName) || "wdt".equals(colName) || "modifier".equals(colName)
          || "mdt".equals(colName))
        continue;

      String getter =
          "\tpublic String get" + getUpper1stChar(tVO.getColumn_name().toLowerCase()) + "(){\n";
      String setter = "\tpublic void set" + getUpper1stChar(tVO.getColumn_name().toLowerCase())
          + "(String " + tVO.getColumn_name().toLowerCase() + "){\n";

      if ("DATE|DATATIME|TIMESTAMP".indexOf(tVO.getData_type().toUpperCase()) >= 0) {
        sb_.append("\t/** " + tVO.getComments() + " */\n");
        sb_.append("\tprivate String " + tVO.getColumn_name().toLowerCase() + ";\n");
      } else if ("NUMBER|INT|TINYINT".indexOf(tVO.getData_type().toUpperCase()) >= 0) {
        sb_.append("\t/** " + tVO.getComments() + " */\n");
        sb_.append("\tprivate int " + tVO.getColumn_name().toLowerCase() + " = 0;\n");
        getter = "\tpublic int get" + getUpper1stChar(tVO.getColumn_name().toLowerCase()) + "(){\n";
        setter = "\tpublic void set" + getUpper1stChar(tVO.getColumn_name().toLowerCase()) + "(int "
            + tVO.getColumn_name().toLowerCase() + "){\n";
      } else if ("CLOB|TEXT|BLOB".indexOf(tVO.getData_type().toUpperCase()) >= 0) {
        sb_.append("\t/** " + tVO.getComments() + " */\n");
        sb_.append("\tprivate String " + tVO.getColumn_name().toLowerCase() + ";\n");
      } else {
        sb_.append("\t/** " + tVO.getComments() + " */\n");
        sb_.append("\tprivate String " + tVO.getColumn_name().toLowerCase() + ";\n");
      }
      sb_.append("\n");

      getter += "\t\t return " + tVO.getColumn_name().toLowerCase() + ";\n";
      getter += "\t}\n\n";
      setter += "\t\t this." + tVO.getColumn_name().toLowerCase() + " = "
          + tVO.getColumn_name().toLowerCase() + ";\n";
      setter += "\t}\n\n";

      getsetStr.append(getter);
      getsetStr.append(setter);

    }

    sb_.append(getsetStr);
    sb_.append("}\n");

    try {

      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

  }


  private void generateSvc(String realpath) throws Exception {
    // 파일이 이미 존재하는경우 삭제한다.
    deleteFile(realpath);

    File pathdir = new File(realpath.substring(0, realpath.lastIndexOf("/")));
    if (!pathdir.exists())
      pathdir.mkdirs();

    StringBuffer sb_ = new StringBuffer();

    // 템플릿 파일을 읽어온다.
    String tmplfilepath = genVO.getSrc();
    tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/java_tmpl/service.tmpl");
    FileReader tmplfile = new FileReader(new File(tmplfilepath));

    int ch;
    while ((ch = tmplfile.read()) >= 0) {
      sb_.append((char) ch);
    }
    tmplfile.close();

    replaceArgs(sb_);
    EgovWebUtil.replaceallSB(sb_, "{##PKG_NM##}", pkgnm_svc);

    try {

      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

  }



  private void generateImpl(String realpath) throws Exception {
    // 파일이 이미 존재하는경우 삭제한다.
    deleteFile(realpath);

    File pathdir = new File(realpath.substring(0, realpath.lastIndexOf("/")));
    if (!pathdir.exists())
      pathdir.mkdirs();

    StringBuffer sb_ = new StringBuffer();
    // 템플릿 파일을 읽어온다.
    String tmplfilepath = genVO.getSrc();
    tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/java_tmpl/service_impl.tmpl");
    FileReader tmplfile = new FileReader(new File(tmplfilepath));

    int ch;
    while ((ch = tmplfile.read()) >= 0) {
      sb_.append((char) ch);
    }
    tmplfile.close();

    replaceArgs(sb_);
    EgovWebUtil.replaceallSB(sb_, "{##PKG_NM##}", pkgnm_impl);

    try {

      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

  }

  private void generateDAO(String realpath) throws Exception {

    // 파일이 이미 존재하는경우 삭제한다.
    deleteFile(realpath);

    File pathdir = new File(realpath.substring(0, realpath.lastIndexOf("/")));
    if (!pathdir.exists())
      pathdir.mkdirs();

    StringBuffer sb_ = new StringBuffer();

    // 템플릿 파일을 읽어온다.
    String tmplfilepath = genVO.getSrc();
    tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/java_tmpl/dao.tmpl");
    FileReader tmplfile = new FileReader(new File(tmplfilepath));

    int ch;
    while ((ch = tmplfile.read()) >= 0) {
      sb_.append((char) ch);
    }
    tmplfile.close();

    replaceArgs(sb_);
    EgovWebUtil.replaceallSB(sb_, "{##PKG_NM##}", pkgnm_dao);

    try {
      // 파일이 이미 존재하는경우 삭제한다.
      deleteFile(realpath);

      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

  }

  private void generateSqlmap(String realpath) throws Exception {
    // 파일이 이미 존재하는경우 삭제한다.
    deleteFile(realpath);

    File pathdir = new File(realpath.substring(0, realpath.lastIndexOf("/")));
    if (!pathdir.exists())
      pathdir.mkdirs();

    String inscols_iter = "";
    String insvals_iter = "";
    String pk_cond = "";
    String select_iter = "";
    String update_iter = "";
    String resultmap_iter = "";

    for (int i = 0; i < tablecrudList.size(); i++) {
      TablecrudVO tVO = (TablecrudVO) tablecrudList.get(i);
      String colnm = tVO.getColumn_name();

      if ("DATE|DATETIME|TIMESTAMP".indexOf(tVO.getData_type().toUpperCase()) >= 0) {
        select_iter += "TO_CHAR(" + colnm + ", 'YYYY-MM-DD HH24:MI:SS') " + colnm;
        inscols_iter += colnm;
        insvals_iter += "SYSDATE";
        update_iter += colnm + " = SYSDATE";
        resultmap_iter += "<result property=\"" + colnm.toLowerCase() + "\" column=\""
            + colnm.toLowerCase() + "\"/>";
      } else if ("NUMBER".equals(tVO.getData_type().toUpperCase())) {
        select_iter += colnm;
        inscols_iter += colnm;
        insvals_iter += "#" + colnm.toLowerCase() + "#";
        update_iter += colnm + " = #" + colnm.toLowerCase() + "#";
        resultmap_iter += "<result property=\"" + colnm.toLowerCase() + "\" column=\""
            + colnm.toLowerCase() + "\"/>";
      } else {
        select_iter += colnm;
        inscols_iter += colnm;

        if ("CLOB".equals(tVO.getData_type().toUpperCase())) {
          useClob = true;
          resultmap_iter += "<result property=\"" + colnm.toLowerCase() + "\" column=\""
              + colnm.toLowerCase() + "\"  jdbcType=\"CLOB\" javaType=\"java.lang.String\" />";
          insvals_iter += "#" + colnm.toLowerCase() + ":CLOB#";
          update_iter += colnm + " = #" + colnm.toLowerCase() + ":CLOB#";
        } else {
          resultmap_iter += "<result property=\"" + colnm.toLowerCase() + "\" column=\""
              + colnm.toLowerCase() + "\"/>";
          insvals_iter += "#" + colnm.toLowerCase() + "#";
          update_iter += colnm + " = #" + colnm.toLowerCase() + "#";
        }
      }

      inscols_iter += (i == (tablecrudList.size() - 1) ? "" : ",\n\t\t\t");
      insvals_iter += (i == (tablecrudList.size() - 1) ? "" : ",\n\t\t\t");
      select_iter += (i == (tablecrudList.size() - 1) ? "" : ",\n\t\t\t\t");
      update_iter += (i == (tablecrudList.size() - 1) ? "" : ",\n\t\t\t");
      resultmap_iter += (i == (tablecrudList.size() - 1) ? "" : "\n\t\t\t\t");

      if ("PK".equals(tVO.getConstraint_type())) {
        pk_cond += (pk_cond.equals("")) ? "" : " AND\n";
        pk_cond += "\t\t\t" + colnm + " = #" + colnm.toLowerCase() + "#";
      }
    }

    StringBuffer sb_ = new StringBuffer();

    // 템플릿 파일을 읽어온다.
    String tmplfilepath = genVO.getSrc();
    tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/java_tmpl/sqlmap.tmpl");
    FileReader tmplfile = new FileReader(new File(tmplfilepath));
    int ch;
    while ((ch = tmplfile.read()) >= 0) {
      sb_.append((char) ch);
    }
    tmplfile.close();

    replaceArgs(sb_);

    EgovWebUtil.replaceallSB(sb_, "{##SQL_RESULTMAP_ITER##}", resultmap_iter);
    EgovWebUtil.replaceallSB(sb_, "{##SQL_INSCOLS_ITER##}", inscols_iter);
    EgovWebUtil.replaceallSB(sb_, "{##SQL_INSVALS_ITER##}", insvals_iter);
    EgovWebUtil.replaceallSB(sb_, "{##SQL_KEYS##}", "WHERE\n" + pk_cond);
    EgovWebUtil.replaceallSB(sb_, "{##SQL_MERGE_KEYS##}", pk_cond);
    EgovWebUtil.replaceallSB(sb_, "{##SQL_UPDTCOLS##}", update_iter);
    EgovWebUtil.replaceallSB(sb_, "{##SQL_SELCOLS##}", select_iter);
    EgovWebUtil.replaceallSB(sb_, "{##SQL_TBL_NM##}", baseacttable);

    try {

      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();


      // sqlmap config 에 새로 추가된 sqlmap 파일 경로 추가
      String configpath = realpath.substring(0, realpath.lastIndexOf("/"));
      configpath = configpath.replace("com", "config");

      configpath += "/sql-map-config-" + Globals.DB_TYPE + "-cmm.xml";
      BufferedReader bin_ = new BufferedReader(new FileReader(new File(configpath)));
      StringBuffer csb_ = new StringBuffer("");

      if (bin_.ready()) {
        String line = "";
        while ((line = bin_.readLine()) != null) {
          if ("</sqlMapConfig>".equals(line) == true) {
            if (csb_.indexOf(genVO.getBiznm() + "_map.xml") < 0)
              csb_.append("\t<sqlMap resource=\"egovframework/sqlmap/com/" + Globals.DB_TYPE + "/"
                  + genVO.getBiznm() + "_map.xml\"/>\n");
          }

          csb_.append(line + "\n");
        }
      }
      bin_.close();

      BufferedWriter bout_ =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(configpath), "UTF-8"));
      bout_.write(csb_.toString());
      bout_.close();


    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

  }



  /**
   * 사용자 CRUD 페이지 추가
   * 
   * @throws Exception
   */
  public void genereateUserpageAll() throws Exception {
    generateTiles("U");
    generateScript("U");
    generateList("U");
    generateView("U");
    generateMod("U");
  }

  /**
   * 관리자CURD 페이지 추가
   * 
   * @throws Exception
   */
  public void genereateManpageAll() throws Exception {
    String ctrl_manpath = getPkg2RealPathJava(genVO.getSrc(), genVO.getCtrl_man());
    generateCtlr(ctrl_manpath, "M");
    generateTiles("M");
    generateScript("M");
    generateList("M");
    // generateView("M");
    generateMod("M");
  }

  private void generateTiles(String mu_gub) throws Exception {
    String realpath = genVO.getSrc();

    StringBuffer sb_ = new StringBuffer();

    // 템플릿 파일을 읽어온다.
    String tmplfilepath = genVO.getSrc();

    if (mu_gub.equals("M"))
      tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/jsp_tmpl/set/tiles_man.tmpl");
    else
      tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/jsp_tmpl/set/tiles_user.tmpl");

    FileReader tmplfile = new FileReader(new File(tmplfilepath));
    int ch;
    while ((ch = tmplfile.read()) >= 0) {
      sb_.append((char) ch);
    }
    tmplfile.close();

    replaceArgs(sb_);

    if (mu_gub.equals("M")) {
      EgovWebUtil.replaceallSB(sb_, "{##TILES_LAYOUT##}", "modeecDefinitionContent");
      EgovWebUtil.replaceallSB(sb_, "{##TILES_LAYOUT_PREFIX##}", "metsys");
      EgovWebUtil.replaceallSB(sb_, "{##SCRIPT_DIR##}",
          "/WEB-INF/jsp/layout/template/metsys/script/proj_add");
      EgovWebUtil.replaceallSB(sb_, "{##PAGE_DIR##}",
          "/WEB-INF/jsp/wpages/template/metsys/proj_add");
      EgovWebUtil.replaceallSB(sb_, "{##ADDR_PREFIX##}", "/manact");

      realpath += "/webapp/WEB-INF/tiles/template/proj_add/tiles_" + genVO.getBiznm() + ".xml";
    } else {
      EgovWebUtil.replaceallSB(sb_, "{##TILES_LAYOUT_CONT##}", "ContDefinitionContent");
      EgovWebUtil.replaceallSB(sb_, "{##TILES_LAYOUT_EDIT##}", "ContDefinitionEditor");
      EgovWebUtil.replaceallSB(sb_, "{##TILES_LAYOUT_PREFIX##}", "cont");
      EgovWebUtil.replaceallSB(sb_, "{##SCRIPT_DIR##}",
          "/WEB-INF/jsp/layout/custom/web/kor/contents/script/proj_add");
      EgovWebUtil.replaceallSB(sb_, "{##PAGE_DIR##}",
          "/WEB-INF/jsp/wpages/custom/web/kor/proj_add");
      EgovWebUtil.replaceallSB(sb_, "{##ADDR_PREFIX##}", "/usract");

      realpath +=
          "/webapp/WEB-INF/tiles/custom/web/kor/proj_add/tiles_" + genVO.getBiznm() + ".xml";
    }


    try {


      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

  private void generateList(String mu_gub) throws Exception {
    String realpath = genVO.getSrc();

    StringBuffer sb_ = new StringBuffer();

    // 템플릿 파일을 읽어온다.
    String tmplfilepath = genVO.getSrc();
    tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/jsp_tmpl/page/list.tmpl");

    FileReader tmplfile = new FileReader(new File(tmplfilepath));
    int ch;
    while ((ch = tmplfile.read()) >= 0) {
      sb_.append((char) ch);
    }
    tmplfile.close();

    replaceArgs(sb_);


    String colgroup_iter = "";
    String thead_iter = "";
    String tr_iter = "";
    String hidden_pk_iter = "";
    String pkparams = "";

    for (int i = 0; i < tablecrudList.size(); i++) {
      TablecrudVO crudVO = (TablecrudVO) tablecrudList.get(i);
      colgroup_iter +=
          "<col width=\"10%\"/>" + ((i == (tablecrudList.size() - 1)) ? "" : "\n\t\t\t\t\t");
      thead_iter += "<th scope=\"col\">" + crudVO.getComments() + "</th>"
          + ((i == (tablecrudList.size() - 1)) ? "" : "\n\t\t\t\t\t\t");

      if (i == 0) {
        if (mu_gub.equals("M"))
          tr_iter += "<td><a href=\"javascript:fn_egov_" + genVO.getBiznm()
              + "_mod({##SCRIPT_PK_PARAMS##})\"><c:out value=\"${result."
              + crudVO.getColumn_name().toLowerCase() + "}\" /></a></td>"
              + ((i == (tablecrudList.size() - 1)) ? "" : "\n\t\t\t\t\t\t");
        else
          tr_iter += "<td><a href=\"javascript:fn_egov_" + genVO.getBiznm()
              + "_view({##SCRIPT_PK_PARAMS##})\"><c:out value=\"${result."
              + crudVO.getColumn_name().toLowerCase() + "}\" /></a></td>"
              + ((i == (tablecrudList.size() - 1)) ? "" : "\n\t\t\t\t\t\t");

      } else
        tr_iter += "<td><c:out value=\"${result." + crudVO.getColumn_name().toLowerCase()
            + "}\" /></td>" + ((i == (tablecrudList.size() - 1)) ? "" : "\n\t\t\t\t\t\t");

      if ("PK".equals(crudVO.getConstraint_type())) {
        hidden_pk_iter += "<input type=\"hidden\" id=\"" + crudVO.getColumn_name().toLowerCase()
            + "\" name=\"" + crudVO.getColumn_name().toLowerCase() + "\" value=\""
            + ("NUMBER".equals(crudVO.getData_type()) ? "0" : "") + "\"/>\n\t";
        pkparams += ("".equals(pkparams) ? "" : ", ") + "'${result."
            + crudVO.getColumn_name().toLowerCase() + "}'";
      }

    }

    EgovWebUtil.replaceallSB(sb_, "{##COLGROUP_ITER##}", colgroup_iter);
    EgovWebUtil.replaceallSB(sb_, "{##THEAD_ITER##}", thead_iter);
    EgovWebUtil.replaceallSB(sb_, "{##TR_ITER##}", tr_iter);
    EgovWebUtil.replaceallSB(sb_, "{##HIDDEN_PK_ITER##}", hidden_pk_iter);
    EgovWebUtil.replaceallSB(sb_, "{##COLSPAN##}",
        new Integer(tablecrudList.size() + 1).toString());
    EgovWebUtil.replaceallSB(sb_, "{##SCRIPT_PK_PARAMS##}", pkparams);

    try {

      if (mu_gub.equals("M")) {
        realpath += "/webapp/WEB-INF/jsp/wpages/template/metsys/proj_add/" + genVO.getLastdir()
            + "/" + genVO.getBiznm() + "List.jsp";
      } else {
        realpath += "/webapp/WEB-INF/jsp/wpages/custom/web/kor/proj_add/" + genVO.getLastdir() + "/"
            + genVO.getBiznm() + "List.jsp";
      }

      File pathdir = new File(realpath.substring(0, realpath.lastIndexOf("/")));
      if (!pathdir.exists())
        pathdir.mkdirs();

      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

  private void generateView(String mu_gub) throws Exception {
    String realpath = genVO.getSrc();

    StringBuffer sb_ = new StringBuffer();

    // 템플릿 파일을 읽어온다.
    String tmplfilepath = genVO.getSrc();
    tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/jsp_tmpl/page/view.tmpl");

    FileReader tmplfile = new FileReader(new File(tmplfilepath));
    int ch;
    while ((ch = tmplfile.read()) >= 0) {
      sb_.append((char) ch);
    }
    tmplfile.close();

    replaceArgs(sb_);

    String value_tr_iter = "";
    for (int i = 0; i < tablecrudList.size(); i++) {
      TablecrudVO crudVO = (TablecrudVO) tablecrudList.get(i);

      value_tr_iter += "\t\t\t\t<tr>\n";
      value_tr_iter +=
          "\t\t\t\t\t<th scope=\"row\"><label for=\"" + crudVO.getColumn_name().toLowerCase()
              + "\">" + crudVO.getComments() + "</label></th>\n";
      value_tr_iter += "\t\t\t\t\t<td class = \"left\">\n";
      value_tr_iter += "\t\t\t\t\t\t<c:out value=\"${" + genVO.getBiznm() + "VO."
          + crudVO.getColumn_name().toLowerCase() + "}\"/>\n";
      value_tr_iter += "\t\t\t\t\t</td>\n";
      value_tr_iter += "\t\t\t\t</tr>";
      value_tr_iter += ((i == (tablecrudList.size() - 1)) ? "" : "\n");
    }

    EgovWebUtil.replaceallSB(sb_, "{##VALUE_TR_ITER##}", value_tr_iter);

    try {

      if (mu_gub.equals("M")) {
        realpath += "/webapp/WEB-INF/jsp/wpages/template/metsys/proj_add/" + genVO.getLastdir()
            + "/" + genVO.getBiznm() + "View.jsp";
      } else {
        realpath += "/webapp/WEB-INF/jsp/wpages/custom/web/kor/proj_add/" + genVO.getLastdir() + "/"
            + genVO.getBiznm() + "View.jsp";
      }

      File pathdir = new File(realpath.substring(0, realpath.lastIndexOf("/")));
      if (!pathdir.exists())
        pathdir.mkdirs();


      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

  private void generateMod(String mu_gub) throws Exception {
    String realpath = genVO.getSrc();

    StringBuffer sb_ = new StringBuffer();

    // 템플릿 파일을 읽어온다.
    String tmplfilepath = genVO.getSrc();
    tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/jsp_tmpl/page/add.tmpl");

    FileReader tmplfile = new FileReader(new File(tmplfilepath));
    int ch;
    while ((ch = tmplfile.read()) >= 0) {
      sb_.append((char) ch);
    }
    tmplfile.close();

    replaceArgs(sb_);

    String input_tr_iter = "";
    String dtype = "";
    int colsize = 0;

    for (int i = 0; i < tablecrudList.size(); i++) {
      TablecrudVO crudVO = (TablecrudVO) tablecrudList.get(i);
      dtype = crudVO.getData_type();
      if ("NUMBER".equals(dtype))
        colsize = 20;
      else if ("DATE".equals(dtype))
        colsize = 30;
      else if ("CLOB".equals(dtype))
        colsize = 100;
      else {
        colsize = crudVO.getData_length();
        colsize += 5;
        colsize = colsize > 100 ? 100 : colsize;
      }

      input_tr_iter += "\t\t\t\t<tr>\n";

      if ("N".equals(crudVO.getNullable()))
        input_tr_iter +=
            "\t\t\t\t\t<th scope=\"row\"><span class=\"point01\">*</span> <label for=\""
                + crudVO.getColumn_name().toLowerCase() + "\">" + crudVO.getComments()
                + "</label></th>\n";
      else
        input_tr_iter +=
            "\t\t\t\t\t<th scope=\"row\"><label for=\"" + crudVO.getColumn_name().toLowerCase()
                + "\">" + crudVO.getComments() + "</label></th>\n";

      input_tr_iter += "\t\t\t\t\t<td class = \"left\">\n";
      input_tr_iter += "\t\t\t\t\t\t<form:input path=\"" + crudVO.getColumn_name().toLowerCase()
          + "\" size=\"" + colsize + "\" class=\"text\" title=\"" + crudVO.getComments() + "\"/>\n";
      input_tr_iter += "\t\t\t\t\t</td>\n";
      input_tr_iter += "\t\t\t\t</tr>";
      input_tr_iter += ((i == (tablecrudList.size() - 1)) ? "" : "\n");
    }

    EgovWebUtil.replaceallSB(sb_, "{##INPUT_TR_ITER##}", input_tr_iter);

    try {

      if (mu_gub.equals("M")) {
        realpath += "/webapp/WEB-INF/jsp/wpages/template/metsys/proj_add/" + genVO.getLastdir()
            + "/" + genVO.getBiznm() + "Write.jsp";
      } else {
        realpath += "/webapp/WEB-INF/jsp/wpages/custom/web/kor/proj_add/" + genVO.getLastdir() + "/"
            + genVO.getBiznm() + "Write.jsp";
      }

      File pathdir = new File(realpath.substring(0, realpath.lastIndexOf("/")));
      if (!pathdir.exists())
        pathdir.mkdirs();

      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

  private void generateScript(String mu_gub) throws Exception {

    String realpath = genVO.getSrc();

    StringBuffer sb_ = new StringBuffer();

    // 템플릿 파일을 읽어온다.
    String tmplfilepath = genVO.getSrc();
    if (mu_gub.equals("M"))
      tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/jsp_tmpl/set/script_man.tmpl");
    else
      tmplfilepath = tmplfilepath.replace("/src/main", "/tmpl_src/jsp_tmpl/set/script_user.tmpl");

    FileReader tmplfile = new FileReader(new File(tmplfilepath));
    int ch;
    while ((ch = tmplfile.read()) >= 0) {
      sb_.append((char) ch);
    }
    tmplfile.close();

    replaceArgs(sb_);

    if (mu_gub.equals("M")) {
      EgovWebUtil.replaceallSB(sb_, "{##MANACT_PREFIX##}", "/manact");
      realpath += "/webapp/WEB-INF/jsp/layout/template/metsys/script/proj_add/script_"
          + genVO.getBiznm() + ".jsp";
    } else {
      // EgovWebUtil.replaceallSB(sb_, "{##ADDR_PREFIX##}", "");
      EgovWebUtil.replaceallSB(sb_, "{##USRACT_PREFIX##}", "/usract");
      realpath += "/webapp/WEB-INF/jsp/layout/custom/web/kor/contents/script/proj_add/script_"
          + genVO.getBiznm() + ".jsp";
    }

    String pk_params = "";
    String pk_params_set = "";
    String dpicker_params_set = "";

    for (int i = 0; i < tablecrudList.size(); i++) {
      TablecrudVO crudVO = (TablecrudVO) tablecrudList.get(i);

      String col_nm = "";
      if ("PK".equals(crudVO.getConstraint_type())) {
        col_nm = crudVO.getColumn_name().toLowerCase();
        pk_params += (pk_params.equals("") ? "" : ", ") + col_nm;
        pk_params_set += "\tform." + col_nm + ".value = " + col_nm + ";\n";
      }

      if ("DATE".equals(crudVO.getData_type()) || "DATETIME".equals(crudVO.getData_type())) {
        dpicker_params_set +=
            ((dpicker_params_set.equals("") ? "#" : ", #") + crudVO.getColumn_name().toLowerCase());
      }
    }

    EgovWebUtil.replaceallSB(sb_, "{##PK_PARAMS##}", pk_params);
    EgovWebUtil.replaceallSB(sb_, "{##PK_PARAMS_SET##}", pk_params_set);

    dpicker_params_set = (dpicker_params_set.equals("") ? ""
        : "cmmfn_set_datepicker(g_context, jQuery(\"" + dpicker_params_set + "\"), \"%Y-%m-%d\");");

    EgovWebUtil.replaceallSB(sb_, "{##DTAEPICKER_SET##}", dpicker_params_set);


    try {


      File file = new File(realpath);
      if (file.exists())
        file.delete();

      BufferedWriter out =
          new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath), "UTF-8"));

      out.write(sb_.toString());
      out.newLine();
      out.close();

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }



  private String getPkg2RealPathJava(String srcpath, String pkg) {
    String ret_ = srcpath + "/java/";
    ret_ += (pkg.replaceAll("\\.", "/"));
    ret_ += ".java";
    return ret_;
  }


  private String getPkg2RealPathSqlmap(String srcpath, String pkg) {
    String ret_ = srcpath + "/resources/";
    ret_ += (pkg.replaceAll("\\.", "/"));
    ret_ += ".xml";
    return ret_;
  }


  private String getUpper1stChar(String inp) {
    String str = inp.toLowerCase();
    String ret = ("" + str.charAt(0)).toUpperCase();
    ret += str.substring(1, str.length());
    return ret;
  }

  private void deleteFile(String path) {
    File file = new File(path);
    if (file.exists())
      file.delete();

  }

  private void replaceArgs(StringBuffer sb_) {
    EgovWebUtil.replaceallSB(sb_, "{##BIZNM##}", genVO.getBiznm());
    EgovWebUtil.replaceallSB(sb_, "{##BIZNM_UP1##}", getUpper1stChar(genVO.getBiznm()));
    EgovWebUtil.replaceallSB(sb_, "{##BIZKR##}", genVO.getBizkr());
    EgovWebUtil.replaceallSB(sb_, "{##BIZLOG_NM##}", genVO.getBiznm().toUpperCase());
    EgovWebUtil.replaceallSB(sb_, "{##IMPT_BIZDAO##}", genVO.getDao());
    EgovWebUtil.replaceallSB(sb_, "{##IMPT_BIZSVC##}", genVO.getSvc());
    EgovWebUtil.replaceallSB(sb_, "{##IMPT_BIZVO##}", genVO.getVo());
    EgovWebUtil.replaceallSB(sb_, "{##LASTDIR##}", genVO.getLastdir());
  }

  public static void main(String[] args) {
    // StringBuffer sb = new StringBuffer("aghoiehowg @@void@@VO aghohoie@@void@@CO
    // aghoehoigwe@@void@@DO");
    /// CodeGenerater.replaceallSB(sb, "@@void@@", "니기럴");
    // System.out.println(sb.toString());
  }


}
