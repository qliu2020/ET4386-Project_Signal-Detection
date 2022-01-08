load Data
load PD_known
PD = zeros(5,30);
PFA = [0.1,0.01,0.001,0.0001,0.00001];
for n =1:5
    for i=1:30
        E = sum(s.^2);
        lambda = sqrt(sigmaw2*E)*qfuncinv(PFA(n)/2);
        detection = zeros(10000,1);
        for j =1:10000
            signal = s.';
            T = sum(signal.*x(j,:,i));
            if T > lambda
                detection(j)=1;
            end
        end
        PD(n,i) = sum(mask&detection)/sum(mask);
    end
end
figure(1);
plot(A,PD_real(1,:),'b',A,PD(1,:),'b-.',...
     A,PD_real(2,:),'c',A,PD(2,:),'c-.',...
     A,PD_real(3,:),'r',A,PD(3,:),'r-.',...
     A,PD_real(4,:),'m',A,PD(4,:),'m-.',...
     A,PD_real(5,:),'g',A,PD(5,:),'g-.');
xlabel('A');
ylabel('PD');
legend('PFA=10^-1 Clairvoyant','PFA=10^-1 Unknown A',...
       'PFA=10^-2 Clairvoyant','PFA=10^-2 Unknown A',...
       'PFA=10^-3 Clairvoyant','PFA=10^-3 Unknown A',...
       'PFA=10^-4 Clairvoyant','PFA=10^-4 Unknown A',...
       'PFA=10^-5 Clairvoyant','PFA=10^-5 Unknown A');

