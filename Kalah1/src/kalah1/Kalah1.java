/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kalah1;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

/**
 *
 * @author meghana
 */
public class Kalah1 {

    public static void main(String[] args) throws IOException{
        FileInputStream fileInputStream=null;
        InputStreamReader inputStreamReader=null;
        BufferedReader bufferedReader=null;
        
        try{
            fileInputStream=new FileInputStream("input.txt");
            inputStreamReader=new InputStreamReader(fileInputStream);
            bufferedReader=new BufferedReader(inputStreamReader);
            Scanner input =new Scanner(System.in);
            
            //Read input file
            int cuttingDepth=Integer.parseInt(bufferedReader.readLine().trim());
            
            String[] boardPlayer2=bufferedReader.readLine().trim().split(" ");
            String[] boardPlayer1=bufferedReader.readLine().trim().split(" ");
            
            int boardSize=boardPlayer2.length;
            int[] board2=new int[boardSize];
            int[] board1=new int[boardSize];
            
            for(int i=0;i<boardSize;i++){
                board2[i]=Integer.parseInt(boardPlayer2[i].trim());
                board1[i]=Integer.parseInt(boardPlayer1[i].trim());
            }
            
            int kalah2=Integer.parseInt(bufferedReader.readLine().trim());
            int kalah1=Integer.parseInt(bufferedReader.readLine().trim());
            
            Helper util=new Helper();
            KalahBoard next=null;
            Algorithms.Minimax mm;
            Algorithms.AlphaBeta ab;
            //Call Minimax or AlphaBeta method based on value specified in input
       
            System.out.println("-----------------------------------------");
            System.out.println(" Welcome to KALAH Game ");
            System.out.println("-----------------------------------------");
            System.out.println();
            System.out.println("Algorithms");
            System.out.println("-----------");
            System.out.println("1. Minimax");
            System.out.println("2. AlphaBetaPruning");
            System.out.println("Choose algorithm for your 1st player : ");
            int player1algo = Integer.parseInt(input.nextLine().trim());
            System.out.println("Choose algorithm for your 2nd player :");
            int player2algo = Integer.parseInt(input.nextLine().trim());
            
            System.out.println();
            System.out.println("Evaluation Functions");
            System.out.println("--------------------");
            System.out.println("1. (#Stones in 1st player Kalah + #Stones in 1st player pits) - (#Stones in 2nd player Kalah + #Stones in 2nd player pits) ");
            System.out.println("2. (number of my emptypits) - (number of opponent empty pits)  ");
            System.out.println("Standard Evaluation-  (#Stones in 1st player Kalah -  #Stones in 2nd player Kalah) ");
            System.out.println("Choose evaluation function for 1st player : ");
            int player1eval = Integer.parseInt(input.nextLine().trim());
            System.out.println("Choose evaluation function for 2nd player : ");
            int player2eval = Integer.parseInt(input.nextLine().trim());
            
            System.out.println();
            System.out.println("1. Player #1");
            System.out.println("2. Player #2");
            System.out.println("Who goes first? : ");
            int currentplayer = Integer.parseInt(input.nextLine().trim());
            
               // untill game reaches end
            do{
                KalahBoard g=new KalahBoard(currentplayer, board2, board1, kalah2, kalah1);
                //If player1 starts game
                if(currentplayer == 1)
                {
                    //selected algo is minimax
                    if(player1algo == 1)
                    {
                        mm=new Algorithms.Minimax(cuttingDepth);
                        next=mm.minimax(g, player1eval);

                        board1=next.getPlayer1_Board();
                        board2=next.getPlayer2_Board();
                        kalah1=next.getPlayer1_Kalah();
                        kalah2=next.getPlayer2_Kalah();

                        currentplayer=2;
                    }
                    //selected algo alphabeta pruning
                    else
                    {
                        ab=new Algorithms.AlphaBeta(cuttingDepth);
                        next=ab.alphabeta(g, player1eval);

                        board1=next.getPlayer1_Board();
                        board2=next.getPlayer2_Board();
                        kalah1=next.getPlayer1_Kalah();
                        kalah2=next.getPlayer2_Kalah();
                        
                        currentplayer=2;
                    }
                    
                    
                }
                //If player2 starts the game
                else
                {
                   if(player2algo == 1)
                    {
                        mm=new Algorithms.Minimax(cuttingDepth);
                        next=mm.minimax(g, player2eval);

                        board1=next.getPlayer1_Board();
                        board2=next.getPlayer2_Board();
                        kalah1=next.getPlayer1_Kalah();
                        kalah2=next.getPlayer2_Kalah();

                        currentplayer=1;
                    }
                    else
                    {
                        ab=new Algorithms.AlphaBeta(cuttingDepth);
                        next=ab.alphabeta(g, player2eval);

                        board1=next.getPlayer1_Board();
                        board2=next.getPlayer2_Board();
                        kalah1=next.getPlayer1_Kalah();
                        kalah2=next.getPlayer2_Kalah();
                        
                        currentplayer=1;
                    }
                }
            }while(!util.GameOver(next));
            
            if(next.getPlayer2_Kalah()>next.getPlayer1_Kalah())
                System.out.println("PLAYER - 2 WON THE GAME");
            else if(next.getPlayer2_Kalah()< next.getPlayer1_Kalah())
                System.out.println("PLAYER - 1 WON THE GAME");
            else 
                System.out.println("Its a Tie");

            System.out.println("\nStatistics");
            System.out.println("-------------------------------------------------");
            System.out.println("PLAYER-1");
            System.out.println("No of Nodes Expanded by Player 1 is "+ Statistics.ExpandedNodes1);
            System.out.println("No of Nodes Generated by Player 1 is "+ Statistics.noofNodes1);
            System.out.println("Memory Used : " + Statistics.noofNodes1*4 + "Bytes");
            System.out.println("-------------------------------------------------");
            System.out.println("PLAYER-2");
            System.out.println("No of Nodes Expanded by Player 2 is "+ Statistics.ExpandedNodes2);
            System.out.println("No of Nodes Generated by Player 2 is "+ Statistics.noofNodes2);
            System.out.println("Memory Used : " + Statistics.noofNodes2*4 + "Bytes");
        }
        catch(Exception ex){
            System.out.println("Exception occured : " + ex);
            ex.printStackTrace();
        }
        finally{      
            bufferedReader.close();
            inputStreamReader.close();
            fileInputStream.close();
        }
    }
}
