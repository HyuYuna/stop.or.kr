package egovframework.plani.template.cmm.utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import org.apache.commons.io.FileUtils;

/**
 * 지정된 일자 내에 수정된 파일들만 골라서 서버에 업로드하기 편하게 목록으로 생성한다. 서버에 전체 배포가 아니라 수정된 파일만 골라서 배포해야 할 경우 사용. java
 * 클래스가 수정된 경우 배포할 디렉토리의 classes 디렉토리에 컴파일된 클래스 목록도 생성한다. properties 와 xml등의 리소스 파일도 classes 디렉토리
 * 밑으로 복사한다.
 * 
 * @author 1 : 2017.07.18 bhhan
 * @author 2 : .....
 */
public class DeployUtil {

  /////////////////////////////////////////////////////////////////////////////////////
  // 시스템에 맞게 설정

  /** 중요 !! 작업 프로젝트 위치 */
  private final String _baseDIR = "D:/JavaDev/workspace/job_egov5/CCIS4";

  /** 프로젝트명 : 배포파일에 프로젝트명으로 묶어서 히스토리를 보관하기 위한 용도 */
  private final String _prjName = "CCIS4";

  /** 중요 !! 클래스파일 build 위치 */
  private final String _baseBuildDIR = "/WebContent/WEB-INF/classes";

  /** 배포파일 생성 위치 : 존재하지 않으면 생성됨 */
  private String _targetDIR = "D:/PRJ_DEPLOY";
  //////////////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////////////
  // 자동으로 설정

  /** WEB-INF 경로 위치 */
  private String _webinfDIR = "";
  ArrayList<String> _fileList = null;
  //////////////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////////////
  // arguments
  /** 오늘로부터 며칠 이내에 수정된 파일까지 대상으로 할것인가 ? Default : 0 (오늘) */
  private int _daysDiff = 0;

  /** _daysDiff == 0 일 경우에만 의미있음 / 몇시간 이내에 수정된 파일까지 대상으로 할것인가 ? Default : 0 (오늘 전체) */
  private int _hoursDiff = 1;
  //////////////////////////////////////////////////////////////////////////////////////

  /**
   * DeployUtil 초기화루틴 1. 타겟디렉토리에 오늘날짜를 자동으로 붙여주고, 디렉토리가 존재할 경우 삭제한다. 2. 수정파일 목록을 저장할 리스트를 생성 bhhan
   */
  public DeployUtil() {
    _fileList = new ArrayList<String>();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

    _targetDIR = _targetDIR + "/" + _prjName + "/" + sdf.format(new Date());

    File file = new File(_targetDIR);
    if (file.isDirectory() && file.exists())
      try {
        FileUtils.deleteDirectory(file);
      } catch (IOException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }

    file.mkdirs();
  }

  // 목록 구성 & 복사
  public void makeStart() {
    try {

      SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
      BufferedWriter logfw = new BufferedWriter(new FileWriter(_targetDIR + "/deplog.log", true));
      logfw.write("## 배포파일 생성시간 : " + sdf.format(new Date()) + "\n");

      rcvStartTraverse(_baseDIR, logfw);

      logfw.close();
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    startCopy();
  }


  /**
   * 프로젝트 목록중에서 지정(n)일 이내에 변경된 파일의 목록을 구성한다. 특정 확장자만으로 필터를 구성하였으며 필터내용은 아래 내부클래스 참조.. 초기값 : 0 (오늘) /
   * arguments 로 설정
   * 
   * @param path
   * @throws IOException
   */
  private void rcvStartTraverse(String path, BufferedWriter logfw) throws IOException {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    File dir = new File(path);
    if (dir.exists() && dir.isDirectory()) {
      File[] fileList = dir.listFiles(new FileExtFilter());

      for (int i = 0; i < fileList.length; i++) {
        File tmpfile = fileList[i];
        String tPath = tmpfile.getPath().replaceAll("\\\\", "/");

        // 디렉토리인 경우 계속 탐색
        if (tmpfile.isDirectory()) {
          if ((path.endsWith("/webapp/WEB-INF") || path.endsWith("/WebContent/WEB-INF"))
              && _webinfDIR.equals("")) {
            _webinfDIR = path;
            _webinfDIR = _webinfDIR.replace(_baseDIR, "");
          }

          // 메이븐, Class build 디렉토리는 제외시킨다.
          if (tPath.equals(_baseDIR + "/target") == false
              && tPath.equals(_baseDIR + _baseBuildDIR) == false)
            rcvStartTraverse(tPath, logfw);
        }

        // 파일인 경우
        else {
          Calendar cal = Calendar.getInstance();

          // 지정시간 계산 (기본값 : 0 <오늘 전체> / 값이 커질수록 지정시간은 1시간단위로 과거로 이동; _daysDiff == 0 일경우만..)

          if (_daysDiff == 0 && _hoursDiff > 0) {
            int sc = cal.get(Calendar.SECOND);
            cal.set(Calendar.SECOND, sc);
            int mn = cal.get(Calendar.MINUTE);
            cal.set(Calendar.MINUTE, mn);
            int hr = cal.get(Calendar.HOUR) - ((_daysDiff == 0) ? (_hoursDiff * 1) : 0);
            cal.set(Calendar.HOUR, hr);
          } else {
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.HOUR, 0);
          }

          // 지정일 계산 (기본값 : 0 <오늘> / 값이 커질수록 지정일은 1일단위로 과거로 이동)
          cal.add(Calendar.DATE, (_daysDiff * -1));
          Date compdt = cal.getTime();

          // 파일의 최종 수정일
          Date lastmdfdt = new Date(tmpfile.lastModified());

          // 지정일과 파일의 최종 수정일을 비교하여 범위에 들어있는 파일목록을 구함
          if (compdt.compareTo(lastmdfdt) <= 0) {
            _fileList.add(tPath);
            System.out.println("Last Modified " + sdf.format(lastmdfdt) + "\t>>\t" + tPath);
            logfw.write("Last Modified " + sdf.format(lastmdfdt) + "\t>>\t" + tPath + "\n");
            logfw.flush();
          }
        }

      }


    }

  }



