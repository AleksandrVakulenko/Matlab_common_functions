function y = soft_window(x, x_min, x_max, step_width)
arguments
    x
    x_min
    x_max
    step_width = []
end

if isempty(step_width)
    step_width = 0.05*(x_max - x_min);
end
sigma = step_width/2;
y = 1/2*(erf((x-x_min)/sigma) - erf((x-x_max)/sigma));

end