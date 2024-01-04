function v = lengend_zeros(n, f, u)
   %计算勒让德多项式的零点和权
   beta = .5./sqrt(1 - (2*(1:n)).^(-2));
   T = diag(beta, 1) + diag(beta, -1);
   [V, D] = eig(T);
   x = diag(D);
   wL = (2*V(1,:).^2)';
   y = f(x);
   %计算勒让德多项式的重心权
   w = (-1).^((0:n)').*sqrt((1-x.*x).*wL);
   numer = zeros(size(u));                       %构造与u行列相同的0矩阵
   denom = zeros(size(u));
   exact = zeros(size(u));
   for j = 1:n+1
      xdiff = u - x(j);
      temp = w(j)./xdiff;
      numer = numer + temp*y(j);
      denom = denom + temp;
      %这一步是防止去的节点和lengend的节点重合
      exact(xdiff ==0) = j;            %在矩阵exact中将所有xdiff=0的元素赋值为j，xdiff == 0表示取出xdiff为0的位置
                                       %j不能改！找y(exact(jj))时有用
   end
  v = numer./denom;
  jj = find(exact);      %返回非0元素的下标，对于矩阵按照列来进行排序
  v(jj) = y(exact(jj)); 
 %u = [-1:0.01:1]
 %f = @(t) abs(t)+t.^2+sin(10.*t)
 %sz = 11.*ones(1, 11);
 %plot(u,f(u),u,lengend(n, f, u)),hold on, scatter(x,y,sz,'k','filled'),legend('p(x)','f(x)','插值点')
 % for n = 3:20
   % error = max(abs(f(u)-lengend(n, f, u)));
   % scatter(n,error,'filled')
   % set(gca,'YScale', 'log')
 %    hold on;
