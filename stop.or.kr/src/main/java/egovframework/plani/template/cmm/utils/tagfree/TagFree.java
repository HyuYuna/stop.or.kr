package egovframework.plani.template.cmm.utils.tagfree;

import egovframework.plani.template.cmm.utils.EgovProperties;

public class TagFree {

  /**
   * 파일을 업로드하고 디코딩된 html을 반환한다
   * 
   * @param mimeContents
   * @return
   */
  public String submit(String mimeContents, String directory) {
    boolean bReaname = true; // 저장할 디렉터리에 파일이 존재할 경우 새로운 이름을 지정한다.

    // 실제 파일이 저장되는 위치
    String strSavePath = EgovProperties.getProperty("Globals.fileUploadPathForTagfree");
    // 실제 웹 서버에 저장되는 디렉터리의 웹 URL 경로를 지정한다.
    String strSaveUrl = EgovProperties.getProperty("Globals.urlForTagfree");

    if (directory != null) {
      strSavePath += "/" + directory;
      strSaveUrl += "/" + directory;
    }

    String strMimeValue = mimeContents; // Active Designer에서 작성된 본문의 MIME 값을 가져온다.
    strMimeValue = strMimeValue.replaceAll("&amp;", "&");
    strMimeValue = strMimeValue.replaceAll("&lt;", "<");
    strMimeValue = strMimeValue.replaceAll("&gt;", ">");
    strMimeValue = strMimeValue.replaceAll("&quot;", "\"");
    strMimeValue = strMimeValue.replaceAll("&apos;", "\'");

    MimeUtil util = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
    util.setMimeValue(strMimeValue); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
    util.setSavePath(strSavePath); // 저장 디렉터리 지정
    util.setSaveUrl(strSaveUrl); // URL 경로 지정

    util.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정

    util.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다.

    return util.getDecodedHtml(false);
  }
}
