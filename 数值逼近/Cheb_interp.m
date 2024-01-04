function v = Cheb_interp(f, n, u)
%f为要逼近的函数，n为切比雪夫多项式的次数，u为逼近的节点
   syms t;
   T(1:n+1) = t;
   T(1) = 1;
   T(2) = t;
   c = zeros(1, n+1);
   %首先计算前两个c值
   c(1) = gauss_L(matlabFunction(f(t)*T(1)/sqrt(1-t^2)),5000)/pi;  %这里使用了高斯积分
   c(2)=2*gauss_L(matlabFunction(f(t)*T(2)/sqrt(1-t^2)),5000)/pi;
   v = c(1) + c(2)*t;
   %计算剩余的
   for i = 3: n+1
       T(i) = 2*t*T(i-1)-T(i-2);
       c(i) = 2*gauss_L(matlabFunction(f(t)*T(i)/sqrt(1-t^2)),5000)/pi;
        v = v + c(i)*T(i);
        v = vpa(v,6);                                               %控制精度
        if i == n+1
            v = subs(v,'t',u);                                      %带入节点的值
        end
   end
end
%for n = 3:20
%     Error = max(abs(f(u) - Cheb_interp(f, n, u)));
 %    scatter(n,Error,'k','filled')
 %    set(gca,'YScale', 'log')
 %    hold on;
%end
%f = @(x) cos(3*x +2);
%n=4;
%u = [-1:0.01:1];