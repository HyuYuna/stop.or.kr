package egovframework.plani.template.cmm.utils.chart;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.util.List;
import javax.servlet.ServletResponse;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.CategoryItemRenderer;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.data.category.DefaultCategoryDataset;
import egovframework.plani.template.man.stat.vo.CommstatVO;

public class LineChartUtil extends ChartBase {

  private DefaultCategoryDataset dataset = null;

  public LineChartUtil(ServletResponse response, List datalist) {
    super(response, datalist);
  }

  public LineChartUtil(ServletResponse response, Object datalist) {
    super(response, datalist);
  }

  @Override
  public void genChartDataset(List datalist) {
    // TODO Auto-generated method stub
    dataset = new DefaultCategoryDataset();


    for (int i = 0; i < datalist.size(); i++) {
      CommstatVO vo = (CommstatVO) datalist.get(i);
      dataset.addValue(vo.getChartdata_val(), vo.getChartdata_srz(),
          vo.getChartdata_key() + unitSurfix);
    }

    /*
     * dataset.addValue(2, "CALL", "201303"); dataset.addValue(1, "CALL", "201304");
     * dataset.addValue(2, "CASE", "201303"); dataset.addValue(1, "CASE", "201304");
     * dataset.addValue(1, "EBKDWN", "201303");
     */
  }


  @Override
  public void genChart() {
    // TODO Auto-generated method stub

    chart = ChartFactory.createLineChart3D(chartTitle, domainTitle, rangeTitle, dataset,
        PlotOrientation.VERTICAL, true, true, false);

    CategoryPlot plot = chart.getCategoryPlot();

    chart.getTitle().setFont(new Font("그래픽", Font.TRUETYPE_FONT, 13));
    chart.getLegend().setItemFont(new Font("그래픽", Font.PLAIN, 12));
    chart.setBackgroundPaint(Color.WHITE);
    // plot.setLabelFont(new Font("그래픽", Font.PLAIN, 12));

    // 단위를 정수로 고정시킴
    NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
    rangeAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
    rangeAxis.setLowerBound(0.0f);

    // X축 한글깨짐 처리
    plot.getDomainAxis().setLabelFont(new Font("그래픽", Font.PLAIN, 12));
    plot.getDomainAxis().setTickLabelFont(new Font("그래픽", Font.PLAIN, 12));
    plot.getDomainAxis().setCategoryLabelPositions(CategoryLabelPositions.UP_45);
    plot.setBackgroundPaint(Color.WHITE);
    plot.setRangeGridlinesVisible(true);
    plot.setRangeGridlinePaint(Color.GRAY);
    plot.setDomainGridlinesVisible(true);
    plot.setDomainGridlinePaint(Color.GRAY);


    // Y축 한글깨짐 처리
    plot.getRangeAxis().setLabelFont(new Font("그래픽", Font.PLAIN, 12));
    plot.getRangeAxis().setTickLabelFont(new Font("그래픽", Font.PLAIN, 12));

    CategoryItemRenderer itemRenderer = plot.getRenderer();
    int legendCnt = (plot.getLegendItems().getItemCount());
    for (int i = 0; i < legendCnt; i++) {
      plot.getRenderer().setSeriesStroke(i, new BasicStroke(2.0f));
      itemRenderer.setSeriesItemLabelsVisible(i, Boolean.TRUE);
    }

    if (legendCnt == 1) {
      chart.getLegend().setVisible(false);
      plot.getRenderer().setSeriesPaint(0, new Color(123, 104, 238));
    }

    // 값을 표시한다.
    LineAndShapeRenderer linerenderer = (LineAndShapeRenderer) plot.getRenderer();
    linerenderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
    linerenderer.setBaseItemLabelsVisible(true);
    linerenderer.setBaseItemLabelFont(new Font("그래픽", Font.TRUETYPE_FONT, 12));
    linerenderer.setBaseItemLabelPaint(Color.MAGENTA);


  }

  @Override
  public void setDomainTitle(String domainTitle) {
    // TODO Auto-generated method stub
    this.domainTitle = domainTitle;
    chart.getCategoryPlot().getDomainAxis().setLabel(domainTitle);
  }

  @Override
  public void setRangeTitle(String rangeTitle) {
    // TODO Auto-generated method stub
    this.rangeTitle = rangeTitle;
    chart.getCategoryPlot().getRangeAxis().setLabel(rangeTitle);
  }



}
