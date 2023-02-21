%[test_output,test_input]=temperture_field_caculation(1000);
nnet_output=myNeuralNetworkFunction2(test_input);
nno=nnet_output(:,4);
plot(nno);
hold on;
tto=test_output(:,4);
plot(tto);