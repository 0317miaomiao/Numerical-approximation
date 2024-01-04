function v = gauss_cheb1 (f, n)
   x = cos((2.*(0:n)'+1)*pi/(2*n+2));
   y = f(x);
   v = pi/(n+1).*sum(y);