##First Question
##Generate the log-likehood value for sample size of n Poisson Process
#Param: theta : from Poisson Process like lambda
#       sample : All sample
#
Log_Likehood = function(theta, Sample){
  
  Sample_size = length(Sample) ##Get the size of sample
  
  log = 0 # Store each log value
  
  final_log = 0 # Store the log-likelihood value
  
  for (count in Sample_size){ # loop of samples to get the each likelihood value of each theta
    
    log = Sample[count] * log(theta) - theta - log(factorial(Sample[count])) # log value of each Xi in samples
    
    final_log = final_log + log # Get the log-likelihood value
    
  }
  
  return (final_log) # Return the corrosponding log-likelihood value
}

#Second Question 
##Use Some Sample to plot Log-Likehood
#
Main_Plot_Question2 = function(){
  
  sample = c(12, 8, 14, 8, 11, 6, 13, 9, 9, 10) # Set the Sample in question
  
  theta = seq(0,100,0.01) # Set the range of theta
  
  theta.hat = theta[which.max(Log_Likehood(theta = theta, Sample = sample))] # Get the theta which can max the log-likelihood value
  
  # Plot the loglikelihood against theta
  plot(theta, Log_Likehood(theta = theta, Sample = sample), type = 'l', col = 'red',xlab = 'Different Theta', ylab = 'Value of Log-likelihood',main = 'Estimates of Theta By MLE')
  abline(v = theta.hat,col = 'blue') # Plot the theta we find
  print(theta.hat)
}

Main_Plot_Question2() # Run the Question 2

##Third Question
##New function of Q1 but output the maximum likehood estimate theta
#Param: sample :whatever sample needed to use to find a good theta  
#
MLE_Question3 = function(Sample){
  
  theta = seq(0,100,1) # Give a theta a range
  
  Sample_size = length(Sample) # Get the size of samples
  
  Each_value = c() # Used to store the each value
  
  count_value = 1 # Index of above vector
  
  for (diff_theta in theta){ #Loop of different theta
    
    log = 0 # Initialize the log value
    
    final_log = 0 # Initialize the log-likelihood value
    
    for (count in 1:Sample_size){ # loop of samples to get the each likelihood value of each theta
      
      log = Sample[count] * log(diff_theta) - diff_theta - log(factorial(Sample[count])) # log value of each Xi in samples
      
      final_log = final_log + log # Get the log-likelihood value
      
    }
    
    Each_value[count_value] = final_log # Store the each log-likelihood value of each theta
    
    count_value = count_value + 1 # Count the index of anove vector to store
    
  }
  
  index_max = which.max(Each_value) # Get the index of max likelihood value
  
  return (theta[index_max]) # Return the theta max the log-likelihood value
}

#Question 3
main_Question3 = function(){

  sample = c(12, 8, 14, 8, 11, 6, 13, 9, 9, 10) # Set the samples
  max_et_theata = MLE_Question3(sample) # Get the max theta
  
}

print(main_Question3()) # Run the question 3

##Question 4
#
Po_mle = function(n){
  
  
  count_st = 1 # Index of vector of each mean and variance
  mean_store = c() # Vector of each mean and variance
  var_store = c() # Vector of each mean and variance
  
  for (s in n){ #Loop of each n
    print(s)
    
    Each_th = c() # Vector to store the each theta
    mean_all = 0 # Initialize the mean of each n
    var_all = 0  # Initialize the variance of each n
    count = 1   # Index of the vector of each theta
    
    while( count != 1001 ){ # Loop of 1000 samples' MLE value
      print(count)
      
      sample_pd = rpois(s,10)# Randomly generated from poisson distribution
      
      Each_th[count] = MLE_Question3(sample_pd) # Store the each theta for each n
      
      count = count + 1 # Count the index of storing the theta
    }
    
    mean_store[count_st] = mean(Each_th) # mean of each n
    
    var_store[count_st] = var(Each_th) #  variance of each n
    
    count_st = count_st + 1 # Count the index of vector above
    
  }
  
  final_list = c(mean_store,var_store) # Reture all the mean and variance
  
  return (final_list)
  
}

##Question 5
##
#
#
main_Question5 = function(){
  n = c(5,10,25,50,100,1000) # Set the n samples
  
  inter = length(n) # get the Length of n
  
  results = Po_mle(n) # Get the Results
  
  mean = results[1:inter] # Get the mean of all n
  
  var = results[(inter + 1):(2*inter)] # Get the variance of all n
  
  
  plot(n, mean, type = 'l', col = 'red',xlab = 'Different Samples Size', ylab = 'Different Expectation of Theta',main = 'Expectation of theta by MLE')
  abline(h = 10,col = 'black')
  
  plot(n, var, type = 'l', col = 'red',xlab = 'Different Samples Size', ylab = 'Different variance of Theta',main = 'Var of theta by MLE')
  abline(h = 0,col = 'black')
  
}

main_Question5() # Run the Question 5