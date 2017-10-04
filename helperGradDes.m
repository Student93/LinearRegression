function m = helperGradDes(Xold,X,Y,alpha)

m = size(X,2);                                   %#training examples
theta = [0;0];                                  
summation = 0 ;
sumforJtheta = 0;

for i = 1:m
        sumforJtheta = sumforJtheta + (Y(i) - theta' * X(:,i)).^2;
end

noOfIterations = 0;
totalTheta = [0;0];

jthetaold = 1/( 2 * m ) * sumforJtheta;
epislon = realmax;
while epislon > 0.0001 
    sumforJtheta = 0;
    summation = 0;
    for i = 1:m
        summation = summation  + (Y(i) - theta' * X(:,i))*X(:,i);
    end
    
    
    theta = theta + (1/m) * alpha * summation;
    totalTheta = [totalTheta theta];
    
    for i = 1:m
        sumforJtheta = sumforJtheta + (Y(i) - theta' * X(:,i)).^2;
    end
    
    jthetanew = 1 / ( 2 *m ) * sumforJtheta;
    
    epislon = abs(jthetanew - jthetaold);
    
    jthetaold = jthetanew;
    %jthetanew;
  
end
noOfIterations = size(totalTheta,2)

theta11 = theta(1) - 5;
theta12 = theta(2) - 5;
theta
for i=1:100 
    theta0Vector(i) = theta11 + i * 0.1;
    theta1Vector(i) = theta12 + i * 0.1; 
end
for i= 1: 100
    for j=1: 100
        J(i,j)=0;
        for k=1:m
            J(i,j) = J(i,j) + (Y(k) - (theta0Vector(i)) - Xold(k)* theta1Vector(j)).^2;
        end
        J(i,j)= (1 / ( 2 *m )) * J(i,j);
    end
end

figure
hold on;
if alpha == 0.1
    title('Contour with 0.1')
elseif alpha == 0.5
    title('Contour with 0.5')
elseif alpha == 0.9
    title('Contour with 0.9')
elseif alpha == 1.3
    title('Contour with 1.3')
elseif alpha == 2.1
    title('Contour with 2.1')
elseif alpha == 2.5
    title('Contour with 2.5')
end
xlabel('theta1')
ylabel('theta0')
zlabel('J(theta) - Error Function')
contour(theta1Vector, theta0Vector,J);

%hold on;
for i = 1:noOfIterations
    J1 = 0;
    for k=1:m
            J1 = J1 + (Y(k) - (totalTheta(1,i)) - Xold(k)* totalTheta(2,i)).^2;
    end
    J1 = (1 / ( 2 *m )) * J1;
    scatter3(totalTheta(2,i),totalTheta(1,i),J1);
    pause(0.2);
end
hold off;