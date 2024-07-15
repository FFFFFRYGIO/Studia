package part2.events;

import part2.Manager;


public class PlaneLand extends SimEvent {
    public PlaneLand(String planeName, Manager mngr, double dt, int priority) {
        super(planeName, mngr, dt, priority);
    }

    public void stateChange() {
        System.out.println(planeName + ' ' + getClass().getName());
        new PlaneStart(planeName, mngr, 1 + rnd.poisson(2), priority / 2 * 3);
    }
}
