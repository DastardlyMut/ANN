%neurtrain.m                                                               
%Author: Sean Devonport - g12d0625                                         
%A short script that trains a single neuron to solve the problem P -> T. It
%outputs W (weight matrix) and b (bias) once trained.                      
                                                                           
%%                 

function [W, b, iter] = neurtrain(P,T)
    %variables:        
    col = [0 0]; %variables for column dimensions of P and T                   
    checkm = false;      
    %check dimensions of P and T are correct:
    while(checkm==false)                                                                        
        col = [length(P) length(T)];                                           
        if(col(1) == col(2))                                                   
            checkm = true;                                                     
        else                                                                   
            fprintf('Please try again, wrong dimensions\n');                   
        end                                                                    

    end   
    
    %learning rate:
    r = 0.05; 
    
    %initiate weight matrices and bias randomly:                             
    W=rand(1,2);                                                               
    b=rand(1);                                                               

    %construct initial batch process matrices.                                 
    Wa = [W b];                                                                
    Pa=[P;ones(1,col(2))];                                                     

    %determine intial activations                                              
    A=hardlim(Wa*Pa);                                                          

    %% Updating rule:                                                          

    E=T-A; %error setup for batch processing.                         
                                                                                                                                                                   
    iter =0; %set up halt counter.     
    
    %implement updating rule:
    while(sum(E.^2) ~= 0 && iter <= 500)                                        
        W = W+r.*E*P'; %calculate new weight matrix (as batch) with learning rate.                                                        

        b = b + sum(E); %Calculate new bias (as batch)                                                               

        Wa = [W b];                                                            
        Pa = [P;ones(1,length(P))];                                            
        Na=Wa*Pa; %calculate neuron vector.                                    

        A=hardlim(Na);  %calcuate activations for neuron (as batch)                                                          

        iter = iter + 1; %halting counter.                                     

        E = T-A; %Calculate new errors.                                                                                                    
    end                                                                        
    %% Results:                                                                                          
    if (iter ~= 50)                                                            
        fprintf('Search success!\n');
    else                                                                       
        fprintf('Search failed\n'); %if search is over 100 iterations.            
    end                     
