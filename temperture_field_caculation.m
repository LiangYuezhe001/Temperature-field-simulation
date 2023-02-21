function [output,input]=temperture_field_caculation(inital_temp)
    aluminium = material;
    steel = material;
    air = material;
    %basci para
    dx=0.0025;dy=0.00125;dt=1;
    dxx=dx*dx;dyy=dy*dy;
    input = zeros(5,100) ;
    output = zeros(3,100);
    lambda_w=0;lambda_e=0;lambda_s=0;lambda_n=0;
    aluminium.lambda=200;steel.lambda=50;air.lambda=3;
    aluminium.rhoc=2790*881;steel.rhoc=7840*465;air.rhoc=1.2;
    aluminium.inital_temp=inital_temp;steel.inital_temp=20;air.inital_temp=20;
    bias=00;
    
    %mesh
    N_x=25;
    N_y=50;
%     z=4;
    
    % t=zeros(N_x*N_y,1);
    %t_neo=zeros(N_x*N_y,1);
    b=zeros(N_x*N_y,1);
    
    A=zeros(N_x*N_y,N_x*N_y);
    t_para=zeros(N_y,N_x);
    %temp=zeros(N_y,N_x);
    temp_neo=zeros(N_y,N_x);
    
    %inital condition
    lambda=zeros(N_y,N_x);
    rhocdt=zeros(N_y,N_x);
    q=zeros(N_y,N_x);
    
    %al
    temp_neo(9:N_y-9,1:16)=aluminium.inital_temp;
    lambda(9:N_y-9,1:16)=aluminium.lambda;
    rhocdt(9:N_y-9,1:16)=aluminium.rhoc/dt;
    
    %cup
    temp_neo(:,N_x-8:N_x-5)=steel.inital_temp;
    temp_neo(N_y-9:N_y,:)=steel.inital_temp;
    lambda(:,N_x-8:N_x-5)=steel.lambda;
    lambda(N_y-9:N_y,:)=steel.lambda;
    rhocdt(:,N_x-8:N_x-5)=steel.rhoc/dt;
    rhocdt(N_y-9:N_y,:)=steel.rhoc/dt;
    
    q(9:N_y,N_x-6)=1000000000/dt;
    q(9:N_y,N_x-7)=250000000/dt;
    
    %air
    % material(1:9,:)=0.001;
    % material(:,N_x-5:N_x)=0.001;
    temp_neo(1:9,:)=air.inital_temp;
    temp_neo(:,N_x-5:N_x)=air.inital_temp;
    lambda(1:9,:)=air.lambda;
    lambda(:,N_x-5:N_x)=air.lambda;
    rhocdt(1:9,:)=air.rhoc/dt;
    rhocdt(:,N_x-5:N_x)=air.rhoc/dt;
    
    %t=temp_neo(:);
    
    for time=1:100
    
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
                t_para=zeros(N_y,N_x);
            end
    
        end
    
        t_neo=A\b;
        %  t_neo=temp_caculation(N_x,N_y,lambda,rhocdt,temp_neo,dyy,dxx);
        temp_neo=reshape(t_neo,N_y,N_x);
    
        %showcase
       % h= heatmap(temp_neo,'Colormap',turbo,'ColorLimits',[000 700]);
        % pause(0.1)
        A=zeros(N_x*N_y,N_x*N_y);
        input(1,bias+time)=temp_neo(42,19);
        input(2,bias+time)=temp_neo(30,19);
        input(3,bias+time)=temp_neo(17,19);
        input(4,bias+time)=time;
        input(5,bias+time)=aluminium.inital_temp;
        output(1,bias+time)=temp_neo(42,1);
        output(2,bias+time)=temp_neo(30,1);
        output(3,bias+time)=temp_neo(17,1);
    
    end
    % x1=output(1,:);
    % for time =1:100
    %     in=input(:,time);
    %     x2(1,time)=sim(results,in);
    %     y(1,time)=time;
    % end

end