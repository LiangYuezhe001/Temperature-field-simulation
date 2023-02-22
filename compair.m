%[test_output,test_input]=temperture_field_caculation(1000);
nnet_output=myNeuralNetworkFunction3(test_input);
nno=nnet_output(:,3);
plot(nno);
hold on;
tto=test_output(:,3);
plot(tto);