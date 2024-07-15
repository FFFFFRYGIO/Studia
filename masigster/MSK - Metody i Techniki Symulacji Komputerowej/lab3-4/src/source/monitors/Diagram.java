package source.monitors;

/*
	Wybrane funkcje klasy Diagram:
	- podw�jne buforowanie obrazu (zmniejszenie op�nie� podczas przesuwania i zmieniania rozmiaru okna),
	- opisy osi oraz legenda (mo�liwo�� wprowadzania opis�w),
	- mo�liwo�� ukrywania krzywych,
	- mo�liwo�� dodawania sta�ych do wykresu zale�no�ci czasowych,
	- zapis wykres�w do plik�w w formacie PNG.
*/

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

/**
 * Description...
 * 
 * @author Dariusz Pierzchala
 *
 */
public class Diagram extends javax.swing.JFrame 
{

	private static final long serialVersionUID = 6863523738132832595L;
	
	
	/**
	 * Chart types
	 */
	public enum DiagramType {
		HISTOGRAM("histogram"), TIME("zaleznosc czasowa"), DISTRIBUTION("dystrybuanta");
		
		private String name = null; 
		
		private DiagramType(String typeName) {
			name = typeName;
		}
		
		public String toString() {
			return name;
		}
		
		public static DiagramType toDiagramType(String name) {
			if ( HISTOGRAM.toString().equalsIgnoreCase(name) )
				return HISTOGRAM;
			if ( TIME.toString().equalsIgnoreCase(name) )
				return TIME;
			if ( DISTRIBUTION.toString().equalsIgnoreCase(name) )
				return DISTRIBUTION;
			return null;
		}
	};

	/**
	 * Basic class containing elements of the chart: data, labels, colour
	 * settings and control box
	 */
	class Curve {
		MonitoredVar variable = null;
		List<Double> constants = null;
		String label = null;
		Color color = null;
		JCheckBoxMenuItem checkBox = null;

		/**
		 * 
		 * @param monVar
		 * @param constVal
		 * @param lineColor
		 * @param legendLabel
		 */
		public Curve(MonitoredVar monVar, List<Double> constVal, Color lineColor, String legendLabel) {
			constants = new ArrayList<Double>();
			constants.addAll( constVal );
			init(monVar, lineColor, legendLabel);
		}

		public Curve(MonitoredVar monVar, Double constVal, Color lineColor, String legendLabel) {
			constants = new ArrayList<Double>();
			if (constVal!=null)
				constants.add( constVal );
			init(monVar, lineColor, legendLabel);
		}
		
		private void init(MonitoredVar monVar, Color lineColor, String legendLabel) {
			variable = monVar;
			color = lineColor;
			label = legendLabel;

			if (label != null && label.length() > 0)
				checkBox = newCheckMenuItem(label);
			else
				checkBox = newCheckMenuItem( Language.getString("Curve") );
		}
		
		/**
		 * Returns list of constants
		 * @return
		 */
		public List<Double> getConstants() {
			if (constants!=null)
				return constants;
			return new ArrayList<Double>();
		}

		public MonitoredVar getVariable() {
			return variable;
		}

		public Color getColor() {
			return color;
		}

		public boolean isCheckBoxSelected() {
			if (checkBox != null)
				return checkBox.isSelected();
			return true;
		}

		public String getLabel() {
			return label;
		}

		public JCheckBoxMenuItem getCheckBox() {
			return checkBox;
		}

		private JCheckBoxMenuItem newCheckMenuItem(String text) {
			JCheckBoxMenuItem check = new JCheckBoxMenuItem(text, true);
			ActionListener aListener = new ActionListener() {
				public void actionPerformed(ActionEvent event) {
					refresh();
				}
			};
			check.addActionListener(aListener);
			return check;
		}
	}

	/**
	 * Draw panel displaying the chart
	 */
	class JDrawPanel extends JPanel {

		/**
		 * 
		 */
		private static final long serialVersionUID = 6603006107958296895L;

		@Override
		protected void paintComponent(Graphics arg0) {
			super.paintComponent(arg0);
			Graphics2D graph = (Graphics2D) arg0;
//			if (generateImage() != null)
			if (imageBuffer != null)
				graph.drawImage(imageBuffer, 0, 0, this);
		}

	}

