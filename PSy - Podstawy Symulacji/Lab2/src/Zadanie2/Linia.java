package Zadanie2;

public class Linia {
	
	public double To;
	public double tk = 0;
	

	Linia(double To){
		
		this.To = To;
	}
	
	void Progress(double simTime) {
		
		tk = To + simTime;
	}
	
}