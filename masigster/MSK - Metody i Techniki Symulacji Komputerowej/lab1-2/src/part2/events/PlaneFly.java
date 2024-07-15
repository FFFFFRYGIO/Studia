package part2.events;

import part2.Manager;


public class PlaneFly extends SimEvent {
    public PlaneFly(String planeName, Manager mngr, double dt, int priority) {
        super(planeName, mngr, dt, priority);
    }

    public void stateChange() {
        System.out.println(planeName + ' ' + getClass().getName());
        new PlaneLand(planeName, mngr, 1 + rnd.poisson(4), priority * 2);
    }
}
