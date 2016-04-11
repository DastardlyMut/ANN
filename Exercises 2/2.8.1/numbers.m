%numbers.m
%Author: Sean Devonport - g12d0625
%Check whether a perceptron can see fuzzified numbers.
%% Encode numbers 1-9:
zero = [0 1 1 1 0; 
        1 0 0 0 1;
        1 0 0 0 1;
        1 0 0 0 1;
        1 0 0 0 1;
        0 1 1 1 0];
    
one =  [0 0 1 0 0; 
        0 0 1 0 0;
        0 0 1 0 0;
        0 0 1 0 0;
        0 0 1 0 0;
        0 0 1 0 0];
    
two =  [1 1 1 0 0; 
        0 0 0 1 0;
        0 0 0 1 0;
        0 1 1 0 0;
        0 1 0 0 0;
        0 1 1 1 1];
    
three= [1 1 1 1 0; 
        0 0 0 1 0;
        0 0 0 1 0;
        0 1 1 1 0;
        0 0 0 1 0;
        1 1 1 1 0];
    
four = [0 0 0 1 0; 
        0 0 1 1 0;
        0 1 0 1 0;
        1 1 1 1 0;
        0 0 0 1 0;
        0 0 0 1 0];
    
five = [1 1 1 1 0; 
        1 0 0 0 0;
        1 0 0 0 0;
        1 1 1 1 0;
        0 0 0 1 0;
        1 1 1 1 0];
    
six =  [1 0 0 0 0; 
        1 0 0 0 0;
        1 0 0 0 0;
        1 1 1 1 1;
        1 0 0 0 1;
        1 1 1 1 1];

seven= [1 1 1 1 1; 
        0 0 0 0 1;
        0 0 0 0 1;
        0 0 0 0 1;
        0 0 0 0 1;
        0 0 0 0 1];

eight= [1 1 1 1 1; 
        1 0 0 0 1;
        1 1 1 1 1;
        1 0 0 0 1;
        1 0 0 0 1;
        1 1 1 1 1];

nine = [1 1 1 1 1; 
        1 0 0 0 1;
        1 1 1 1 1;
        0 0 0 0 1;
        0 0 0 0 1;
        0 0 0 0 1];

%Reshape for training:
 Ze=reshape(zero,30,1);
 On=reshape(one,30,1);
 Tw=reshape(two,30,1);
 Th=reshape(three,30,1);
 Fo=reshape(four,30,1);
 Fi=reshape(five,30,1);
 Si=reshape(six,30,1);
 Se=reshape(seven,30,1);
 Ei=reshape(eight,30,1);
 Ni=reshape(nine,30,1);
%%
%Encode targets:
t(:,1)= [0 0 0 0]';
t(:,2)= [0 0 0 1]';
t(:,3)= [0 0 1 0]';
t(:,4)= [0 1 0 0]';
t(:,5)= [1 0 0 0]';
t(:,6)= [0 0 1 1]';
t(:,7)= [0 1 1 1]';
t(:,8)= [1 1 1 1]';
t(:,9)= [0 1 0 1]';
t(:,10)=[1 0 0 1]';

%Create perceptron with 4 neurons:
per=newp(repmat([0 1],30,1),4);

%input patterns:
p=[Ze On Tw Th Fo Fi Si Se Ei Ni];

%train perceptron:
per=train(per,p,t);

fprintf('Perceptron Trained\n');

%% User input:
no=input('number to be fuzzified = ');

%select correct number to be reshaped:
switch no
    case 0
        display(zero);
        no=zero;
    case 1
        display(one);
        no=one;
    case 2
        display(two);
        no=two;
    case 3
        display(three);
        no=three;
    case 4
        display(four);
        no=four;
    case 5
        display(five);
        no=five;
    case 6
        display(six);
        no=six;
    case 7
        display(seven);
        no=seven;
    case 8
        display(eight);
        no=eight;
    case 9
        display(nine);
        no=nine;
end
    

%% Fuzzify numbers:
check = 1;

%enter positions to be fuzzified:
while(check)
    check=0;
    change=input('enter positions to be changed as rows of a matrix: ');
    for j=1:size(change,1)
        if(change(j,1) < 0 || change(j,1) > 6 || change(j,2) < 0 || change(j,2) > 5)
            fprintf('wrong dimensions, please try again\n');
            check=1;
        end
    end
end

noF = no;

for i=1:size(change,1)
    noF(change(i,1),change(i,2)) =~ noF(change(i,1),change(i,2));
end

display(noF);

%reshape fuzzified number for simulation:
noFreshaped=reshape(noF,30,1);

%% Recognize:

nofS=sim(per,noFreshaped);
display(nofS);
for k=1:size(t,2);
    if(nofS == t(:,k))
       index=k;
    end
end

fprintf('classification: %d\n',index-1);

