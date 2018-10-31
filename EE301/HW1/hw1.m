result = [];
n = [-3:10];
sum = 0;
for n1 = -3:10
    for n2 = -3:4
        y = x_signal(n2)*h_signal(n1 - n2);
        sum = sum + y;
    end
    result(n1+4) = sum;
    sum = 0;
end
hStem = stem(n,result);
%// Create labels.
Labels = {'0'; '1'; '7';'23';'48';'72';'84';'80';'62';'38';'18';'6';'1';'0'};

%// Get position of each stem 'bar'. Sorry I don't know how to name them.
X_data = get(hStem, 'XData');
Y_data = get(hStem, 'YData');

%// Assign labels.
for labelID = 1 : numel(X_data)
   text(X_data(labelID), Y_data(labelID) + 3, Labels{labelID}, 'HorizontalAlignment', 'center','rotation',90);
end

   
