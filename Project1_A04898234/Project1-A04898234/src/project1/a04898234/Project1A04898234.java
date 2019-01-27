
package project1.a04898234;

import java.util.*;

class Project1A04898234{
    public static void main(String args[])
    {
        System.out.print("\033[H\033[2J");  
        System.out.flush();  

        BackwardChaining bc = new BackwardChaining();
        ForwardChaining fc = new ForwardChaining();
        //This function will call the BC functionality 
        System.out.println("-------------------------------------------------------");
        System.out.println("Welcome to Career Advising Support Service");
        System.out.println("-------------------------------------------------------");
        System.out.println();
        System.out.println("This service is very easy to use.....");
        System.out.println("You need to answer to a couple of questions and we will advise you based on your answers");
        System.out.println();
        Scanner input =new Scanner(System.in);
        try
        {
            
            System.out.println("Are you ready ? [Yes/No] : ");
            String str = input.nextLine();
            System.out.println();
            if(str.equalsIgnoreCase("Yes"))
            {
                //This function generate Knowledge base
                bc.generateDisplayBCKnowledgeBase();
                //This functional Generates the Clause-variable List from Knowledge base and displays variable, conclusion variable and clause variable list
                bc.generateClauseVariableList();
                //Displays the final output for the user based on its inferences.
                String profession = bc.BC_Functionality();
                //This function generate Knowledge base from the Input File and Displays the same to the user
                fc.generate_display_KnowledgeBase();
                //This functional Generates the Clause-variable List from Knowledge base and displays the same
                fc.generate_ClauseVariableList();
                //This functionality involves the actual FC inference Engine's work.
                if(profession!=null)
                    {
                        fc.FC_functionality(profession);
                        //Displays the final output for the user based on its inferences.
                        fc.finalInput();
                        //Display the KnowledgeBase, ClauseVariable and Variable List if needed 
                        System.out.println("Before Quitting Do you wish to see the Knowledge base, clause variable list and Variable List generated/used during BC and FC [Yes/No]:");
                        String ans = input.next();
                        System.out.println();
                        if(ans.equalsIgnoreCase("Yes"))
                        {
                            bc.printVariableList();
                            System.out.println("**************************************************************************");
                            fc.display_KnowledgeBase();
                            fc.display_ClauseVariableList();
                            fc.displayVariableList();
                        }
                    }
                System.out.println();
                System.out.println("THANK YOU !!");
                System.out.println();
            }
            else 
                System.out.println("Looks like you are not ready. U can re-execute when ready !! Thank You !!!");

        }catch(Exception e){
            System.out.println("Caught Exception in Main" + e);
        }
    }

}


