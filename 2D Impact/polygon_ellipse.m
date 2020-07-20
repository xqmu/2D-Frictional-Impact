clear all;

a_b = 0.0700;
b_b = 0.04500;
theta = -2.944; 
x0 = sqrt(a_b^2*b_b^2/(a_b^2*tan(theta)^2+b_b^2))*tan(-theta)/abs(tan(-theta));
y0 = x0*tan(-theta);
l  = sqrt(x0^2+y0^2);
o_b=[-l 0];
R  =[cos(theta) -sin(theta); sin(theta) cos(theta)];

t_k = -x0*b_b^2/y0/a_b^2;
t   = (R*[1 t_k]')';
t   = t/norm(t);
n   = [-t(2) t(1)];

t_c = o_b+(R*[x0 y0]')'; 
offset=0.02;

ellipse_x = zeros(1,2000); 
ellipse_y = zeros(1,2000); 
for i=1:1:2000
    ang_b = i*0.001*pi; 
    p_at=(R*[a_b*cos(ang_b) b_b*sin(ang_b)]')';
    ellipse_x(i) = p_at(1)+o_b(1); 
    ellipse_y(i) = p_at(2)+o_b(2); 
end
plot(ellipse_x, ellipse_y, '-'); 
hold on; 

plot([t_c(1) t_c(1)+t(1)*offset], [t_c(2) t_c(2)+t(2)*offset], 'k'); 
plot([t_c(1) t_c(1)+n(1)*offset], [t_c(2) t_c(2)+n(2)*offset], 'k');

P=[0 0;0.01 0.03;0.07 0.05;0.07 0;0.05 -0.02; 0 0];
for i=1:1:5
    plot([P(i,1) P(i+1, 1)], [P(i,2) P(i+1,2)],'k');
end

A  = 0;
Cx = 0;
Cy = 0;
I  = 0;
for i=1:1:5
    A=A+(P(i,1)*P(i+1,2)-P(i+1,1)*P(i,2));
    Cx=Cx+(P(i,1)+P(i+1,1))*(P(i,1)*P(i+1,2)-P(i+1,1)*P(i,2));
    Cy=Cy+(P(i,2)+P(i+1,2))*(P(i,1)*P(i+1,2)-P(i+1,1)*P(i,2));
    I=I+(P(i,1)*P(i+1,2)+2*P(i,1)*P(i,2)+2*P(i+1,1)*P(i+1,2)+P(i+1,1)*P(i,2))*(P(i,1)*P(i+1,2)-P(i+1,1)*P(i,2))/24;
end
A  = A/2;
Cx = Cx/6/A;
Cy = Cy/6/A;

plot(Cx,Cy,'o','MarkerSize',3,'MarkerFaceColor','b');
plot(0,0,'o','MarkerSize',2.5,'MarkerFaceColor','r');
plot(o_b(1),o_b(2),'o','MarkerSize',3,'MarkerFaceColor','r');

V_o = [1.52 -2.75];
V_b = [2.345  4.339];
V_o = V_o/norm(V_o)/40;
V_b = V_b/norm(V_b)/40;

plot([0 V_o(1)]+Cx, [0  V_o(2)]+Cy,'k');
plot([0 V_b(1)]+o_b(1), [0  V_b(2)]+o_b(2),'b');

V_o = [-9.52 -1.75];
V_o = V_o/norm(V_o)/40;
plot([0 V_o(1)]+Cx, [0  V_o(2)]+Cy,'k');

axis equal;
axis([-0.15 0.08 -0.07 0.08]);
box off;



