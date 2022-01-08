load Data
PD_theoretical = zeros(5,30);
PD_real = zeros(5,30);
SNR = zeros(1,30);
PFA = [0.1,0.01,0.001,0.0001,0.00001];
for n =1:5
    for i=1:30
        E = A(i)^2*sum(s.^2);
        SNR(i) = 10*log10(E/sigmaw2);
        lambda = sqrt(sigmaw2*E)*qfuncinv(PFA(n));
        PD_theoretical(n,i) = qfunc(qfuncinv(PFA(n))-sqrt(E/sigmaw2));
        detection = zeros(10000,1);
        for j =1:10000
            signal = A(i)*s.';
            T = sum(signal.*x(j,:,i));
            if T > lambda
                detection(j)=1;
            end
        end
        PD_real(n,i) = sum(mask&detection)/sum(mask);
    end
end
figure(1);
plot(SNR,PD_real(1,:),'b--',SNR,PD_theoretical(1,:),'b',...
     SNR,PD_real(2,:),'c--',SNR,PD_theoretical(2,:),'c',...
     SNR,PD_real(3,:),'r--',SNR,PD_theoretical(3,:),'r',...
     SNR,PD_real(4,:),'m--',SNR,PD_theoretical(4,:),'m',...
     SNR,PD_real(5,:),'g--',SNR,PD_theoretical(5,:),'g');
xlabel('SNR');
ylabel('PD');
legend('PFA=10^-1 Real','PFA=10^-1 Theoretical','PFA=10^-2 Real',...
       'PFA=10^-2 Theoretical','PFA=10^-3 Real','PFA=10^-3 Theoretical',...
       'PFA=10^-4 Real','PFA=10^-4 Theoretical','PFA=10^-5 Real',...
       'PFA=10^-5 Theoretical')
save('PD_known','PD_real');
    
           