function v = hermite_interp(n, y, dy, u)
%我们采用cheb零点作为差值的节点，因为cheb零点具有较好的性质，y为差值函数，dy为差值函数的导数，u为输入的节点
%注意u要输入列向量！
   x = cos((2.*(0:n-1)'+1)*pi/(2*n+2));
   y = y(x);
   dy = dy(x);
   m = length(u);
   U = zeros(m, n); V = zeros(m,n);   %hermit基函数
   L = ones(m, n);                    %Lagrange基函数
   d = zeros(n, 1);                   %Lagrange基导数
   for j = 1:n
       for k = 1:n
           if k~=j
               L(:,j) = L(:,j).*(u - x(k))./(x(j) - x(k));
               d(j) = d(j) + 1./(x(j) - x(k));
           end
       end
   end
   for j = 1:n
       U(:,j) = 1 - 2*(u - x(j))*d(j);
       V(:,j) = u - x(j);
   end
   U = U.*(L.^2);
   V = V.*(L.^2);
   v = U*y + V*dy;