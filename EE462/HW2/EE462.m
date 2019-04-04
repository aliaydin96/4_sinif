t = 0:0.0001:0.04;
f = 50;
we = 2 * pi * 50;
x1 = 100 * cos(we * t);
x2 = 100 * cos(we * t - 2 * pi / 3);
x3 = 100 * cos(we * t + 2 * pi / 3);
%% part A
figure();
plot(t, x1, 'r');
hold on
plot(t, x2, 'b');
hold on
plot(t, x3, 'g');
legend x_1 x_2 x_3
hold on
xlabel("time(sec)");
ylabel("Amplitude");
%% Part B
x_alfa = sqrt(2/3)*(x1 - x2 / 2 - x3 / 2);
x_beta = sqrt(2/3)*(sqrt(3)/2*(x2 - x3));
figure();
plot(t, x_alfa, 'r', t, x_beta, 'b');
legend x_a x_B
xlabel("time(sec)");
ylabel("Amplitude");

%% Part C
xd = x_alfa .* cos(we * t) + x_beta .* sin(we*t);
xq = -x_alfa .* sin(we * t) + x_beta .* cos(we*t);
figure();
plot(t, xd, 'r', t, xq, 'b');
legend x_d x_q
xlabel("time(sec)");
ylabel("Amplitude");

%% Part D
% Instead of using three vector components, we can handle calculate with
% two vector components. This provides simplicity to control system.