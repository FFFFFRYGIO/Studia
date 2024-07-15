package part2.events;

import part2.Manager;


public class PlaneStart extends SimEvent {
    public PlaneStart(String planeName, Manager mngr, double dt, int priority) {
        super(planeName, mngr, dt, priority);
    }

    public void stateChange() {
        System.out.println(planeName + ' ' + getClass().getName());
        new PlaneFly(planeName, mngr, 1 + rnd.poisson(9), priority / 3);
    }
}
