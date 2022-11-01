package com.mily;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

public class modelToString {

    public static void main(String[] args) {
        String nazwisko = "Milewski";
        String nrAlbumu = "76823";
        BufferedReader reader;
        LinkedHashMap<String, Integer> freq = new LinkedHashMap<>();
        String[] temp;
        try{
            reader = new BufferedReader(new FileReader(new File("").getAbsolutePath()+ "/input.txt"));
            String line = reader.readLine();
            while (line != null){
                line=line.replaceAll(" ","");
                temp=line.split("-");
                if(temp[0].contains("NAZ")){
                    temp[0]=temp[0].substring(temp[0].length()-1);
                    temp[0]=nazwisko.substring(Integer.parseInt(temp[0])-1, Integer.parseInt(temp[0]));
                }
                if(temp[1].contains("NR")){
                    temp[1]=temp[1].substring(temp[1].length()-1);
                    temp[1]=nrAlbumu.substring(Integer.parseInt(temp[1])-1, Integer.parseInt(temp[1]));
                }
                freq.put(temp[0], Integer.valueOf(temp[1]));
                System.out.println(temp[0]+"-"+temp[1]);
                line=reader.readLine();
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(freq);
        while (!freq.isEmpty()){
            Map.Entry<String, Integer> entry = freq.entrySet().iterator().next();
            for (int i=0; i<entry.getValue(); i++){
                System.out.print(entry.getKey());
            }
            freq.remove(entry.getKey());
        }
    }
}