  /**
   * 지정(n)일 이내에 변경된 파일의 목록에 맞춰 배포대상 파일을 대상디렉토리에 복사한다. 배포대상디렉토리에 오늘날짜가 붙어서 생성되며, 오늘날짜로 배포목록이 이미 존재하는
   * 경우 삭제후 재생성한다. 자바파일의 경우 클래스 파일을 함께 배포한다. 전자정부프레임워크의 경우 resources 내의 내용을 함께 배포한다.
   */
  private void startCopy() {

    for (int i = 0; i < _fileList.size(); i++) {
      String srcPathName = (String) _fileList.get(i);
      String tPath = srcPathName.replaceAll("\\\\", "/");

      String destPathName = tPath.replace(_baseDIR, _targetDIR);
      destPathName = destPathName.substring(0, destPathName.lastIndexOf("/"));
      String destFileName = tPath.substring(tPath.lastIndexOf("/"), tPath.length());

      File destPath = new File(destPathName);
      if (destPath.exists() == false)
        destPath.mkdirs();

      File srcFile = new File(srcPathName);
      File destFile = new File(destPathName + "/" + destFileName);

      try {
        FileUtils.copyFile(srcFile, destFile);
      } catch (FileNotFoundException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      } catch (IOException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }

      // java 파일은 컴파일된 클래스도 복사한다.
      // 이때 build 결과에 포함되는 리소스파일 (xml, properties)도 같이 복사한다.
      if (getExtension(tPath).toLowerCase().equals("java")
          || ((getExtension(tPath).toLowerCase().equals("properties")
              || getExtension(tPath).toLowerCase().equals("xml"))
              && (tPath.indexOf("resources/egovframework") >= 0)
              || tPath.indexOf("/sqlmap") >= 0)) {
        srcPathName = tPath;
        srcPathName = srcPathName.replace(_baseDIR, "");
        srcPathName = srcPathName.replace("/src/main/java", "");
        srcPathName = srcPathName.replace("/src/main/resources", "");
        srcPathName = srcPathName.replace("/src", "/");
        srcPathName = srcPathName.replace(".java", ".class");

        destPathName = _targetDIR + _webinfDIR + "/classes" + srcPathName;
        srcPathName = _baseDIR + _baseBuildDIR + srcPathName;

        destPathName = destPathName.substring(0, destPathName.lastIndexOf("/"));
        destFileName = srcPathName.substring(srcPathName.lastIndexOf("/"), srcPathName.length());

        // 디렉토리 생성
        destPath = new File(destPathName);
        if (destPath.exists() == false)
          destPath.mkdirs();

        srcFile = new File(srcPathName);
        destFile = new File(destPathName + "/" + destFileName);
        try {
          if (srcFile.exists())
            FileUtils.copyFile(srcFile, destFile);
        } catch (FileNotFoundException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        } catch (IOException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }
      }

    }

  }


  /**
   * 경로를 포함한 파일명에서 파일 확장자를 구한다.
   * 
   * @param strPath
   * @return
   */
  public static String getExtension(String strPath) {
    String ext = null;
    if (strPath != null && strPath.lastIndexOf(".") >= 0)
      ext = strPath.substring(strPath.lastIndexOf(".") + 1, strPath.length());
    else
      ext = "";

    return ext;
  }


  public static void main(String[] args) {
    // TODO Auto-generated method stub

    DeployUtil deployUtil = new DeployUtil();
    deployUtil.makeStart();
  }



  /**
   * 파일 조회에 적용할 필터 클래스
   * 
   * @author ermekia
   */
  public class FileExtFilter implements FilenameFilter {

    String acceptlist = "";

    public FileExtFilter() {
      acceptlist =
          "java|class|jsp|html|js|css|properties|xml|tld|jpg|gif|png|bmp|pdf|hwp|doc|docx|xls|xlsx|ppt|pptx|jar";
      // acceptlist = "jsp";
    }

    @Override
    public boolean accept(File dir, String name) {
      // TODO Auto-generated method stub


      if (name != null) {
        return acceptlist.indexOf(getExtension(name).toLowerCase()) >= 0 ? true : false;
      }

      return false;
    }

  }


}
