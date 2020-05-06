%% Lots of code!! 
%% Path to the DataSet directory
dirpath = "/home/pedro/Documents/Universidade/2ºano/2ºSemestre/ATD/Project/ATD-Project/DataSet";

%% Global Variables
% User stances throughout the study  (labels for the plot)
usr_stances = ["W", "W\_U", "W\_D","SIT", "STAND","LAY", "STAND\_SIT", "SIT\_STAND", "SIT\_LIE", "LIE\_SIT", "STAND\_LIE", "LIE\_STAND"];

% Colors ( To be used when plotting)
colors = ["r", "b", "g", "w", "k", "y","m", "c"];

% Accelerometers (Sensors available to get the data in the X Y and Z axis)
sensors = ["ACC\_X","ACC\_Y","ACC\_Z"];

% Sampling frequency used by the sensors
fs = 50;

%% Main 

load_data(dirpath);
plot_data(dataset1,fs,sensors,usr_stances,colors);


%% I will put this in its own matlab file but ill do that later...
function load_data(dir_path)
	% ==================== load_data  ====================
	% Description: This functions takes a directory with .txt files
	% that will be used as dataset and loads the matrices with the
	% data to the matlab workspace. The matrices will be named by
	% default as "dataset" + "num".
	% Arguments :
	%		>>> dir_path (string): Path to the directory
	% Return: None
	% =================================================
	files = dir(dir_path);
	k = 1;
	for file = files(3:end)'
		fpath = sprintf("%s/%s",file.folder,file.name);
		data = importdata(fpath," ");
		assignin("base",sprintf("dataset%d",k),data)
		k = k + 1;
	end
end


function plot_data(data,fs,sensors,usr_stances,colors)
	% ==================== plot_data  ====================
	% This funtion is responsible for ploting the data adquired from
	% the sensors in all 3 axes with a given sampling frequency.The
	% plot may take some configuration arguments like for example the
	% labels that will be used to highlight the intput data features
	% Arguments :
	%		>>> data (double): Matrix of doubles containing 3
	%		columns with the values for the sensors in the 3
	%		different axes (ACC_X,ACC_Y;ACC_Z)
	%		>>> fs (double): Sampling frequency (in Hz) used
	%		bye the sensors to obtain the values of
	%		acceleration
	%		>>> sensors (string): labels that identify each
	%		component (axis) of the sensor
	%		>>> usr_stances (string): labels for the plot
	%		containg the multiple possible stances for a user
	%		in any given moment
	%		>>> colors (string): string array with the colors
	%		for the plot commands	
	% =================================================
	
	time = (0:length(data)-1)./(60*fs); 
	
	figure(1); 
	for k = 1 : length(sensors)
		subplot(length(sensors),1,k);
		plot(time,data(:,k),colors(1,k));
		xlabel("Time (min)");
		ylabel(sensors(1,k));
	end
end