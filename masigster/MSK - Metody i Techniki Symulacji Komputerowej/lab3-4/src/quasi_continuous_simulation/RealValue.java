package quasi_continuous_simulation;

import source.monitors.MonitoredVar;


public class RealValue extends SimStep {
    public MonitoredVar state;

    public RealValue(Manager mngr, MonitoredVar state) {
        super(mngr);
        this.state = state;
    }

    @Override
    public void stateChange() {
        double ti = simTime();
        double xi = 2 + 2 * ti + ti * ti - Math.pow(Math.E, ti);
        state.setValue(xi, ti);
    }
}
