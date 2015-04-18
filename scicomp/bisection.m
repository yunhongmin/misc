function [zero, res, niter]=bisection(fun,a,b,tol,nmax,varargin)
x = [a, (a+b)*0.5, b]; fx = feval(fun, x, varargin{:});
if fx(1)*fx(3)>0
	error([' The sign of the function at the endpoints of the interval must be different']);
elseif fx(1) == 0
	zero=a; res=0; niter=0; return
elseif fx(3) == 0
	zero=b; res=0; niter=0; return
end
niter=0;
I=(b-a)*0.5;
while I >= tol & niter <= nmax
	niter = niter + 1;
	if fx(1)*fx(2) < 0
		x(3)=x(2); x(2)=x(1)+(x(3)-x(1))*0.5;
		fx=feval(fun,x,varargin{:}); I=(x(3)-x(1))*0.5;
	elseif fx(2)*fx(3)<0
		x(1)=x(2); x(2)=x(1)+(x(3)-x(1))*0.5;
		fx = feval(fun,x,varargin{:}); I=(x(3)-x(1))*0.5;
	else
		x(2)=x(find(fx==0)); I=0;
	end
end
if niter>nmax
	fprintf(['bisection stopped without converging to the desired tolerance because the maximum number of iterations was reached\n']);
end
zero = x(2); x=x(2); res=feval(fun,x,varargin{:});
return

