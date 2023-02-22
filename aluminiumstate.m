function [result]=aluminiumstate(mode,input)
    if mode==1
        if(input<700&&input>400)
            result=2*arctan((input-570)/10)/pi;
        elseif (input<=400)
                result=0;
        
        else
            result=1;
        end
    elseif(mode==2)
        


    end
end
