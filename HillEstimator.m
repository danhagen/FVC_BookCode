function HillEstimator(interpulse)

pulse  = [2 3 10];
figure;
subplot(3,1,1);
subplot(3,1,2);
subplot(3,1,3);

for j = 1:3
    
    w=16;
    interval = w + interpulse;
    interval_s = num2str(interval);
    pulse_s = num2str(pulse(j));
    t_total = (w + interpulse)*pulse(j);
    t = 0:1:t_total;
    delay = w/2:(w+interpulse):t_total+1;

    F = [];

    for i = 1:(length(delay))
        t_i = delay(i)-(w/2);
        t_f = delay(i)+(w/2);
        if i == 1
            tspan = t(t>=t_i&t<=t_f);
            F_i = 0;
            [~,F_out] = ode45(@HillON,tspan,F_i);
            F = [F F_out'];
            tspan = t(t>=t_f&t<=(delay(i+1)-(w/2)));
            F_i = F_out(end,:);
            [~,F_out] = ode45(@HillOFF,tspan,F_i);
            F = [F F_out(2:end,:)'];        
        else
            tspan = t(t>=t_i&t<=t_f);
            F_i = F_out(end,:);
            [~,F_out] = ode45(@HillON,tspan,F_i);
            F = [F F_out(2:end,:)'];
            if i==length(delay)
                tspan = t(t>=t_f&t<=t(end));
                F_i = F_out(end,:);
                [~,F_out] = ode45(@HillOFF,tspan,F_i);
                F = [F F_out(2:end,:)'];
            else
                tspan = t(t>=t_f&t<=(delay(i+1)-(w/2)));
                F_i = F_out(end,:);
                [~,F_out] = ode45(@HillOFF,tspan,F_i);
                F = [F F_out(2:end,:)'];
            end
        end
    end
    
subplot(3,1,j);
plot(t,F);
title_s = [pulse_s ' Pulses w/ Interval ' interval_s 'ms'];
title(title_s);
xlabel('t (in ms)');
ylabel('F (Normalized Units)');

end

end


