package part1;

import source.monitors.MonitoredVar;
import source.random.RNGenerator;


public class ShooterOne extends SimStep {
    public MonitoredVar state = new MonitoredVar();
    double lastChangeTime = 0.0;
    RNGenerator rnd = new RNGenerator();

    public ShooterOne(Manager mngr) {
        super(mngr);
        state.setValue(0.0, simTime());
    }

    public void stateChange() {
        if ((simTime() - lastChangeTime) > rnd.uniform(1, 3)) {
            double score = rnd.normal(15.0, 5.0);
            state.setValue(score, simTime());
            System.out.println(getClass().getName() + " scored: " + score);
        }
    }
}
