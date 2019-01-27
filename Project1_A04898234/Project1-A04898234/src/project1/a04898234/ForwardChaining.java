package project1.a04898234;
import java.util.*;
import java.nio.file.Files;
import java.nio.file.Paths;

public class ForwardChaining {
    //Creating an LinkedHashMap Object for the Storage of If/else condition part of knowledge base
    LinkedHashMap<String, String> KnBaseIFMap = new LinkedHashMap<>(); 
    
    //Creating another LinkedHashMap Object to store the rule no and the IF-THEN Rules.
    LinkedHashMap<Integer, LinkedHashMap<String, String>> KnBase = new LinkedHashMap<>(); 

    //Creating another LinkedHashMap Object to store Clause Variable list
    LinkedHashMap<Integer, String> ClauseVarList=new LinkedHashMap<>(); 

    //Conlusion variable queue
    Queue<String> ConclVarListQ = new LinkedList<>();

    //Variable list
    LinkedHashMap<String, String> VarList=new LinkedHashMap<>();

    //A list created to store the subInterest for further processing
    List<String> l= new ArrayList<>();

    public void generate_display_KnowledgeBase()
    {
        //The Knowledge Base is generated from the input file and stored in the LinkedHashMap object
        try{
        Files.lines(Paths.get("input.txt")).forEach(
        KB -> {
            String[] KBSplit = KB.split(" THEN ");
            KnBaseIFMap.put(KBSplit[0], KBSplit[1]);
            l.add(KBSplit[0].split("SubInterest=")[1].split(" ")[0]);
           });
        }catch(Exception e){
        System.out.println("Caught Exception in generate_display_KnowledgeBase function: " + e);
        }
 
         //Loading up the knowledge base in format of "10 IF a=b THEN b=c; 20 IF a=c THEN c=d etc.,"
         int KnBaseindex=10;
         for (Map.Entry<String, String> entry : KnBaseIFMap.entrySet())
         {
             //Displaying the rules in the form of IF THEN for the convience of this project.
             //System.out.println(KnBaseindex + " IF " + entry.getKey() + " THEN " + entry.getValue());
             LinkedHashMap temp=new LinkedHashMap<>();
             temp.put(entry.getKey(), entry.getValue());    
             //This object stores the calculated rule no and the corresponding object that contains IF THEN rules   
             KnBase.put(KnBaseindex, temp);
             KnBaseindex=KnBaseindex+10;
         }
    }

    public void generate_ClauseVariableList()
    {
        //Loading up the Clause Variable list in format of "1 var1; 2; 3 var2l 4; 5 var3 etc.," leaving two places to b/w each variable
        int index=1;
        for(Map<String, String> entry : KnBase.values())//Outer loop to take value part of Hash object knBaseIFMAP
        {
            for(Map.Entry<String, String> MapEntry : entry.entrySet())//Inner loop to take the Key part of the hash object knBaseIFMap 
            {
                String[] s = MapEntry.getKey().toString().split("&");//Splits the String based on & 
                int k=0;
                for(String s1:s)
                {
                    ClauseVarList.put(index, s1.split("=")[0]); //Re-splits the above string again based on =
                    index=index+1;
                    k++;
                }
                if(k==2) index=index+2; //If there are 2 clauses in IF part, this is executed.
                if(k==3) index=index+1; //If there are 3 clauses in If part, this is executed.
            }
        }
        //Displays the ClauseVariable List for FC
        //display_ClauseVariableList();
    }

