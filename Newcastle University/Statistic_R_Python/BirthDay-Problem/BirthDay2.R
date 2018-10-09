#Part 1
#Is there any people share birthday
# param:
#   Num_Peo (int): Number of People in Room

ShareBirth_Part1 = function(NUm_Peo){
  
  #Random Create the Date of People in the Room
  birthDay = c(sample(1:365,replace = TRUE, NUm_Peo))
  
  # Judge whether the People Share Birthday Comparing the length
  if (length(birthDay) == length(unique(birthDay))){
    
    #No People share birthday with  no repetitive Date
    print('No people share Birthday')
    
    return (birthDay)#Reture the Date of People in the Room
  }
  else{
    
    #People share birthday with Date repetitive
    print('There are some people share birthday')
    
    return (birthDay)#Reture the Date of People in the Room
  }
  
}

Main_Part1 = function(){ #The Main function to Run the Part 1
  NUM = 10 #If there are NUM of people in the room 
  ShareBirth_Part1(NUM) # Run to Judge
}

Main_Part1()# Run the Part 1

#Part 2
#Param : 
#    NUm_Re: Number of Experiments will Repeate
#
ShareBirth_Part2 = function(NUm_Re){
  
  # Initialization
  least_one_Peo = 0 # At least one people share birthday in ALL experiments
  RE_Exp = NUm_Re # Flag of how many experiments
  
  while(RE_Exp != 0){ # Loop the Num_Re Times for Experiments
    
    #Random Create the Date of 10 People in the Room
    birthDay = c(sample(1:365,replace = TRUE, 10))
    
    # Judge whether the People Share Birthday Comparing the length
    if (length(birthDay) == length(unique(birthDay))){
      
      #No People share birthday with  no repetitive Date
      print('No people share Birthday')
    }
    else{
      
      #People share birthday with Date repetitive
      print('There are some people share birthday')
      
      #Count the Number of People Share Birthday
      least_one_Peo = least_one_Peo + 1 
    }
    
    #In Order to Repeat the Experiment
    RE_Exp = RE_Exp - 1
  }
  
  #Probability of People Share Birthday in ALL Experiments in One Setting
  Pr = least_one_Peo / NUm_Re
  print(Pr)
  
  return(Pr)
}

# Main Function For Part 2
Main_Part2 = function(){
  Num_Re = c(1:10000,) # Number of Repetition of Experiments
  
  Count_Pro = 1 # Index the Vector to Store the each Probabilities
  
  Pr_Vec = c()# Store the Num_Re times of Probabilities
  
  # Get the Pro babillity of Each Experiments and Store Them
  for (count in Num_Re){
    Pr_Vec[Count_Pro] = ShareBirth_Part2(count)
    Count_Pro = Count_Pro + 1
  }
  
  #Plot the Trend of Probabilities Of Increasing Repetition of Experiment
  #x : Numeber of Repetition of the Experiments
  #y : The Probabilities Of Each Experiment
  print(Pr_Vec)
  print(Num_Re)
  plot(Num_Re, Pr_Vec, type = 'l', main = 'Probabilities Of Increasing Repetition of Experiment',xlab = 'Number Of Repetition',
       ylab = 'Probability', col = 'blue')
  
  #Always have the Exact probabillity to Check 
  abline(h=0.117,col = 'red', lty =3)
}

Main_Part2()# Run the part 2

#Part 3
#Param : 
#      Num_Peo = Number of the people in the room
#      Num_Re = Number of repetition of the experiments
ShareBirth_Part3 = function(NUm_Peo, NUm_Re){
  
  Count_Pro  = 0 # Index the Vector to Store the each Probabilities  
  Pr_Vec_3 = c() # Store the Num_Re times of Probabilities  
  Flag_Num = 0 #The number of people are required before the probability becomes at least 0.5
  Flag_Pr = TRUE # Flag of find the number get probability at least 0.5
   
  for (count in 1:NUm_Peo){ #loop of 1->366 people
    
    # At least one people share birthday in ALL experiments  
    least_one_Peo = 0
    # Flag of how many Repetitions of Experiments 
    RE_Exp = NUm_Re
    
    while(RE_Exp != 0){ #loop of Repetition Of Experiment
      
      #Random Create the Date of 10 People in the Room  
      birthDay = c(sample(1:365,replace = TRUE,count))
      
      if (length(birthDay) != length(unique(birthDay))){
        
        #People share birthday with Date repetitive
        # Count the Number of People Share Birthday
        least_one_Peo = least_one_Peo + 1
      }
      
      #In Order to Repeat the Experiment  
      RE_Exp = RE_Exp - 1
      
    }#end of experiment
    
    #Probability of People Share Birthday in ALL Experiments in One Setting  
    Pr_3 = least_one_Peo / NUm_Re
    
    # Find the the number of people are required 
    # before the probability becomes at least 0.5
    if(Pr_3 >= 0.5 & Flag_Pr){
      
      #Get the number of people required before the probability becomes at least 0.5
      Flag_Num = count
      
      # After a number, probabilities are always 0.5,so just get the first number
      Flag_Pr = FALSE # Keep the first number of people (at least 0.5)
    }
    
    # Get the Pro babillity of Each Experiments and Store Them  
    Count_Pro = Count_Pro  + 1
    Pr_Vec_3[Count_Pro] = Pr_3
  }
  
  #Probabilities of ALL experiments
  #the fisrt number of at least 0.5
  return()
}

Main = function(){
  
  NUm_Peo = 366 #Number of People in Room
  NUm_Re = 20000 # Number of Repetition of Experiments
  #Get the all probabilities
  Results = ShareBirth_Part3(NUm_Peo, NUm_Re)
  #Plot it
  plot(1:NUm_Peo, Results$Pr, type = 'l', main = 'Birthday Problem',xlab = 'Probabilities',
       ylab = 'Number Of People in the Room', col = 'blue')
  
  #Always have the at least 0.5  to Check
  abline(h=Results$Num_Five,col = 'red', lty =3)
}

Main()# Run the Part 3
