import java.util.*;
public class Main
{
	public static void main(String[] args) {
	    double R=6, r=1, a=8;
        int nRev=18;
        for(double t=0.0; t<(Math.PI*nRev); t+=0.01){
          double x = ((R+r)*Math.cos((r/R)*t) - a*Math.cos((1+r/R)*t))/10000.0+(-118.2853516);
          double y = ((R+r)*Math.sin((r/R)*t) - a*Math.sin((1+r/R)*t))/10000.0+(34.0205828);
          System.out.println(x+","+y+",0");
        }

	}
}