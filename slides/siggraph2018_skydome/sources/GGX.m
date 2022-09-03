% GGX Eval implementation
function o = GGX( theta, m)
m2 = m*m;
o = m2*m2 ./ ( (m2-1) .* cos(min(1.57, abs(theta))).^2 +1 ).^2;	
end