    public void FC_functionality(String initialInput)
    {
        String subInterest, subIn="No";
        System.out.println();
        System.out.println("--------------------Your FC Process Starts---------------------------");
        System.out.println();
        System.out.println("From BC Process - Your advised Profession is : " + initialInput);
        
        ConclVarListQ.add("Profession"); //Raw input from user/output of the Backwards Chaining inference
        //displayConclusionVariableQueue();
                    
        VarList.put("Profession",initialInput); //Instantiating for the first time
        //displayVariableList();
        
 
        while(ConclVarListQ.isEmpty() != true)
        {
            String tempstr=ConclVarListQ.peek();//Takes the first value of the ConclusionVariable queue
            int RuleNo;
           for(Map.Entry<Integer, String> entry : ClauseVarList.entrySet())
            {
                if(entry.getValue().trim().equals(tempstr.trim()))
                {
                    RuleNo=((entry.getKey()/4)+1)*10; //the logic to get the RuleNo
                    //System.out.println("Checking Rule No : " + RuleNo);
        
                    //Below lines has the logic that iterates over clause variable list and get the corresponding conclusion variable values from the Knowledge base and instantiate them in Variable list)
                    LinkedHashMap<String, String> tempKnBaseIFMap = KnBase.get(RuleNo);
                    for(Map.Entry<String, String> tempKBMap : tempKnBaseIFMap.entrySet())
                    {
                        String[] s = tempKBMap.getKey().split("&");
                        String[] sub = s[0].split("=");
                        
                        if(sub[0].trim().equals(tempstr) && sub[1].trim().equals(VarList.get(tempstr))) //If variable in rule matches the one present on top of the queue
                        {
                            if(VarList.containsKey(s[1].split("=")[0]))
                                {//Do Nothing 
                                }
                            else if(VarList.containsKey(s[1].split("=")[0]) == false)
                            {
                                Scanner in = new Scanner(System.in);
                                List<String> listTemp = new ArrayList<>();;
                                //Implemented different cases to handle different sub-Profession
                                switch(VarList.get(sub[0].trim()))
                                {
			//Takes only a part of the list that belong to that Profession

                                    case "Engineer":    listTemp = l.subList(0, 5);
                                                        	break;
                                    case "HealthCare" : listTemp = l.subList(5, 10);
                                                        break;
                                    case "Doctor" :     listTemp = l.subList(10, 15);
                                                        break;
                                    case "Botanist" :   listTemp = l.subList(16, 19);
                                                        break;
                                    case "Zoologist" :  listTemp = l.subList(21, 26);
                                                        break;
                                    case "Management" : listTemp = l.subList(26, 32);
                                                        break;
                                    case "Business" :   listTemp = l.subList(32, 38);
                                                        break;
                                    case "Palentologist" :  listTemp = l.subList(38, 43);
                                                            break;
                                    case "Anthropologist" : listTemp = l.subList(43, 48);
                                                            break;
                                    case "Fine_Artist" :    listTemp = l.subList(48, 53);
                                                            break;
                                    case "Communication_Specialist":    listTemp = l.subList(53, 58);
                                                                        break;
                                    case "Scientist":   listTemp = l.subList(58,63);
                                                                    break;
                                    default : System.out.println("Sorry !! We dont have an specialised area constructed on your advised Profession just yet.");
                                }
                                try
                                    {
                                        //Based on the above sub-list, it iterates over the list to ask the user back for appropriate query
                                        Iterator itr = listTemp.iterator();
                                        do
                                        {
                                            subInterest=(String)itr.next();
                                            System.out.println("Do you like " + subInterest + "? [Yes/No] :");
                                            subIn = in.next();
                                        }while(subIn.equalsIgnoreCase("No") && itr.hasNext());
                                        if(subIn.equalsIgnoreCase("Yes"))
                                        {
                                            //If user enters yes, then they are added to Variable List and Conclusion Variable Queue.
                                            VarList.put(s[1].split("=")[0], subInterest);
                                            ConclVarListQ.add(s[1].split("=")[0]);
                                            //Below are extra code of lines for certain rules that has more than 2 clauses
                                            if(VarList.get(sub[0].trim()).equalsIgnoreCase("Botanist"))
                                            {
                                                if(subInterest.equalsIgnoreCase("Grow_Plants"))
                                                {
                                                    System.out.println("Do you like Growing Small or Large Scale? [Small/Large]: ");
                                                    String tempInput=in.next();
                                                    if(tempInput.equalsIgnoreCase("Small"))
                                                    {
                                                        VarList.put(s[2].split("=")[0],"Small");
                                                        ConclVarListQ.add(s[2].split("=")[0]);
                                                    }
                                                    else if(tempInput.equalsIgnoreCase("Large"))
                                                    {
                                                        VarList.put(s[2].split("=")[0],"Large");
                                                        ConclVarListQ.add(s[2].split("=")[0]);
                                                    }
                                                }
                                                if(subInterest.equalsIgnoreCase("Study_Plants"))
                                                {
                                                    System.out.println("Do you like Studying Internal or External Strcuture? [Internal/External]: ");
                                                    String tempInput=in.next();
                                                    if(tempInput.equalsIgnoreCase("External"))
                                                    {
                                                        VarList.put(s[2].split("=")[0],"External_Study");
                                                        ConclVarListQ.add(s[2].split("=")[0]);
                                                    }
                                                    else if(tempInput.equalsIgnoreCase("Internal"))
                                                    {
                                                        VarList.put(s[2].split("=")[0],"Internal_Study");
                                                        ConclVarListQ.add(s[2].split("=")[0]);
                                                    }
                                                }
                                            }
                                        }
                                        else 
                                            System.out.println("I am sorry. We dont have an specialised area constructed on your Interests just yet.");   
                                                             
                                    }catch(Exception e){
                                            System.out.println("Caught Exception Inside : " +e);
                                    }
                            }
                        }
                    }

                    //displayConclusionVariableQueue();
                    //displayVariableList();
                }
            }
            //Removing the element from front queue once the iteration of knwoledge base is compelete
            ConclVarListQ.remove();
            //System.out.println("After Removing from Queue");
            //displayConclusionVariableQueue();
        }
    }

