
package project1.a04898234;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;

class BackwardChaining
{
    public List<String> KnBaseIFMap = new ArrayList<>();
    //If/else condition part of knowledge base
    
    public LinkedHashMap<Integer, String> KnBase = new LinkedHashMap<>();
    //Knowledge base
    
    public LinkedHashMap<Integer, String> ClauseVarList=new LinkedHashMap<>();
    //Clause Variable list
    
    public List<String> ConclVarList=new ArrayList<>();
    //Conclusion Variable list
    
    public LinkedHashMap<String, String> VarList=new LinkedHashMap<>(); 
    //Variable list
    
    public Stack<String> ConclusionStack = new Stack<>(); 
    //Conclusion Stack, holds the latest conclusion
    
    String profession= null;
    
    
public void generateDisplayBCKnowledgeBase()
    {
       //Loading up the if/else condition part of knowledge base
        KnBaseIFMap.add("Interest=Yes AND Technology=Yes THEN Profession=Engineer");
        KnBaseIFMap.add("Science=Yes AND HealthCare=Yes THEN Profession=HealthCare");
        KnBaseIFMap.add("Science=Yes AND HealthCare=No AND HumanAnotomy=Yes THEN Profession=Doctor");
        KnBaseIFMap.add("Science=Yes AND HealthCare=No AND HumanAnotomy=No AND Plants=Yes THEN Profession=Botanist");
        KnBaseIFMap.add("Science=Yes AND HealthCare=No AND HumanAnotomy=No AND Plants=No AND Animals=Yes THEN Profession=Zoologist");
        KnBaseIFMap.add("Maths=Yes AND Shares=Yes  THEN Profession=Business");
        KnBaseIFMap.add("Maths=Yes AND Shares=No AND Logical=Yes  THEN Profession=Scientist");
        KnBaseIFMap.add("Maths=Yes AND Shares=No AND Logical=No AND Management=Yes  THEN Profession=Manager");
        KnBaseIFMap.add("History=Yes AND culture_history=Yes  THEN Profession=Anthropologist");
        KnBaseIFMap.add("History=Yes AND culture_history=No AND Fossil=Yes  THEN Profession=Palentologist");
        KnBaseIFMap.add(" Arts=Yes AND Performances=Yes  THEN Profession=Fine_Artist");
        KnBaseIFMap.add("Arts=Yes AND Performances=No AND Language=Yes  THEN Profession=Communication_Specialist");

        //Loading up the knowledge base in format of "10 IF a=b THEN b=c; 20 IF a=c THEN c=d etc.,"
        int KnBaseindex=10;
        for (String entry : KnBaseIFMap)
        {       
            KnBase.put(KnBaseindex, entry);
            KnBaseindex=KnBaseindex+10;
        }

         
    }
    public void generateClauseVariableList()
    {
        //Loading up the Clause Variable list in format of "1 var1; 2; 3 var2l 4; 5 var3 etc.," leaving six places  b/w each rule
        int index=1;
        for(String entry : KnBase.values())
        {
                if(entry.split("AND").length > 0)
                {
                    int HashIndex=0;
                    for(int i=0;i<entry.split("AND").length;i++)
                    {
                        ClauseVarList.put(index, entry.split("AND")[i].split("=")[0].trim());
                        index++;
                        HashIndex++;
                    }
                    index=index+(6-HashIndex);
                }
        }

        //Loading up the conclusion varibale list <Rule No> <Conclusion> ex: 30 Profession from Knowledge base
        for(Integer entry : KnBase.keySet())
        {
            ConclVarList.add(entry+"="+KnBase.get(entry).split("THEN")[1].trim().split("=")[0].trim());
        }

        List<String> tempList=ConclVarList;
        Collections.reverse(tempList); //Since stack is FIFO, reversing a temp list and feeding the stack

        for(String tempstr : tempList)
        {
            if(tempstr.split("=")[1].trim().equals("Profession"))
            {
                ConclusionStack.add(tempstr.split("=")[0].trim());
            }
        }
       
    }
    
    public void printVariableList()
    {
        System.out.println("----------------");
        System.out.println("Knowledge Base");
        System.out.println("----------------");
        KnBase.forEach((i,j) -> System.out.println(i+" "+j)); 
        
        System.out.println("--------------------");
        System.out.println("Clause variable List");
        System.out.println("--------------------");
        ClauseVarList.forEach((i,j) -> System.out.println(i+" "+j));
        
        System.out.println("--------------------");
        System.out.println("Conclusion variable List");
        System.out.println("--------------------");     
        ConclVarList.forEach((i) -> System.out.println(i));
        
        System.out.println("--------------------");
        System.out.println("Conclusion variable Stack");
        System.out.println("--------------------");
        ConclusionStack.forEach((i) -> System.out.println(i));
    }
    
    public String BC_Functionality()
    {
        Scanner input=new Scanner(System.in);
        VarList.put("Interest","Yes"); //Instantiating for the first time

        // 1. Picks the top element from the stack, finds out the clause variable by applying hash to Rule number
        // 2. iterates over all the clause variables and instantiate the variable table by asking user if already not present
        // 3. once every clause variable instantiated, executes the IF/THEN to provide the final answer
        while(ConclusionStack.empty() != true)
        {
            String Rule=ConclusionStack.peek();
            int Clause=(((Integer.parseInt(Rule)/10)-1)*6)+1; //hash to find the clause from Rule
            int IFClauseNo=0;

            //Setting up the VarList table
            for(int i=0; i<6; i++)
            {
                
                if(ClauseVarList.get(Clause) != null ) //checking if caluse var is not null
                {
                    IFClauseNo++;
                    if(VarList.get(ClauseVarList.get(Clause)) == null ) //ask user if the var list is not instatiated for this clause
                    {
                        System.out.println("Are you interested in "+ClauseVarList.get(Clause)+ "?[Yes/No]: ");
                        String tempChoice=input.next(); //user input for choice of interest
                        //instantiate the var list for this clause
                        VarList.put(ClauseVarList.get(Clause), tempChoice); 
                    }

                     if(i==0 && VarList.get(ClauseVarList.get(Clause)).equalsIgnoreCase("No"))
                    {
                        break;
                    }
                }
                Clause++;
            }

            int AllIF=0;
            for(int i=0; i<IFClauseNo;i++) //execute if/then part for this rule
            {
                if(VarList.get(KnBase.get(Integer.parseInt(Rule)).split("THEN")[0].trim().split("AND")[i].trim().split("=")[0]).equalsIgnoreCase(KnBase.get(Integer.parseInt(Rule)).split("THEN")[0].trim().split("AND")[i].trim().split("=")[1]))
                {
                  AllIF++;
                }
            }

            if(AllIF == IFClauseNo) //if all clause variables satisfies the given condition
            {
                profession = KnBase.get(Integer.parseInt(Rule)).split("THEN")[1].trim().split("=")[1];
                System.out.println("Ur prof is: "+ profession); //hurray...!
                break;
            }
            else
            {
                ConclusionStack.pop(); //this rule is not valid for the current choice of interest, hence popping.

            }

        }
        if(profession==null)
        {
            System.out.println("Sorry !!! We dont have any other Interest Constructed just yet !!!");
            System.out.println("You could re-execute and start over !!!");
        }
        return profession; 
    }
}