	/**
	 * Dump class for language package providing translation of GUI
	 */
	static class Language {
		public static String getString(String key) {
			return key;
		}
	}

	
	//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	
	
	/**
	 * Variables defining canvas spacing and dimension
	 */
	private static final int MIN_WIDTH = 450;
	private static final int MIN_HEIGHT = 350;
	private static final int CHART_TOP_HEIGHT_MARGIN = 41;
	private static final int LEGEND_ROW_HEIGHT = 20;
	private static final int LEGEND_LEFT_MARGIN = 40;
	private static final int LEGEND_RIGHT_MARGIN = 20;
	private static final int LEGEND_LEFT_PADDING = 12;
	private static final int BOTTOM_HEIGHT_MARGIN = 01;


	Vector<Curve> curves = new Vector<Curve>();
	private DiagramType type = null;

	// parametry okreslajace obszar gdzie rysowac wykrest a gdzie inne elementy
	private int xmin;
	private int xmax;
	private int ymin;
	private int ymax;
	private double maxValue;
	private double minValue;
	private double deltaValue;
	private double deltax, deltay;
	private double minNumber, maxNumber;
	private int liczbaPrzedzialow = 50;
	private java.text.NumberFormat nf;
	// zmienne string do opisu osi wykresu
	private String maxNumberStr;
	private String minNumberStr;
	private String maxValueStr;
	private String minValueStr;

	int legendTotalWidth = 0;
	private String oXLabel;
	private String oYLabel;

	Double desiredMinValue = null;
	Double desiredMaxValue = null;
	Double desiredMinNumber = null;
	Double desiredMaxNumber = null;
	
	/**
	 * Buffer for the chart
	 */
	BufferedImage imageBuffer = null;

	/**
	 * Graphical interface elements
	 */
	private JMenuBar menuBar = null;
	private JMenu optionsMenu = null;
	private JMenuItem saveMenuItem = null;
	private JMenuItem closeMenuItem = null;
	private JMenu legendMenu = null;
	private JPanel drawPanel = null;

	/** Creates new form DiagramForm */
	public Diagram(String tp, String title) {
		type = DiagramType.toDiagramType(tp);
		if (type!=null) {
			initialize(title);
		} else
			System.err.println("No such type of digram as " + tp);

		nf = java.text.NumberFormat.getInstance();
		nf.setMaximumFractionDigits(5);
	}

	/** Creates new form DiagramForm */
	public Diagram(DiagramType chartType, String title) {
		type = chartType;
		initialize(title + " (" + chartType + ")");

		nf = java.text.NumberFormat.getInstance();
		nf.setMaximumFractionDigits(5);
	}

	/**
	 * Initialize the object
	 * @param title
	 */
	private void initialize(String title) {
		initComponents();

		setJMenuBar(getDialogMenuBar());
		setContentPane(getDrawPanel());

//		setTitle(title + " : " + type.toString() );
		setTitle(title);
		
		xmin = 31;
		ymin = CHART_TOP_HEIGHT_MARGIN;
		// xmax = getWidth() - LEGEND_WIDTH_MARGIN;
		// /ymax = getHeight() - BOTTOM_HEIGHT_MARGIN;
		ymax = getHeight() - BOTTOM_HEIGHT_MARGIN;
		deltax = xmax - xmin;
		deltay = ymax - ymin;
		maxNumber = 0;
		minNumber = 0;
	}

	/**
	 * Setter for chart labels
	 * @param labelOX - X axis label
	 * @param labelOY - Y axis label
	 */
	public void setOXYLabels(String labelOX, String labelOY) {
		oXLabel = labelOX;
		oYLabel = labelOY;
	}

	/**
	 * Return numbers of labeled curves
	 * @return
	 */
	private int getLabelsNumber() {
		int ret = 0;
		for (int i = 0; i < curves.size(); i++) {
			Curve cur = curves.get(i);
			if (cur.getLabel() != null)
				ret++;
		}
		return ret;
	}
	
