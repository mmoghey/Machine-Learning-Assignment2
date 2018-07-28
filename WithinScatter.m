function Sw = WithinScatter (X, y)
length = size (X, 2);
Sw = zeros ( length, length);
Classes = [ 'Standing' 'Sitting' 'Laying' 'Walking' 'ClimbingStairs'];

for i = 1 : 1 : size (Classes)
    class = X(y==Classes(i),:);
    classMean = mean(class);
    Sw_class = zeroes (length, length);
    for j = 1: 1 :length
        cov = class - classMean;
        cov = cov' * cov;
        Sw_class = Sw_class + cov;
    end
    Sw = Sw + Sw_class;
end