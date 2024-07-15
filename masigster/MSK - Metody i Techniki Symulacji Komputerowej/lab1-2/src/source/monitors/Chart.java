package source.monitors;

import javax.swing.*;
import java.awt.*;
import java.awt.geom.Line2D;
import java.awt.geom.Rectangle2D;
import java.util.ArrayList;
import java.util.Collections;

/**
 *  Live plot drawing class (always using SimTime as X-Axis !)
 *  Extends Swing JPanel, always use with ChartFrame class!
 * @author Konrad Kurek
 *
 */
public class Chart extends JPanel
{
    //Plot window size
    private  int WINDOW_HEIGHT = 500;
    private  int WINDOW_WIDTH = 1008;

    //Plotting Variables
    private ArrayList listX = new ArrayList<Double>();
    private ArrayList listY = new ArrayList<Double>();
    private JPanel jPanel;
    private double LineX, LineY;
    private int scale = 30;     //Always use scale from 15-25
    private int cubeSize = 5;

    //Auxiliary variables
    private int nodeCounter;

    /**
     * Public constructor for Chart class
     */
    public Chart()
    {
        super();
        this.setSize(WINDOW_WIDTH, WINDOW_HEIGHT);
        //this.nodeCounter = 0;
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g;

        Rectangle2D.Double rect;

        g2d.drawLine(0,WINDOW_HEIGHT - 4 * scale,WINDOW_WIDTH,WINDOW_HEIGHT -  4 * scale);
        g2d.drawString("SimTime", WINDOW_WIDTH - 60,WINDOW_HEIGHT -  3 * scale);

        //MAIN VERTICAL AXIS
        g2d.drawLine(WINDOW_WIDTH, WINDOW_HEIGHT - 4 * scale + 15, WINDOW_WIDTH, 0);
        g2d.drawString("Value", 45,15);

        //HORIZONTAL AXIS VALUES
        for(int x = 0; x < (WINDOW_HEIGHT/scale); x++)
        {
            g2d.setStroke(new BasicStroke(2));
            g2d.drawLine(0, (int)(this.WINDOW_HEIGHT - 4 * scale) - (x * scale) + 1, 15, (int)(this.WINDOW_HEIGHT - 4 * scale) - (x * scale) + 1);
            if((x % 5) == 0 && x != 0)
            g2d.drawString(Integer.toString(x),  20,(int)(this.WINDOW_HEIGHT - 4 * scale) - (x * scale) + 10);
            g2d.setStroke(new BasicStroke(1));
        }

        //DASHED LINE
        Stroke dashed = new BasicStroke(1, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 0, new float[]{12}, 0);
        g2d.setStroke(dashed);

        //AUXILIARY VERTICAL AXIS
        g2d.setColor(Color.GRAY);
        for(int x = 0; x < WINDOW_WIDTH; x += 100)
        {
            g2d.drawLine(x, 0, x, WINDOW_HEIGHT - 3 * scale);
            g2d.setColor(Color.BLACK);
            g2d.drawString(Integer.toString(x), x + 5, WINDOW_HEIGHT -  3 * scale);
            g2d.setColor(Color.GRAY);
        }

        //AUXILIARY HORIZONTAL AXIS
        for(int x = 0; x < WINDOW_HEIGHT/scale + 3; x++)
        {
            if(!((int)(this.WINDOW_HEIGHT) - (x * scale) < WINDOW_HEIGHT -  3 * scale))
            {
                continue;
            }
            g2d.drawLine(0, (int)(this.WINDOW_HEIGHT) - (x * scale), WINDOW_WIDTH, (int)(this.WINDOW_HEIGHT) - (x * scale));
        }
        g2d.setColor(Color.BLACK);
        g2d.setStroke(new BasicStroke(1));

        //NODES COUNTER
        //g2d.drawString("Nodes: " + nodeCounter, WINDOW_WIDTH - 90, WINDOW_HEIGHT - 120);

        for(int i = 0; i <listX.size(); i++)
        {
            //LINE BETWEEN POINTS DRAWING
            if(i>0)
            {
                LineX = ((Double) listX.get(i-1)).doubleValue();
                LineY = (WINDOW_HEIGHT - 4 * scale) - ((Double) listY.get(i-1)).doubleValue();
            }
            else
            {
                LineX = 0;
                LineY = (WINDOW_HEIGHT - 4 * scale);
            }
            g2d.setColor(Color.BLUE);
            rect = new Rectangle2D.Double((Double)listX.get(i),((WINDOW_HEIGHT - (4 * scale)) - ((Double) listY.get(i-1)).doubleValue()), cubeSize, cubeSize);
            g2d.fill(rect);
            g2d.setColor(Color.BLACK);
            Shape s = new Line2D.Double(rect.x, rect.y, LineX, LineY);
            g2d.draw(s);
            rect = null;
        }
        g2d.dispose();
    }

    /**
     * Method updates chart, after checking it's integrity of X and Y axis array length
     * @throws Exception X and Y axis arrays length mismatch
     */
    public void updateChart() throws Exception
    {
        if(checkIntegrity())
        {
            this.repaint();
        }
        else
        {
            throw new Exception("Missmatched length of X and Y arrays!");
        }
    }

    /**
     * Adds to arrays points used to draw plot
     * @param simTime simulation time of measurement
     * @param value measured value
     */
    public void add(double simTime, double value) throws Exception
    {
        listX.add(simTime);

        if(((WINDOW_HEIGHT - (4 * scale)) - (double) getMaxValue(listY)) < 0)
        {
            int tmpScale = scale;
            int oldScale = scale;
            while(((WINDOW_HEIGHT - (4 * tmpScale)) - (double) getMaxValue(listY)) <= 0)
            {
                tmpScale--;
            }
            //this.setScale(scale - 5);
            scale = tmpScale;
            rescale(oldScale);
        }

        //FULL SCREEN
        listY.add((value * scale + (cubeSize / 2)));

        //WSYZSTKIE NA LISCIE  ODWROCIC I POMNOZYC ZNOWU


        updateChart();
        nodeCounter++;


    }

    private void rescale(int oldScale)
    {
        ArrayList<Double> newList = new ArrayList<Double>();
        double tempVal;
        if(listY.size() != 0)
        {
            for(int i = 0; i< listY.size(); i++)
            {
                tempVal = (( ((Double) listY.get(i-1)).doubleValue() - (cubeSize / 2)) / oldScale);
                newList.add(tempVal * scale + (cubeSize / 2));
            }

            listY = newList;
        }
    }

    /**
     * Checks integrity between two array list, which hold X and Y values
     * @return integrity flag
     */
    public boolean checkIntegrity()
    {
        if(listX.size() == listY.size())
        {
            return true;
        }
        return false;
    }

    //---------------- SETTERS AND GETTERS

    public int getWINDOW_HEIGHT() {
        return WINDOW_HEIGHT;
    }

    public int getWINDOW_WIDTH() {
        return WINDOW_WIDTH;
    }

    public void setScale(int scale) {
        this.scale = scale;
    }

    public void setCubeSize(int cubeSize) {
        this.cubeSize = cubeSize;
    }

    //Finding max Value in Array
    public double getMaxValue (ArrayList<Double> list)
    {

        if( list.size() != 0)
        {
            double max = list.get(0);
            for(int i = 0; i < list.size(); i++)
            {
                if( list.get(i) > max)
                {
                    max = list.get(i);
                }
            }
            return max;
        }
        return 1;
    }
}