	/**
	 * Calculates width of the legend panel
	 * @param g
	 */
	private void calculateLegendWidth(Graphics g) {
		int legendWidth = 0;
		for (int i = 0; i < curves.size(); i++) {
			Curve cur = curves.get(i);
			String label = cur.getLabel();
			if (label != null) {
				int tmp = g.getFontMetrics().stringWidth(label);
				if (tmp > legendWidth)
					legendWidth = tmp;
			}
		}
		legendWidth += LEGEND_LEFT_PADDING;
		legendWidth += LEGEND_LEFT_MARGIN;
		legendWidth += LEGEND_RIGHT_MARGIN;
		legendTotalWidth = legendWidth;
	}

	/**
	 * Rebuild the legend menu (put check boxed menu items)
	 */
	private void rebuildLegendMenu() {
		getJMenuLegend().removeAll();
		for (int i = 0; i < curves.size(); i++) {
			Curve cur = curves.get(i);
			if (cur.getCheckBox() != null)
				getJMenuLegend().add(cur.getCheckBox());
		}
	}

	private void actualizeDesiredRange() {
		if (desiredMaxNumber != null)
			maxNumber = desiredMaxNumber;

		if (desiredMinNumber != null)
			minNumber = desiredMinNumber;

		if (desiredMaxValue != null)
			maxValue = desiredMaxValue;

		if (desiredMinValue != null)
			minValue = desiredMinValue;
	}
	
	private void actualizeValuesRange(MonitoredVar mv) {
		double min = Statistics.min(mv);
		double max = Statistics.max(mv);
		double mint = mv.getChanges().get(0).getTime();
		double maxt = mv.getChanges().getLast().getTime();
		if (type == DiagramType.DISTRIBUTION) {
			if (curves.size() > 1) {
				if (maxValue < max)
					maxValue = max;
				if (minValue > min)
					minValue = min;
			} else {
				maxValue = max;
				minValue = min;
				maxNumber = 1;
			}
			deltaValue = maxValue - minValue;
		} else if (type == DiagramType.TIME) {
			if (curves.size() > 1) {
				if (maxValue < maxt)
					maxValue = maxt;
				if (minValue > mint)
					minValue = mint;
				if (minNumber > min)
					minNumber = min;
				if (maxNumber < max)
					maxNumber = max;
			} else {
				maxValue = maxt;
				minValue = mint;
				minNumber = min;
				maxNumber = max;
			}
			deltaValue = maxValue - minValue;
		} else if (type == DiagramType.HISTOGRAM) {
			if (curves.size() > 1) {
				if (maxValue < max)
					maxValue = max;
				if (minValue > min)
					minValue = min;
			} else {
				maxValue = max;
				minValue = min;
			}
			deltaValue = maxValue - minValue;

			int[] histValues;
			histValues = mv.getHistogram().getGroupedHistogram(liczbaPrzedzialow);
			for (int i = 0; i < liczbaPrzedzialow; i++) {
				if (maxNumber < histValues[i])
					maxNumber = histValues[i];
			}
		}
	}

	private void actualizeConstantsRange(List<Double> mv) {
		if (mv != null && mv.size()>0) {
			double min = Collections.min( mv );
			double max = Collections.max( mv );
			double mint = min;
			double maxt = max;
			if (type == DiagramType.DISTRIBUTION) {
				if (curves.size() > 1) {
					if (maxValue < max)
						maxValue = max;
					if (minValue > min)
						minValue = min;
				} else {
					maxValue = max;
					minValue = min;
					maxNumber = 1;
				}
				deltaValue = maxValue - minValue;
			} else if (type == DiagramType.TIME) {
				if (curves.size() > 1) {
					if (maxValue < maxt)
						maxValue = maxt;
					if (minValue > mint)
						minValue = mint;
					if (minNumber > min)
						minNumber = min;
					if (maxNumber < max)
						maxNumber = max;
				} else {
					maxValue = maxt;
					minValue = mint;
					maxNumber = max;
					minNumber = min;
				}
				deltaValue = maxValue - minValue;
			} else if (type == DiagramType.HISTOGRAM) {
				if (curves.size() > 1) {
					if (maxValue < max)
						maxValue = max;
					if (minValue > min)
						minValue = min;
				} else {
					maxValue = max;
					minValue = min;
				}
				deltaValue = maxValue - minValue;
			}
		}
	}
	
