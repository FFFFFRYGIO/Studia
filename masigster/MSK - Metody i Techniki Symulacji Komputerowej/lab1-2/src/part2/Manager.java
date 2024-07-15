package part2;

import part1.SimStep;
import part2.events.PlaneFly;
import part2.events.PlaneLand;
import part2.events.PlaneStart;
import part2.events.SimEvent;
import source.monitors.MonitoredVar;

import java.util.ArrayList;

public class Manager {
	private double startSimTime = 0.0;
	private double stopSimTime = Double.MAX_VALUE;
	private double currentSimTime = startSimTime;
	private final double timeStep = 1.0;
	private static Manager simMngr; // Singleton
	private boolean simulationStarted = false;
	public final SimCalendar simCalendar = new SimCalendar();
	public static MonitoredVar planeStartsMonitor = new MonitoredVar();
	public static MonitoredVar planeFliesMonitor = new MonitoredVar();
	public static MonitoredVar planeLandsMonitor = new MonitoredVar();
	public int planeStartsCounter = 0;
	public int planeFliesCounter = 0;
	public int planeLandsCounter = 0;

	public static Manager getInstance(double startSimTime) {
		if (simMngr == null) {
			simMngr = new Manager(startSimTime);
		}
		return simMngr;
	}
	
	public Manager(double startSimTime) {
		if (startSimTime>0.0)
			this.startSimTime = startSimTime;
		planeStartsMonitor.setValue(planeStartsCounter, simTime());
		planeFliesMonitor.setValue(planeFliesCounter, simTime());
		planeLandsMonitor.setValue(planeLandsCounter, simTime());
	}
	
	public final double simTime() {
		return currentSimTime;
	}
	
	public final void stopSimulation() {
		simulationStarted = false;
	}

	public final void startSimulation() {
		simulationStarted = true;
		// DO WYKONANIA NA LABORATORIUM
		while (simulationStarted){
			SimEvent event = nextEvent();
			if (event!=null) {
				if (event.runTime > stopSimTime) {
					stopSimulation();
				} else {
					unregisterEvent();
					currentSimTime = event.runTime;
					event.stateChange();
					updateEventsMonitors(event);
				}
			}
		}
	}
	
	public void setEndSimTime(double endSimTime) {
		this.stopSimTime = endSimTime;
	}

	public void registerEvent(SimEvent event) {
		simCalendar.add(event);
	}
	public void unregisterEvent() {
		simCalendar.poll();
	}

	public SimEvent nextEvent() {
		return simCalendar.peek();
	}

	public void updateEventsMonitors(SimEvent event) {
		if (event instanceof PlaneStart) {
			planeStartsCounter++;
			planeStartsMonitor.setValue(planeStartsCounter, simTime());
		} else if (event instanceof PlaneFly) {
			planeFliesCounter++;
			planeFliesMonitor.setValue(planeFliesCounter, simTime());
		} else if (event instanceof PlaneLand) {
			planeLandsCounter++;
			planeLandsMonitor.setValue(planeLandsCounter, simTime());
		}
	}
}
