function v = bary_normal(x, f, u)
%插值多项式一般的第二重心形式
%x为插值节点，y为差值函数，u为输入的节点
   n = length(x);
   y = f(x);
   w = ones(n, 1);                           %开始构造重心权
   for i =1:n
       for j = 1:n
           if j~=i
               w(i) = w(i)/(x(i) - x(j));
           end
       end
   end
   numer = zeros(size(u));                       %构造与u行列相同的0矩阵
   denom = zeros(size(u));
   exact = zeros(size(u));
   for j = 1:n
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
   %plot(t, bary_normal(x, f, u), t, f(t)),hold on, scatter(x,y,sz,'k','filled'),legend('p(x)','f(x)','插值点')