	/**
	 * Show the chart with predefined window sizing
	 * @param xMin
	 * @param xMax
	 * @param yMin
	 * @param yMax
	 */
	public void show(double xMin, double xMax, double yMin, double yMax) {
		if (type!=null) {
			desiredMinValue = xMin;
			desiredMaxValue = xMax;
			desiredMinNumber = yMin;
			desiredMaxNumber = yMax;
			setVisible(true);
			refresh();
		}
	}
	
	@SuppressWarnings( { "deprecation" })
	public void show() {
		if (type!=null && curves.size() > 0) {
			super.show();
			refresh();
		} else
			System.err.println("Diagram >" + this.getTitle() +"<: brak danych do wyświetlenia.");
	}
	
	public void add(MonitoredVar mv, Color whatColor) {
		if ((mv.getChanges()==null)||(mv.getChanges().size()==0))
			return;
		add(mv, null, whatColor, null);
	}
	
	/**
	 * Add monitored variable with defining the label
	 * @param mv
	 * @param whatColor
	 * @param label
	 */
	public void add(MonitoredVar mv, Color whatColor, String label) {
		add(mv, null, whatColor, label);
	}

	/**
	 * Add monitored variable and set label and the constant 
	 * @param mv
	 * @param constant
	 * @param whatColor
	 * @param label
	 */
	public void add(MonitoredVar mv, Double constant, Color whatColor, String label) {
		if (type!=null) {
			Curve cur = new Curve(mv, constant, whatColor, label);
			curves.add(cur);
			actualizeValuesRange(mv);
			rebuildLegendMenu();
	
			if (type == DiagramType.DISTRIBUTION) {
			} else if (type == DiagramType.TIME) {
				actualizeConstantsRange( cur.getConstants() );
			} else if (type == DiagramType.HISTOGRAM) {
			}
		}
	}
	
	/**
	 * This method is called from within the constructor to initialize the form.
	 * WARNING: Do NOT modify this code. The content of this method is always
	 * regenerated by the Form Editor.
	 */
	private void initComponents() {// GEN-BEGIN:initComponents

		getContentPane().setLayout(null);

		setTitle("Wykres");
		addComponentListener(new java.awt.event.ComponentAdapter() {
			public void componentResized(java.awt.event.ComponentEvent evt) {
				resizedWindow(evt);
			}
		});
		addWindowListener(new java.awt.event.WindowAdapter() {
			public void windowClosing(java.awt.event.WindowEvent evt) {
				exitForm(evt);
			}
		});

		java.awt.Dimension screenSize = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
		setBounds((screenSize.width - MIN_WIDTH) / 2, (screenSize.height - MIN_HEIGHT) / 2, MIN_WIDTH, MIN_HEIGHT);
	}// GEN-END:initComponents

	private void resizedWindow(java.awt.event.ComponentEvent evt) {// GEN-FIRST:event_resizeWindow

		int labelsSize = getLabelsNumber();

		int minLegendHeight = (LEGEND_ROW_HEIGHT + 5) * (labelsSize + 1) + CHART_TOP_HEIGHT_MARGIN + BOTTOM_HEIGHT_MARGIN;
		int properHeight = Math.max(minLegendHeight, MIN_HEIGHT);

		boolean reSet = false;
		int newHeight = getHeight();
		if (newHeight < properHeight) {
			reSet = true;
			newHeight = properHeight;
		}

		int newWidth = getWidth();
		if (newWidth < MIN_WIDTH) {
			reSet = true;
			newWidth = MIN_WIDTH;
		}

		if (reSet) {
			setSize(newWidth, newHeight);
		} else 
		{
			/*
			 * setSize() calls resizeWindow() so this part will be called next
			 * time (after setting proper size)
			 */

			xmax = getDrawPanel().getWidth() - legendTotalWidth;
			ymax = getDrawPanel().getHeight() - BOTTOM_HEIGHT_MARGIN - CHART_TOP_HEIGHT_MARGIN;

			deltax = xmax - xmin;
			deltay = ymax - ymin;
			generateImage();
			repaint();
		}

	}// GEN-LAST:event_resizeWindow

