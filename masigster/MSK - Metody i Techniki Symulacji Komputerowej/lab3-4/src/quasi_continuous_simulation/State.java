package quasi_continuous_simulation;

import source.monitors.Change;
import source.monitors.ChangesList;
import source.monitors.MonitoredVar;

public class State {
    public MonitoredVar rValue = new MonitoredVar();
    public MonitoredVar eValue = new MonitoredVar();
    public MonitoredVar eDiff = new MonitoredVar();
    public MonitoredVar rkValue = new MonitoredVar();
    public MonitoredVar rDiff = new MonitoredVar();

    public double dr_e() {
        return rValue.getValue() - eValue.getValue();
    }

    public double dr_rk() {
        return rValue.getValue() - rkValue.getValue();
    }

    public MonitoredVar get_dr_monitored_var(MonitoredVar xValue) {
        MonitoredVar xMonitored = new MonitoredVar();
        ChangesList rChanges = this.rValue.getChanges();
        ChangesList xChanges = xValue.getChanges();

        for (int i = 0; i < rChanges.size(); i++) {
            Change rChange = rChanges.get(i);
            Change xChange = xChanges.get(i);
            if (rChange.getTime() != xChange.getTime()) {
                throw new RuntimeException("Times mismatch");
            }
            xMonitored.setValue(rChange.getValue() - xChange.getValue(), rChange.getTime());
        }
        return xMonitored;
    }
}
