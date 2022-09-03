x  = linspace(-1.57, 2.1, 1000);
bx = linspace(-1.57, 1.57, 12);
bx = bx+0.5;

bx1 = linspace(-1.57, -0.13084, 6)+0.13084;
bx2 = linspace(0.13084, 1.57, 6)-0.13084;

bxx = [bx1 bx2] + 0.5;

bxx(5)=0.0;
bxx(6)=0.22636;

m = 0.3;

ggx = GGX(x, m);
sky = sin(2.0*bx-1.0).^2+0.01;

sky(7) = 0.4;
prod  = sky.*GGX(bx, m);
prod2 = sky.*GGX(bxx,m);

ggxColor = [0.8 0.0 0.0];
envColor = [0.1 0.6 0.9];
prodColor = [0.1 0.9 0.5];

markerEdgeColor = 'k';


% -------------------------------------

fig1 = figure(1);

hold off;
bar(bx, sky, 1.0, 'FaceColor', envColor, 'DisplayName','Environment ');
hold on;

bar(bx, prod, 1.0, 'FaceColor', prodColor, 'DisplayName','Product');
plot(x, ggx, 'r', 'LineWidth', 2.0, 'Color', ggxColor, 'DisplayName','BSDF proxy');
plot(bx,sky, 'o', 'MarkerFaceColor','k', 'MarkerSize', 6.0, 'MarkerEdgeColor', 'k', 'DisplayName','Eval point');

legend show;
legend boxoff;
legend('Location','north');

title({'Center cell based product'; ' '} , 'FontSize', 28)

axis([bx(1) bx(12) 0 1]);

print 'svg' "../img/prod_center.svg"

% --------------------------------------

fig2 = figure(2);

hold off;
bar(bx, sky, 1.0, 'FaceColor', envColor, 'DisplayName','Environment ');
hold on;
bar(bx, prod2, 1.0, 'FaceColor', prodColor, 'DisplayName','Product');
plot(x, ggx, 'r', 'LineWidth', 2.0, 'Color', ggxColor,'DisplayName','BSDF proxy');
plot(bxx, sky,'o', 'MarkerFaceColor', 'r', 'MarkerSize', 6.0, 'MarkerEdgeColor', 'k', 'DisplayName','Eval point');

axis([bx(1) bx(12) 0 1]);

legend show;
legend boxoff;
legend('Location','north');

title({'Conservative based product'; ' '},  'FontSize', 28);

print 'svg' "../img/prod_conservative.svg"

% --------------------------------------

fig3  = figure(3);

cdf = cumtrapz(bx, prod);
cdf = cdf / cdf(12);
cdf2 = cumtrapz(bx, prod2);
cdf2 = cdf2 / cdf2(12);

plot(bx, cdf, 'b', 'LineWidth', 2.0, bx, cdf2, 'r', 'LineWidth', 2.0);

axis([bx(1) bx(12) 0 1]);

legend('CDF Center based     ', 'CDF Conservative    ', 'Location','east');
legend boxoff;

title('Cummulative Distributions', 'FontSize', 28)

print 'svg' "../img/cdf_compare.svg"



