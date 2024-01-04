function v = bary_cheb_zero(f, n, u)
%f为逼近的函数，n为插值多项式的次数，u为输入的节点
%在画图的时候，bary_interp本身就是一个函数，和sin(x)之类的效果一样，直接用即可
   x = cos((2.*(0:n)'+1)*pi/(2*n+2));    %切比雪夫的零点,注意要用列向量的形式
   y = f(x);
   w = sin((2.*(0:n)'+1)*pi/(2*n+2)).*(-1).^((0:n)');   %重心权
   numer = zeros(size(u));                       %构造与u行列相同的0矩阵
   denom = zeros(size(u));
   exact = zeros(size(u));
   for j = 1:n+1
      xdiff = u - x(j);
      temp = w(j)./xdiff;
      numer = numer + temp*y(j);
      denom = denom + temp;
      %这一步是防止去的节点和cheb的节点重合
      exact(xdiff ==0) = j;            %在矩阵exact中将所有xdiff=0的元素赋值为j，xdiff == 0表示取出xdiff为0的位置
                                       %j不能改！找y(exact(jj))时有用
   end
  v = numer./denom;
  jj = find(exact);      %返回非0元素的下标，对于矩阵按照列来进行排序
  v(jj) = y(exact(jj));  %若有u取的是cheb节点的值，则这个值=f(x_j)
  %图例不显示线条使用opengl software
  %这里的scatter中的x与y记得更新
  %plot(t, bary_cheb_zero(f, n, u), t, f(t)),hold on, scatter(x,y,sz,'k','filled'),legend('p(x)','f(x)','插值点')
  % sz = 11.*ones(1, 11);
  % f = @(t) abs(t) + t.^2 + sin(10.*t);
  %计算误差
  %for n = 5:30
  %    Error1 = max(abs(bary_cheb_zero(f, n, u)-f(t)));
  %    x = linspace(-1,1,n+1);
  %    Error2 = max(abs(bary_normal(x, f, u)-f(t)));
  %    scatter(n, Error1,n,Error2)
  %    set(gca,'YScale', 'log')
  %    hold on
 % end
 %plot(t, bary_cheb_zero(f, n, u), t, f(t)),hold on,plot(t, bary_normal(x, f, u), t, f(t)),hold on, scatter(x1,y1,sz,'k','filled'),legend('p(x)','f(x)','插值点')
 %plot(t, f(t),t, bary_cheb_zero(f, n, u),t, bary_normal(x, f,u),'linewidth', 1),hold on,legend('f(x)','cheb零点','均分节点'),hold on,scatter(x1,y1,sz,'k','filled','HandleVisibility','off'),scatter(x2,y2,sz,'k','filled','HandleVisibility','off')
% x = linspace(-1,1,11);
%x1 = cos((2.*(0:n)'+1)*pi/(2*n+2));
%y1 = f(x1);
%x2 = x;y2 = f(x2);
%sz = 11.*ones(1, 11);
 
 