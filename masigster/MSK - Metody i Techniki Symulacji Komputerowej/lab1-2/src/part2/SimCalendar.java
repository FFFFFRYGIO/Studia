package part2;

import part2.events.SimEvent;

import java.util.PriorityQueue;


public class SimCalendar extends PriorityQueue<SimEvent> {
    public SimCalendar() {
        super((event1, event2) -> {
            if (event1.runTime != event2.runTime) {
                return Double.compare(event1.runTime, event2.runTime);
            } else {
                return -Integer.compare(event1.priority, event2.priority);
            }
        });
    }
}
