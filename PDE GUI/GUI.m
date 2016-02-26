function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 26-Feb-2016 13:31:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=50;
nk=N^2;%time run
dt = .1;
h=pi/N;
x = linspace(0,pi,N);
y = linspace(0,pi,N);
u = zeros(N,N,3);
spiral = str2num(get(handles.edit1,'String')); 
[a,b,c]= InitSpiralGridPDE(N,spiral,5,2); %3 spirals, 5 radius, 2 seed width

Dm=str2num(get(handles.edit1,'String'));;
%Dm=1;
q=10;
p=2.3;%p will control the spiralocity of this system 
r=dt/h^2;

a_old=zeros(N,1);
index=1;
for i=1:(N)
    for j=1:(N)
        a_old(index)=a(i,j);
        index=1+index;
    end
end

b_old=zeros(N,1);
index=1;
for i=1:(N)
    for j=1:(N)
        b_old(index)=b(i,j);
        index=1+index;
    end
end

c_old=zeros(N,1);
index=1;
for i=1:(N)
    for j=1:(N)
        c_old(index)=c(i,j);
        index=1+index;
    end
end


C=zeros((N)^2);%initialize the big block tridiag

for j=1:(N)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            C(j,k)=2+3*Dm*r;%diagonal of diagonal block
            
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            C(j,k)=2+2*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
            
        end
    end
end

for j=(N+1):(N^2-N)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            C(j,k)=2+4*Dm*r;%diagonal of diagonal block
            
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            C(j,k)=2+3*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
            
        end
    end
end

for j=(N^2-N+1):(N^2)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            C(j,k)=2+3*Dm*r;%diagonal of diagonal block
            
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            C(j,k)=2+2*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            C(j,k)=-Dm*r;
            C(k,j)=-Dm*r;
            
        end
    end
end

B=zeros((N)^2);%initialize the big block tridiag

for j=1:(N)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            B(j,k)=2-3*Dm*r;%diagonal of diagonal block
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            B(j,k)=2-2*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other clocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        end
    end
end

for j=(N+1):(N^2-N)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            B(j,k)=2-4*Dm*r;%diagonal of diagonal block
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            B(j,k)=2-3*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other clocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        end
    end
end

for j=(N^2-N+1):(N^2)%runs through rows
    for k=1:N^2%runs through each element of the jth row, but only until you hit j
        %(so we're only running through a lower tiangular, but we'll create a full martrix because symmetry)
        if(j==k && mod(j,N)~=1 && mod(j,N)~=0)
            B(j,k)=2-3*Dm*r;%diagonal of diagonal block
        elseif(j==k && mod(j,N)==1 || j==k && mod(k,N)==0)
            B(j,k)=2-2*Dm*r;
        elseif(k==j-1 && mod(j,N)~=1)%sub &super diagonal of diagonal block, without touching the corners of the other clocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        elseif(k+N==j)%diagonals or the sub &super diagona blocks
            B(j,k)=Dm*r;
            B(k,j)=Dm*r;
        end
    end
end

%%
count=0;
% hold on;
for l=1:1000
     
     rho=1-a_old-b_old-c_old;
     
  for i=1:N^2
        a_forcing(i,1)=q*rho(i)*a_old(i)-p*a_old(i)*c_old(i);
        b_forcing(i,1)=q*rho(i)*b_old(i)-p*b_old(i)*a_old(i);
        c_forcing(i,1)=q*rho(i)*c_old(i)-p*c_old(i)*b_old(i);
  end
   
    a_new=sparse(C)\(sparse(B)*sparse(a_old)+sparse(dt)*sparse(a_forcing));%crank nicolson
    b_new=sparse(C)\(sparse(B)*sparse(b_old)+sparse(dt)*sparse(b_forcing));
    c_new=sparse(C)\(sparse(B)*sparse(c_old)+sparse(dt)*sparse(c_forcing));
    index=1;
    for k=1:length(a_new)
        if(a_new(k)>1)
            a_new(k)=1;
        end
    end
    for k=1:length(b_new)
        if(b_new(k)>1)
            b_new(k)=1;
        end
    end
    for k=1:length(c_new)
        if(c_new(k)>1)
            c_new(k)=1;
        end
    end
    
    for i=1:(N)
        for j=1:(N)   
            u(i,j,1)=a_new(index);
            u(i,j,2)=b_new(index);
            u(i,j,3)=c_new(index);
            index=index+1;
          
        end
    end
    if mod(l,5)==0; %p is the interation time
       
        if(max(max(max(u)))>1)
            disp('greater than 1');
            count=count+1;
        else
            image(u);%plot
            saveas(gcf,num2str(l),'png');
            drawnow;
            colorbar;
        end
       % pause(.1);
    end 
%     sum(sum(sum(u)))
    a_old=a_new;
    b_old=b_new;
    c_old=c_new;
end
count