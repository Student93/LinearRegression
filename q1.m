fileID = fopen('q1x.dat','r');
formatspec = '%f';
X = fscanf(fileID,formatspec);
Xold = X;
fileID = fopen('q1y.dat','r');
Y = fscanf(fileID,formatspec);
m = numel(X);                                   %#training examples
theta = [0;0];
alpha = 0.01;                                    %Learning rate
summation = 0 ;
sumforJtheta = 0;
X = [ones(m,1) X]';
meanX = mean(X(2,:));
stdX = std(X(2,:));
X(2,:) = (X(2,:) - meanX)/stdX;

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
figure
hold on;
noOfIterations = size(totalTheta,2);
J = zeros(100, 100);
title('Housing Problem')
xlabel('Area')
ylabel('Price')
a = 40;
Xold = (Xold - mean(Xold))/std(Xold);
scatter(Xold,Y,a, 'MarkerEdgeColor',[0 .5 .5],...
    'MarkerFaceColor',[0 .7 .7],...
    'LineWidth',1.5);
%hold on;
line = theta(2) * Xold + theta(1);
plot(Xold, line);
hold off;
theta11 = theta(1) - 5;
theta12 = theta(2) - 5;
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
title('3-D Mesh')
xlabel('theta1')
ylabel('theta0')
zlabel('J(theta) - Error Function')
surf(theta1Vector, theta0Vector,J);
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

    
figure
hold on;
title('Contour with alpha = 0.01')
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

% e part

%helperGradDes(Xold,X,Y,0.1);
%pause(3);
helperGradDes(Xold,X,Y,0.5);
%pause(3);
%helperGradDes(Xold,X,Y,0.9);
%pause(3);
%helperGradDes(Xold,X,Y,1.3);
%pause(3);
%helperGradDes(Xold,X,Y,2.1);
%pause(3);
%helperGradDes(Xold,X,Y,2.5);