	/** Exit the Application */
	private void exitForm(java.awt.event.WindowEvent evt) {// GEN-FIRST:event_exitForm
		this.dispose();
	}// GEN-LAST:event_exitForm

	// Variables declaration - do not modify//GEN-BEGIN:variables
	// End of variables declaration//GEN-END:variables

	private int x(double xv) {
		double tmp = (xv - minValue) * deltax / deltaValue + xmin;
		float tmp2 = Math.round(tmp);
		return Math.round(tmp2);
	}

	private int y(double yv) {
		double tmp = ymax - (yv - minNumber) * (deltay / (maxNumber - minNumber));
		float tmp2 = Math.round(tmp);
		return Math.round(tmp2);
	}

	private void rysujDystrybuante(Graphics g, MonitoredVar mv, Color c) {
		g.setColor(c);
		Histogram h = mv.getHistogram();
		int n = mv.getChanges().size();
		double actualCountD = 0;
		int lastCount = 0, actualCount = ymax;
		double actualValD;
		int lastVal, actualVal = xmin - 1;
		for (int i = 0; i < h.size(); i++) {
			lastVal = actualVal;
			actualValD = h.get(i);
			actualVal = x(actualValD);
			lastCount = actualCount;
			actualCountD += 1; // h.getElement(i).getNumber();
			actualCount = y(actualCountD / n);
			g.drawLine(lastVal, lastCount, actualVal, lastCount);
			g.drawLine(actualVal, lastCount, actualVal, actualCount);
		}
		g.drawLine(actualVal, actualCount, xmax + 1, actualCount);
	}

	private void rysujZaleznoscCzasowa(Graphics g, MonitoredVar mv, Color c) {
		g.setColor(c);
		ChangesList chl = mv.getChanges();
		Change ch = chl.get(0);
		double lastt, actualt = ch.getTime();
		double lastval, actualval = ch.getValue();
		g.drawOval(x(actualt) - 2, y(actualval) - 2, 4, 4);
		for (int i = 1; i < chl.size(); i++) {
			lastval = actualval;
			lastt = actualt;
			ch = chl.get(i);
			actualval = ch.getValue();
			actualt = ch.getTime();
			g.drawLine(x(lastt), y(lastval), x(actualt), y(actualval));
			g.drawOval(x(actualt) - 2, y(actualval) - 2, 4, 4);
		}

	}

	/**
	 * Draw constant value on the chart of time function
	 * @param g
	 * @param con
	 * @param c
	 */
	private void rysujZaleznoscCzasowa(Graphics g, Double con, Color c) {
		g.setColor(c);
		g.drawLine(x(0), y(con), x(maxValue), y(con));
		g.drawOval(x(0) - 2, y(con) - 2, 4, 4);
		g.drawOval(x(maxValue) - 2, y(con) - 2, 4, 4);

	}

	private void rysujHistogram(Graphics g, MonitoredVar mv, Color c) {
		int[] histValues = mv.getHistogram().getGroupedHistogram(liczbaPrzedzialow);
		g.setColor(c);
		int x1 = xmin;
		int xstep = Math.round((xmax - xmin) / liczbaPrzedzialow);
		int x2 = x1 + xstep;
		int y2 = y(0);
		for (int i = 0; i < liczbaPrzedzialow; i++) {
			int y1 = y(histValues[i]);
			g.drawLine(x1, y1, x2, y1);
			g.drawLine(x1, y2, x1, y1);
			g.drawLine(x2, y2, x2, y1);
			x1 = x2;
			x2 = x1 + xstep;
		}
	}

