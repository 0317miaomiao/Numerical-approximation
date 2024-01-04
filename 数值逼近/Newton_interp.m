function v = Newton_interp(x, f, u)
   n = length(x);
   m = length(u);
   D = zeros(n, n);
   v = zeros(size(m));
   %构造差商
   D(:,1) = f(x);
   for k = 2:n
       for j = k:n
           D(j,k) = (D(j,k-1) - D(j-1,k-1))./(x(j) - x(j-k+1));
       end
   end
   a = diag(D);                        %差商就是矩阵的对角线上的值
   
   %开始通过秦久绍算法计算
   v = repmat(a(n), m, 1);             %首先构造最里面的值
   for k = n-1:-1:1
       v = a(k) + v.*(u - x(k));
   end
   
       
   