function [t] = temp_caculation(N_x,N_y,lambda,rhocdt,temp_neo,dyy,dxx)
    t_para=zeros(N_y,N_x);
    b=zeros(N_x*N_y,1);
    A=zeros(N_x*N_y,N_x*N_y);
    lambda_w=0;lambda_e=0;lambda_s=0;lambda_n=0;
    %t=zeros(N_x*N_y,1);
    for y=1:1:N_y
        for x=1:1:N_x
    
    
            %n
            if y>1
                lambda_n=min(lambda(y,x),lambda(y-1,x));
                t_para(y-1,x)=lambda_n/dyy;
            else
                %                 lambda_n=0;
                %       t_para(y,x)=t_para(y,x)+lambda_n/dyy;
            end
    
            %s
            if y<N_y
                lambda_s=min(lambda(y,x),lambda(y+1,x));
                t_para(y+1,x)=lambda_s/dyy;
            else
                lambda_s=1;
                %                  t_para(y,x)=t_para(y,x)+lambda_s/dyy;
            end
    
            %w
            if x>1
                lambda_w=min(lambda(y,x),lambda(y,x-1));
                t_para(y,x-1)=lambda_w/dxx;
            else
                lambda_w=0;
                %                 t_para(y,x)=t_para(y,x)+lambda_w/dxx;
            end
    
            %e
            if x<N_x
                lambda_e=min(lambda(y,x),lambda(y,x+1));
                t_para(y,x+1)=lambda_e/dxx;
            else
                lambda_e=1;
                %                 t_para(y,x)=t_para(y,x)+lambda_e/dxx;
            end
    
            %center node para
            t_para(y,x)=-((lambda_w+lambda_e)/dxx+(lambda_n+lambda_s)/dyy+rhocdt(y,x));
            %系数展开成矩阵
            A((y-1)*N_x+x,:)=t_para(:);
            %b
            b((y-1)*N_x+x,1)=-temp_neo(y,x)*rhocdt(y,x)-0;
            %重置系数
    
        end
    
    end
    t=A\b;
end