	/**
	 * Draw legend panel
	 * @param g
	 */
	private void rysujLegende(Graphics2D g) {
		g.setColor(Color.BLACK);

		int oxLabelX = xmin;
		int oxLabelY = ymin - 10;
		String tmpLabel = oXLabel;
		if (tmpLabel == null)
			tmpLabel = "";
		g.drawString(tmpLabel, oxLabelX, oxLabelY);

		int oyLabelX = xmin - 10;
		int oyLabelY = ymax;
		double angle = -Math.PI / 2;

		g.rotate(angle, oyLabelX, oyLabelY);

		tmpLabel = oYLabel;
		if (tmpLabel == null)
			tmpLabel = "";
		g.drawString(tmpLabel, oyLabelX, oyLabelY);
		g.rotate(-angle, oyLabelX, oyLabelY);

		int labelXPos = xmax + LEGEND_LEFT_MARGIN;
		int labelYPos = ymin + LEGEND_ROW_HEIGHT;

		for (int i = 0; i < curves.size(); i++) {
			Curve cur = curves.get(i);
			if (cur.isCheckBoxSelected() && cur.getLabel()!=null) {
				g.setColor(Color.BLACK);
				g.drawString("" + cur.getLabel(), labelXPos + LEGEND_LEFT_PADDING, labelYPos + 5);
				// g.fillRect( labelXPos - 4, labelYPos - 4, 9, 9);
				g.setColor(cur.getColor());
				g.drawOval(labelXPos - 2, labelYPos - 2, 4, 4);
				g.fillOval(labelXPos - 2, labelYPos - 2, 4, 4);
				labelYPos += LEGEND_ROW_HEIGHT;
			}
		}
	}

	/**
	 * Generate the chart on the graphics
	 * @param graph
	 */
	private void generateView(Graphics graph) {
		Graphics2D g = (Graphics2D) graph;

		g.setPaintMode();
		g.setColor(Color.BLACK);
		g.drawRect(xmin - 2, ymin - 1, xmax - xmin + 4, ymax - ymin + 2);
		MonitoredVar mv;
		List<Double> con;
		Color c;

		if (type == DiagramType.DISTRIBUTION)
			for (int i = 0; i < curves.size(); i++) {
				Curve cur = curves.get(i);
				if (cur.isCheckBoxSelected()) {
					mv = cur.getVariable();
					c = cur.getColor();
					rysujDystrybuante(g, mv, c);
				}
			}
		else if (type == DiagramType.TIME) {
			for (int i = 0; i < curves.size(); i++) {
				Curve cur = curves.get(i);
				if (cur.isCheckBoxSelected()) {
					mv = cur.getVariable();
					c = cur.getColor();
					con = cur.getConstants();
					for(int j=0; j<con.size(); j++) {
						rysujZaleznoscCzasowa(g, con.get(j), c);
					}
					rysujZaleznoscCzasowa(g, mv, c);
				}
			}
		} else if (type == DiagramType.HISTOGRAM) {
			for (int i = 0; i < curves.size(); i++) {
				Curve cur = curves.get(i);
				if (cur.isCheckBoxSelected()) {
					mv = cur.getVariable();
					c = cur.getColor();
					rysujHistogram(g, mv, c);
				}
			}
		}

		// rysuj opis
		rysujLegende(g);

		// if (v.size() == 1)
		{
			maxNumberStr = String.valueOf((float) maxNumber);
			// if (maxNumberStr.length()>8) maxNumberStr =
			// maxNumberStr.substring(0,8);
			minNumberStr = String.valueOf((float) minNumber);
			// if (minNumberStr.length()>8) minNumberStr =
			// minNumberStr.substring(0,8);
			maxValueStr = nf.format(maxValue);// String.valueOf((float)maxValue);
			// if (maxValueStr.length()>8) maxValueStr =
			// maxValueStr.substring(0,8);
			// minValueStr = String.valueOf((float)minValue);
			minValueStr = nf.format(minValue);
			// if (minValueStr.length()>8) minValueStr =
			// minValueStr.substring(0,8);
			g.setColor(Color.BLACK);
			g.drawString("" + maxNumberStr, xmax + 10, ymin); // OY(0)
			g.drawString("" + minNumberStr, xmax + 10, ymax); // OY(max)

			g.drawString("" + minValueStr, xmin, ymax + 20); // OX(0)
			g.drawString("" + maxValueStr, xmax - 20, ymax + 20); // OX(max)
			/*
			 * g.drawString(""+maxNumberStr,xmin-60,ymin+2);
			 * g.drawString(""+minNumberStr,xmin-60,ymax+2);
			 * g.drawString(""+minValueStr,xmin-12,ymax+14);
			 * g.drawString(""+maxValueStr,xmax-12,ymax+14);
			 */

			// } else { /*
			// * g.drawString(""+maxNumberStr,xmin-40,ymin-5);
			// * g.drawString(""+minNumberStr,xmin-40,ymax-5);
			// * g.drawString(""+minValueStr,xmin-10,ymax+4);
			// * g.drawString(""+maxValueStr,xmax-10,ymax+4);
			// */
		}
	}

