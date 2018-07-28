function [w, accuracy ] = lda(X, y)
% Linear Discriminant Analysis

% get the pos and neg data
pos_data = X(find(y==0), :);
neg_data = X(find(y==1), :);

% Mean of each class
pos_mean = mean(pos_data);
neg_mean = mean(neg_data);

% Center the data
pos_data = pos_data - pos_mean;
neg_data = neg_data - neg_mean;

% Covariance of the data
cov_all = 1 / (rows(X)) * (X - (1/2 * (pos_mean + neg_mean)))' * (X  - (1/2 * (pos_mean + neg_mean)));

cov_inv = inv (cov_all);
w0 = X * cov_inv * pos_mean' - (1/2) * pos_mean * cov_inv * pos_mean'; % + log (prob_pos);
w1 = X * cov_inv * neg_mean' - (1/2) * neg_mean * cov_inv * neg_mean'; % + log (prob_neg);
% Get w and training accuracy
%w = inv (cov_all) * (neg_mean - pos_mean)'
%p = sigmoid (X * w) >= 0.5
  
p = w1>w0;

w = w0 +w1;
accuracy = mean(double(p == y)) * 100;

% Plot Gaussian Ellipsoids
h_pos = plot_gaussian_ellipsoid(pos_mean, cov_all);
h_neg = plot_gaussian_ellipsoid(neg_mean, cov_all);
set(h_pos,'color','r');
set(h_neg,'color','g');
end

