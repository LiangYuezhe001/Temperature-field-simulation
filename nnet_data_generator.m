
train_input = zeros(5,300) ;
train_output = zeros(3,300);
% test_input = zeros(5,100) ;
% test_output = zeros(3,100);

[output,input]=temperture_field_caculation(400);
train_input(:,1:100) = input ;
train_output(:,1:100) = output;
[output,input]=temperture_field_caculation(600);
train_input(:,101:200) = input ;
train_output(:,101:200) = output;
[output,input]=temperture_field_caculation(800);
train_input(:,201:300) = input ;
train_output(:,201:300) = output;
% p=randperm(300);
% train_input=train_input(:,p);
% train_output=train_output(:,p);
[test_output,test_input]=temperture_field_caculation(654);
% nnet_output=myNeuralNetworkFunction(test_input);
