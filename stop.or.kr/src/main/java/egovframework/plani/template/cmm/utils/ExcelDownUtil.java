package egovframework.plani.template.cmm.utils;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import egovframework.plani.template.survey.vo.SrvymainVO;

/**
 * @class : [PLANI_TMPL] [cegovframework.plani.cmm.utils] [ExcelDownUtil.java]
 * @DoWhat : 엑셀파일을 생성하여 쿼리 결과를 저장한다.
 * @author : ByunghanHan
 * @date : 2011. 11. 23. 오후 3:10:49
 */
public class ExcelDownUtil {


  /**
   * @method : ExcelWrite
   * @DoWhat : Query 질의 결과를 엑셀파일로 저장함. 2011.08.03 ByunghanHan
   * @param response : 응답 개체
   * @param dataList : 질의 결과
   * @param colnames : 저장할 컬럼 목록
   * @param colinfos : 저장할 컬럼 정의
   * @param filename : 저장할 파일명
   * @return : boolean
   */
  @SuppressWarnings("unchecked")
  public boolean ExcelWrite(HttpServletResponse response, List dataList, List colinfoList,
      String filename) throws Exception {

    // String colnames, String colinfos,

    // String[] col_names = colnames.toLowerCase().split(";");
    // String[] col_info = colinfos.split(";");

    String tm = getStringFromDate(new Date(), "yyyy년 MM월 dd일 - HH시 mm분");

    HSSFWorkbook wb = new HSSFWorkbook();
    // 「sheet1」라는 이름의 워크시트를 표시하는 오브젝트 생성
    HSSFSheet sheet1 = wb.createSheet("sheet1");

    // 행의 작성
    /************************ 엑셀 스타일 지정 ****************************/
    HSSFCellStyle style_title = wb.createCellStyle();
    HSSFCellStyle style_data = wb.createCellStyle();
    HSSFCellStyle style_header = wb.createCellStyle();

    HSSFFont font = wb.createFont();
    HSSFFont font_title = wb.createFont();

    font_title.setFontHeightInPoints((short) 12);
    font_title.setBoldweight((short) 700);

    font.setBoldweight((short) 700);

    style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
    style_title.setFont(font_title);
    style_title.setFillForegroundColor(HSSFColor.LIGHT_ORANGE.index);
    style_title.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
    style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);


    style_data.setBorderRight(HSSFCellStyle.BORDER_THIN);
    style_data.setBorderLeft(HSSFCellStyle.BORDER_THIN);
    style_data.setBorderTop(HSSFCellStyle.BORDER_THIN);
    style_data.setBorderBottom(HSSFCellStyle.BORDER_THIN);
    style_data.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style_header.setBorderRight(HSSFCellStyle.BORDER_THIN);
    style_header.setBorderLeft(HSSFCellStyle.BORDER_THIN);
    style_header.setBorderTop(HSSFCellStyle.BORDER_THIN);
    style_header.setBorderBottom(HSSFCellStyle.BORDER_THIN);
    style_header.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
    style_header.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
    style_header.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style_header.setFillBackgroundColor(HSSFColor.AQUA.index);
    style_header.setAlignment(HSSFCellStyle.ALIGN_CENTER);
    style_header.setFont(font);
    /************************ 엑셀 스타일 지정 ****************************/



    /************************ 엑셀 정보 출력 ****************************/
    HSSFRow row_title = sheet1.createRow(2);
    row_title.setHeight((short) 600);
    HSSFCell cell_title = row_title.createCell(0);
    cell_title.setCellValue(filename);
    cell_title.setCellStyle(style_title);
    sheet1.addMergedRegion(new CellRangeAddress(2, 2, 0, (colinfoList.size() - 1)));


    HSSFRow row_date = sheet1.createRow(3);
    HSSFCell cell_date = row_date.createCell(0);

    cell_date = row_date.createCell(0);
    cell_date.setCellValue("출력일자");
    cell_date = row_date.createCell(1);
    cell_date.setCellValue(tm);
    /************************ 엑셀 정보 출력 ****************************/


