package source.monitors;

import javax.swing.*;
import java.awt.*;

public class ChartFrame extends JFrame
{
    private Chart chart;

    public ChartFrame()
    {
     this.chart = new Chart();
     this.setTitle("MonitoredVar - Live Chart");
     this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
     this.setSize(chart.getWINDOW_WIDTH(), chart.getWINDOW_HEIGHT());
     this.add(chart, BorderLayout.CENTER);
     this.setResizable(false);
     this.setVisible(true);
     this.requestFocus();

    }

    public void addPoint(double simTime, double value) throws Exception
    {
        chart.add(simTime,value);
    }

}
