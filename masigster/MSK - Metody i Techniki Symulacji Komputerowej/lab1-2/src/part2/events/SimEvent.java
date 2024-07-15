package part2.events;

import part2.Manager;
import source.monitors.MonitoredVar;
import source.random.RNGenerator;


public abstract class SimEvent extends SimStep {
    public MonitoredVar state = new MonitoredVar();
    RNGenerator rnd = new RNGenerator();
    public String planeName;
    public double runTime;
    public Manager mngr;
    public double dt;
    public int priority;

    public SimEvent(String planeName, Manager mngr, double dt, int priority) {
        super(mngr);
        this.mngr = mngr;
        this.planeName = planeName;
        this.dt = dt;
        this.priority = priority;
        this.runTime = simTime() + dt;
        mngr.registerEvent(this);
    }

    public double getRunTime() {
        return runTime;
    }

//    public void terminate() {
//
//    }
//
//    public abstract void onTermination();

}