    HSSFRow row0 = sheet1.createRow(5);
    HSSFCell cell = null;

    for (int k = 0; k < colinfoList.size(); k++) {
      HashMap colmap = (HashMap) colinfoList.get(k);
      row0.setHeight((short) 500);
      cell = row0.createCell(k);
      sheet1.setColumnWidth(k, (short) 4000);
      cell.setCellValue((String) colmap.get("COL_INFO"));
      cell.setCellStyle(style_header);
    }

    for (int i = 0; i < dataList.size(); i++) {
      row0 = sheet1.createRow(i + 6);
      row0.setHeight((short) 400);
      Map article = (HashMap) dataList.get(i);

      for (int j = 0; j < colinfoList.size(); j++) {
        HashMap colmap = (HashMap) colinfoList.get(j);
        cell = row0.createCell(j);
        Object obj = article.get(((String) colmap.get("COL_NAME")).toUpperCase());
        if (obj == null)
          cell.setCellValue("");
        else
          cell.setCellValue(obj.toString());

        cell.setCellStyle(style_data);
      }

    }

    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-disposition",
        "attachment;filename=" + java.net.URLEncoder.encode(filename + "_" + tm + ".xls", "UTF-8"));
    response.addHeader("Content-description", "EventAttendees");
    response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
    ServletOutputStream stream = response.getOutputStream();
    wb.write(stream);
    stream.close();

    return true;
  }

  @SuppressWarnings("unchecked")
  public boolean ExcelWrite2(HttpServletRequest request, HttpServletResponse response,
      List dataList, List colinfoList, String filename) throws Exception {

    // String colnames, String colinfos,
    // String[] col_names = colnames.toLowerCase().split(";");
    // String[] col_info = colinfos.split(";");

    String tm = getStringFromDate(new Date(), "yyyy년 MM월 dd일 - HH시 mm분");

    HSSFWorkbook wb = new HSSFWorkbook();
    // 「sheet1」라는 이름의 워크시트를 표시하는 오브젝트 생성
    HSSFSheet sheet1 = wb.createSheet("sheet1");

    // 행의 작성
    /************************ 엑셀 스타일 지정 ****************************/
    HSSFCellStyle style_title = wb.createCellStyle();
    HSSFCellStyle style_data = wb.createCellStyle();
    HSSFCellStyle style_header = wb.createCellStyle();

    HSSFFont font = wb.createFont();
    HSSFFont font_title = wb.createFont();

    font_title.setFontHeightInPoints((short) 12);
    font_title.setBoldweight((short) 700);

    font.setBoldweight((short) 700);

    style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
    style_title.setFont(font_title);
    style_title.setFillForegroundColor(HSSFColor.LIGHT_ORANGE.index);
    style_title.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
    style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);


    style_data.setBorderRight(HSSFCellStyle.BORDER_THIN);
    style_data.setBorderLeft(HSSFCellStyle.BORDER_THIN);
    style_data.setBorderTop(HSSFCellStyle.BORDER_THIN);
    style_data.setBorderBottom(HSSFCellStyle.BORDER_THIN);
    style_data.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style_header.setBorderRight(HSSFCellStyle.BORDER_THIN);
    style_header.setBorderLeft(HSSFCellStyle.BORDER_THIN);
    style_header.setBorderTop(HSSFCellStyle.BORDER_THIN);
    style_header.setBorderBottom(HSSFCellStyle.BORDER_THIN);
    style_header.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
    style_header.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
    style_header.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style_header.setFillBackgroundColor(HSSFColor.AQUA.index);
    style_header.setAlignment(HSSFCellStyle.ALIGN_CENTER);
    style_header.setFont(font);
    /************************ 엑셀 스타일 지정 ****************************/



    /************************ 엑셀 정보 출력 ****************************/
    HSSFRow row_title = sheet1.createRow(2);
    row_title.setHeight((short) 600);
    HSSFCell cell_title = row_title.createCell(0);
    cell_title.setCellValue(filename);
    cell_title.setCellStyle(style_title);
    sheet1.addMergedRegion(new CellRangeAddress(2, 2, 0, (colinfoList.size() - 1)));


    HSSFRow row_date = sheet1.createRow(3);
    HSSFCell cell_date = row_date.createCell(0);

    cell_date = row_date.createCell(0);
    cell_date.setCellValue("출력일자");
    cell_date = row_date.createCell(1);
    cell_date.setCellValue(tm);
    /************************ 엑셀 정보 출력 ****************************/


    HSSFRow row0 = sheet1.createRow(5);
    HSSFCell cell = null;

    for (int k = 0; k < colinfoList.size(); k++) {
      HashMap colmap = (HashMap) colinfoList.get(k);
      row0.setHeight((short) 500);
      cell = row0.createCell(k);
      sheet1.setColumnWidth(k, (short) 4000);
      cell.setCellValue((String) colmap.get("COL_INFO"));
      cell.setCellStyle(style_header);
    }

    for (int i = 0; i < dataList.size(); i++) {
      row0 = sheet1.createRow(i + 6);
      row0.setHeight((short) 400);
      Map article = (HashMap) dataList.get(i);

      for (int j = 0; j < colinfoList.size(); j++) {
        HashMap colmap = (HashMap) colinfoList.get(j);
        cell = row0.createCell(j);
        Object obj = article.get(((String) colmap.get("COL_NAME")).toUpperCase());
        if (obj == null)
          cell.setCellValue("");
        else
          cell.setCellValue(obj.toString());

        cell.setCellStyle(style_data);
      }

    }

    String ftm = getStringFromDate(new Date(), "yyyyMMddHHmm");
    filename = filename + "_" + ftm + ".xls";

    response.setContentType("application/octet-stream");
    response.setHeader("Accept-Ranges", "bytes");
    String userAgent = request.getHeader("User-Agent");
    boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

    if (ie) {
      filename = URLEncoder.encode(filename, "utf-8").replaceAll("\\+", "%20");
    } else {
      filename = new String(String.valueOf(filename).getBytes("utf-8"), "iso-8859-1");
    }

    response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
    response.setHeader("Content-Transfer-Encoding", "binary");

    ServletOutputStream stream = response.getOutputStream();
    wb.write(stream);
    stream.close();

    return true;
  }


  /**
   * @method : ExcelWrite
   * @DoWhat : Query 질의 결과를 엑셀파일로 저장함. (설문결과 전용) 2011.08.03 ByunghanHan
   * @param response : 응답 개체
   * @param dataList : 질의 결과
   * @param colnames : 저장할 컬럼 목록
   * @param colinfos : 저장할 컬럼 정의
   * @param filename : 저장할 파일명
   * @return : boolean
   */
  @SuppressWarnings("unchecked")
  public boolean ExcelSrvyWrite(HttpServletResponse response, List dataList, ArrayList colinfoList,
      String filename) throws Exception {

    // String colnames, String colinfos,

    // String[] col_names = colnames.toLowerCase().split(";");
    // String[] col_info = colinfos.split(";");

    String tm = getStringFromDate(new Date(), "yyyy년 MM월 dd일 - HH시 mm분");

    HSSFWorkbook wb = new HSSFWorkbook();
    // 「sheet1」라는 이름의 워크시트를 표시하는 오브젝트 생성
    HSSFSheet sheet1 = wb.createSheet("sheet1");

    // 행의 작성
    /************************ 엑셀 스타일 지정 ****************************/
    HSSFCellStyle style_title = wb.createCellStyle();
    HSSFCellStyle style_data = wb.createCellStyle();
    HSSFCellStyle style_header = wb.createCellStyle();

    HSSFFont font = wb.createFont();
    HSSFFont font_title = wb.createFont();

    font_title.setFontHeightInPoints((short) 12);
    font_title.setBoldweight((short) 700);

    font.setBoldweight((short) 700);

    style_title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
    style_title.setFont(font_title);
    style_title.setFillForegroundColor(HSSFColor.LIGHT_ORANGE.index);
    style_title.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
    style_title.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);


    style_data.setBorderRight(HSSFCellStyle.BORDER_THIN);
    style_data.setBorderLeft(HSSFCellStyle.BORDER_THIN);
    style_data.setBorderTop(HSSFCellStyle.BORDER_THIN);
    style_data.setBorderBottom(HSSFCellStyle.BORDER_THIN);
    style_data.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style_header.setBorderRight(HSSFCellStyle.BORDER_THIN);
    style_header.setBorderLeft(HSSFCellStyle.BORDER_THIN);
    style_header.setBorderTop(HSSFCellStyle.BORDER_THIN);
    style_header.setBorderBottom(HSSFCellStyle.BORDER_THIN);
    style_header.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
    style_header.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
    style_header.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

    style_header.setFillBackgroundColor(HSSFColor.AQUA.index);
    style_header.setAlignment(HSSFCellStyle.ALIGN_LEFT);
    style_header.setFont(font);
    /************************ 엑셀 스타일 지정 ****************************/



    /************************ 엑셀 정보 출력 ****************************/
    HSSFRow row_title = sheet1.createRow(2);
    row_title.setHeight((short) 600);
    HSSFCell cell_title = row_title.createCell(0);
    cell_title.setCellValue(filename);
    cell_title.setCellStyle(style_title);
    sheet1.addMergedRegion(new CellRangeAddress(2, 2, 0, (colinfoList.size() - 1)));


    HSSFRow row_date = sheet1.createRow(3);
    HSSFCell cell_date = row_date.createCell(0);

    cell_date = row_date.createCell(0);
    cell_date.setCellValue("출력일자");
    cell_date = row_date.createCell(1);
    cell_date.setCellValue(tm);
    /************************ 엑셀 정보 출력 ****************************/


    HSSFRow row0 = sheet1.createRow(5);
    HSSFCell cell = null;
    SrvymainVO srvyVO = new SrvymainVO();
    String compstr = "RN|" + new Integer(srvyVO.getSrvy_nm_idx()).toString() + "|"
        + new Integer(srvyVO.getSrvy_cp_idx()).toString();

    for (int k = 0; k < colinfoList.size(); k++) {
      HashMap colmap = (HashMap) colinfoList.get(k);
      row0.setHeight((short) 500);
      cell = row0.createCell(k);
      if (compstr.lastIndexOf((String) colmap.get("COL_NAME")) >= 0)
        sheet1.setColumnWidth(k, (short) 6000);
      else
        sheet1.setColumnWidth(k, (short) 16000);

      cell.setCellValue((String) colmap.get("COL_INFO"));
      cell.setCellStyle(style_header);
    }

    for (int i = 0; i < dataList.size(); i++) {
      row0 = sheet1.createRow(i + 6);
      row0.setHeight((short) 400);
      Map article = (HashMap) dataList.get(i);

      for (int j = 0; j < colinfoList.size(); j++) {
        HashMap colmap = (HashMap) colinfoList.get(j);
        cell = row0.createCell(j);
        Object obj = article.get(((String) colmap.get("COL_NAME")).toUpperCase());
        if (obj == null)
          cell.setCellValue("");
        else
          cell.setCellValue(obj.toString());

        cell.setCellStyle(style_data);
      }

    }

    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-disposition",
        "attachment;filename=" + java.net.URLEncoder.encode(filename + "_" + tm + ".xls", "UTF-8"));
    response.addHeader("Content-description", "EventAttendees");
    response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
    ServletOutputStream stream = response.getOutputStream();
    wb.write(stream);
    stream.close();

    return true;
  }

  /**
   * Date 를 String으로 변경...
   * 
   * @param dt : Date
   * @param format : ex) "yyyy-MM-dd HH:mm:SS"
   */
  public String getStringFromDate(Date dt, String format) {
    SimpleDateFormat smp = new SimpleDateFormat(format);
    return smp.format(dt);
  }


}
