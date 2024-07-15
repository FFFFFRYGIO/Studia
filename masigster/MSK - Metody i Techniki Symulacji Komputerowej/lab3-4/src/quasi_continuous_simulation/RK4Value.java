package quasi_continuous_simulation;

import source.monitors.MonitoredVar;


public class RK4Value extends SimStep {
    public MonitoredVar state;
    private final double dt = getTimeStep();
    private double xi = 1.0;

    public RK4Value(Manager mngr, MonitoredVar state) {
        super(mngr);
        this.state = state;
    }

    @Override
    public void stateChange() {
        double ti = simTime();
        state.setValue(xi, ti);
        double k1 = f(xi, ti);
        double k2 = f(xi + k1 * dt / 2, ti + dt / 2);
        double k3 = f(xi + k2 * dt / 2, ti + dt / 2);
        double k4 = f(xi + k3 * dt, ti + dt);
        xi += (dt / 6) * (k1 + 2 * k2 + 2 * k3 + k4);
    }
}
