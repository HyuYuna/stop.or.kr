package egovframework.plani.template.cmm.utils.chart;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletResponse;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;

/**
 * @class : [PLANI_TMPL] [egovframework.plani.cmm.utils.chart] [ChartBase.java]
 * @DoWhat : jFreeChart를 이용해서 차트데이터를 생성한다.
 * @author : Bhhan
 * @date : 2013. 04. 01. 오후 3:10:49
 */
public abstract class ChartBase {

  protected JFreeChart chart = null;
  private ServletResponse response = null;

  /** 그래프 너비 */
  private int chartWidth = 300;

  /** 그래프 높이 */
  private int chartHeight = 300;

  /** 차트 제목 */
  protected String chartTitle = "";

  /** x축 제목 */
  protected String domainTitle = "";

  /** y축 제목 */
  protected String rangeTitle = "";

  /** 단위 접미어 */
  protected String unitSurfix = "";

  public ChartBase(ServletResponse response_, Object datalist) {
    response = response_;
    genChartDataset((List) datalist);
    genChart();
  }

  public abstract void genChartDataset(List datalist);

  public abstract void genChart();

  public void genChartAsStream() {
    BufferedOutputStream bout = null;

    try {
      bout = new BufferedOutputStream(response.getOutputStream());
      ChartUtilities.writeChartAsPNG(bout, chart, chartWidth, chartHeight);
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

  public int getChartWidth() {
    return chartWidth;
  }

  public void setChartWidth(int chartWidth) {
    this.chartWidth = chartWidth;
  }

  public int getChartHeight() {
    return chartHeight;
  }

  public void setChartHeight(int chartHeight) {
    this.chartHeight = chartHeight;
  }

  public String getChartTitle() {
    return chartTitle;
  }

  public void setChartTitle(String chartTitle) {
    this.chartTitle = chartTitle;
    chart.setTitle(chartTitle);
  }

  public String getDomainTitle() {
    return domainTitle;
  }

  public abstract void setDomainTitle(String domainTitle);

  public String getRangeTitle() {
    return rangeTitle;
  }

  public abstract void setRangeTitle(String rangeTitle);

  public String getUnitSurfix() {
    return unitSurfix;
  }

  public void setUnitSurfix(String unitSurfix) {
    this.unitSurfix = unitSurfix;
  }


}