	/**
	 * Generate image buffer containing chart
	 * @return
	 */
	private BufferedImage generateImage() {
		int width = getDrawPanel().getWidth();
		int height = getDrawPanel().getHeight();// - menuBar.getHeight();
		if (width > 0 && height > 0) {
			imageBuffer = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
			Graphics2D g = (Graphics2D) imageBuffer.getGraphics();
			calculateLegendWidth(g);
			g.setColor(getBackground());
			g.fillRect(0, 0, imageBuffer.getWidth(), imageBuffer.getHeight());
			generateView(imageBuffer.getGraphics());
			return imageBuffer;
		}
		return null;
	}

	/**
	 * Refresh chart
	 */
	public void refresh() {
		actualizeDesiredRange();

		for (int j = 0; j < curves.size(); j++) {
			Curve cur = curves.get(j);
			actualizeConstantsRange(cur.getConstants());
			actualizeValuesRange(cur.getVariable());
		}

		generateImage();
		repaint();
	}

	/**
	 * This method initializes jJMenuBar
	 * 
	 * @return javax.swing.JMenuBar
	 */
	private JMenuBar getDialogMenuBar() {
		if (menuBar == null) {
			menuBar = new JMenuBar();
			menuBar.add(getJMenuOptions());

			menuBar.add(getJMenuLegend());
			menuBar.setVisible(true);
		}
		return menuBar;
	}

	/**
	 * This method initializes jMenu
	 * 
	 * @return javax.swing.JMenu
	 */
	private JMenu getJMenuOptions() {
		if (optionsMenu == null) {
			optionsMenu = new JMenu();
			optionsMenu.setText(Language.getString("Options"));
			optionsMenu.add(getJMenuItemSave());
			optionsMenu.add(getJMenuItemClose());
		}
		return optionsMenu;
	}

	/**
	 * This method initializes jMenuItem
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItemSave() {
		if (saveMenuItem == null) {
			saveMenuItem = new JMenuItem();
			saveMenuItem.setText(Language.getString("Save chart"));
			saveMenuItem.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					String currDir = System.getProperty("user.dir");
					JFileChooser fc = new JFileChooser(currDir);
					fc.setDialogTitle(Language.getString("Save as..."));

					try {
						int returnVal = fc.showSaveDialog(Diagram.this);
						if (returnVal == JFileChooser.APPROVE_OPTION) {
							File file = fc.getSelectedFile();
							FileOutputStream stream = new FileOutputStream(file);
							BufferedImage imBuff = generateImage();
							repaint();
							ImageIO.write(imBuff, "png", stream);
						}
					} catch (Exception e1) {
						JOptionPane.showMessageDialog(null, Language.getString("Save file exception:\n") + e1.getLocalizedMessage());
					}
				}
			});
		}
		return saveMenuItem;
	}

	/**
	 * This method initializes jMenuItem
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItemClose() {
		if (closeMenuItem == null) {
			closeMenuItem = new JMenuItem();
			closeMenuItem.setText(Language.getString("Close"));
			closeMenuItem.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					Diagram.this.setVisible(false);
				}
			});
		}
		return closeMenuItem;
	}

	/**
	 * This method initializes jMenu
	 * 
	 * @return javax.swing.JMenu
	 */
	private JMenu getJMenuLegend() {
		if (legendMenu == null) {
			legendMenu = new JMenu();
			legendMenu.setText(Language.getString("Legend"));
		}
		return legendMenu;
	}

	/**
	 * This method initializes jContentPane
	 * 
	 * @return javax.swing.JPanel
	 */
	private JPanel getDrawPanel() {
		if (drawPanel == null) {
			BorderLayout borderLayout = new BorderLayout();
			borderLayout.setHgap(0);
			borderLayout.setVgap(0);
			drawPanel = new JDrawPanel();
			drawPanel.setLayout(borderLayout);
			drawPanel.setComponentOrientation(ComponentOrientation.UNKNOWN);
		}
		return drawPanel;
	}

}
