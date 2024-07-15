package part1;

import source.monitors.MonitoredVar;
import source.random.RNGenerator;

public class ShooterThree extends SimStep {
    public MonitoredVar state = new MonitoredVar();
    double lastChangeTime = 0.0;
    RNGenerator rnd = new RNGenerator();

    public ShooterThree(Manager mngr) {
        super(mngr);
        state.setValue(0.0, simTime());
    }

    public void stateChange() {
        if ((simTime() - lastChangeTime) > rnd.uniform(1, 3)) {
            double score = rnd.normal(20.0, 10.0);
            state.setValue(score, simTime());
            System.out.println(getClass().getName() + " scored: " + score);
        }
    }
}