    public void displayConclusionVariableQueue()
    {
        //This function displays the Concusion Variable Queue to the user
        System.out.println("------------------------------");
        System.out.println("----FC Conclusion Var queue----");
        System.out.println("------------------------------");
        ConclVarListQ.forEach(i -> System.out.println(i));
        System.out.println();
    }
    
    public void displayVariableList()
    {
        //This function displays the Varliable List to the user
        System.out.println("------------------------------");
        System.out.println("--------FC Variable List------");
        System.out.println("------------------------------");
        VarList.forEach((i,j) -> System.out.println(i+"="+j));
        System.out.println();
    }

    public void display_ClauseVariableList()
    {
        //This function displays the Clause-Variable List to th user
        System.out.println("---------------------------------");
        System.out.println("-----FC Clause variable List-----");
        System.out.println("---------------------------------");
        ClauseVarList.forEach((i,j) -> System.out.println(i+" "+j)); //Prints the ClauseVariable List obtained above
        System.out.println();
    }

    public void display_KnowledgeBase()
    {
        //This displays Knowledge base to the user
        System.out.println("------------------------------");
        System.out.println("-------FC Knowledge Base------");
        System.out.println("------------------------------");
        KnBase.forEach((i,j) -> System.out.println(i+" "+j));
    }
    
    public void finalInput()
    {
        //This function displays the final output to the user. It compares the Variables in the Variable List object with the rules stores in KnBaseIFMap object and finds the appropriate conclusion
        System.out.println("======End of the Inference=======");
        System.out.println();
        System.out.println();
        System.out.println("FC inference says : ");
        String[] value = new String[3];
        int k=0;
        //Prints the value from the VarList first
        for(Map.Entry<String, String> entry : VarList.entrySet()) {
            System.out.println(entry.getKey() + " is " + entry.getValue());
            value[k]=entry.getValue().trim();
            k++;
        };
        final int c=k;
        //Compares the values in VarList with the Knowledge Storage to give final output.
        KnBaseIFMap.forEach((m,n) -> 
            {
                String[] s = m.split("&");
                String[] t = n.split("=");
                if(c == 2)
                {
                    if(s[0].split("=")[1].trim().equals(value[0]) && s[1].split("=")[1].trim().equals(value[1]))
                    {
                        System.out.println("Hence Your Advised Specialised Area is: " + t[1]);
                        System.out.println();
                    }
                }
                else if(c == 3)
                {
                    if(s[0].split("=")[1].trim().equals(value[0]) && s[1].split("=")[1].trim().equals(value[1]))
                    {
                        if((s[2].split("=")[1].trim().equals(value[2])))
                        {
                            System.out.println("Hence Your Advised Specialised Area is: " + t[1]);
                            System.out.println();
                        }
                    }
                }
            });
    }
}



