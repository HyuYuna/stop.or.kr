package egovframework.plani.template.cmm.utils.chart;

import java.awt.Color;
import java.awt.Font;
import java.text.NumberFormat;
import java.util.List;
import javax.servlet.ServletResponse;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.PieLabelLinkStyle;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.plot.PiePlot3D;
import org.jfree.chart.title.LegendTitle;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.util.Rotation;
import egovframework.plani.template.man.stat.vo.CommstatVO;

public class PieChartUtil extends ChartBase {

  DefaultPieDataset dataset = null;

  public PieChartUtil(ServletResponse response, Object datalist) {
    super(response, datalist);
  }

  @Override
  public void genChartDataset(List datalist) {
    // TODO Auto-generated method stub
    dataset = new DefaultPieDataset();

    for (int i = 0; i < datalist.size(); i++) {
      CommstatVO vo = (CommstatVO) datalist.get(i);
      ((DefaultPieDataset) dataset).setValue(vo.getChartdata_key(), vo.getChartdata_val());
    }
  }


  @Override
  public void genChart() {
    // TODO Auto-generated method stub
    chart = ChartFactory.createPieChart3D("그래프", (DefaultPieDataset) dataset, true, true, false);
    chart.setBackgroundPaint(Color.WHITE);
    PiePlot plot = (PiePlot) chart.getPlot();
    Font labelFont = null;

    labelFont = chart.getTitle().getFont();
    chart.getTitle().setFont(new Font("그래픽", Font.TRUETYPE_FONT, 13));

    // Legent 처리
    LegendTitle legend = chart.getLegend();
    legend.setItemFont(new Font("그래픽", Font.PLAIN, 10));
    legend.setVisible(false);

    // 백분율 표시
    plot.setLabelFont(new Font("그래픽", Font.PLAIN, 12));
    plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0} : {2}",
        NumberFormat.getNumberInstance(), NumberFormat.getPercentInstance()));
    plot.setLabelBackgroundPaint(Color.WHITE);
    // plot.setInteriorGap(0.02);
    plot.setMaximumLabelWidth(0.20);
    plot.setLabelLinkStyle(PieLabelLinkStyle.STANDARD);

    final PiePlot3D plot3d = (PiePlot3D) chart.getPlot();
    plot.setBackgroundPaint(Color.WHITE);
    plot3d.setStartAngle(290);
    plot3d.setDirection(Rotation.CLOCKWISE);
    plot3d.setForegroundAlpha(0.5f);
    plot3d.setNoDataMessage("No data to display");

  }

  @Override
  public void setDomainTitle(String domainTitle) {
    // TODO Auto-generated method stub

  }

  @Override
  public void setRangeTitle(String rangeTitle) {
    // TODO Auto-generated method stub

  }


}
