name=input("Enter the file name of training data: ","s");
first_column=input("Enter the first column of the Training Data:");
last_column=input("Enter the last column of the trainig data, i.e the predicting values:"); %Enter the values to be predicted%
not_include=input("Enter the lines to omit: "); % Remove lines %
seperator=input("Enter the type of seperator to be used for the data: ", "s");  %Use ","  as seperator%
% Creating the data space         Only use .csv type files as test and training data sets%
    data=dlmread(name,seperator,not_include,0);
    data=data(:,first_column:last_column);
    
% Preparing the data for model or curve fitting i.e Creating X and y matrices %
      [n,d]=size(data);
      X=data(:,1:d-1);
      y=data(:,d);  
      
% Standardiztion has to be added here Need to figure out later %

%==== FUNCTION SPACE ==== Add all functions for the menu here%

% NORMAL EQN FUNCTION %
function[theta]=normalEqn(X,y)
X=[ones(length(X),1) X];
theta=zeros(size(X,2),1);
%Normal Eqn Computation part %
theta=pinv(X'*X)*X'*y;

% Display and print part of the Normal Function%

fprintf("Theta computed for Normal Equation \n");
fprintf('%f \n',theta);
fprintf('\n');
end     
% NORMAL EQN END %


%METHOD SELECTION %
  method=menu("Choose among the following Machine Learning Models to predict the values of PBE Bandgaps","Linear Regression Model","LASSO Model");

  %Menu selection %
if method==1,
%  Normal Equation Model/Method %
    theta=normalEqn(X,y);
% Calculation of MAPE (Mean Absolute Percentage Error Calculation) %
% ERROR CALCULTION USING MAPE % 
    name2 = input ("Enter the test data file name: ", "s");  % Test data set
    test_data = dlmread(name2, seperator, not_include, 0); 
    test_data = test_data(:, first_column:last_column); 
    inputs = [ones(length(test_data),1) test_data(:, 1:(last_column-first_column))];
    y = test_data(:, size(test_data, 2));  
    predicted_values = zeros(size(inputs,1), size(inputs,2)); 
    comparison_matrix = zeros(size(inputs,1), size(inputs,2));   
    predicted_values = inputs*theta; 
    comparison_matrix = [predicted_values y]; 
    mape = 100* sum(abs((inputs*theta-y)./y))/size(inputs,1)    %MAPE Calculation 

%elseif method==2
% LASSO Model/Method %


    % function lasso? Too many functions inside LASSO,  do I implement all of them inside the function space
    %Function takes input and the learning rate?
    
    
 
 end;