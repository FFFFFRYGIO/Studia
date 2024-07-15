package quasi_continuous_simulation;

import source.monitors.MonitoredVar;


public class EulerValue extends SimStep {
    public MonitoredVar state;
    private final double dt = getTimeStep();

    public EulerValue(Manager mngr, MonitoredVar state) {
        super(mngr);
        this.state = state;
    }

    @Override
    public void stateChange() {
        if (simTime() == 0.0) {
            state.setValue(1.0, simTime());
            return;
        }

        double ti = simTime() - dt;
        double ti1 = simTime();
        double xi = state.getValue();
        double xi1 = xi + dt * f(xi, ti);
        state.setValue(xi1, ti1);
    }
}
