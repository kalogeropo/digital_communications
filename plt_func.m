function [] = plt_func(x,y,x_axis_n,y_axis_n,plt_title,filename)
fig=figure();
plot(y,x)
title(plt_title)
xlabel(x_axis_n)
ylabel(y_axis_n)
saveas(fig,filename,"png")

end

