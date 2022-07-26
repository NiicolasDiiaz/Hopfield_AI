function varargout = GuiHopfield(varargin)
% GUIHOPFIELD MATLAB code for GuiHopfield.fig
%      GUIHOPFIELD, by itself, creates a new GUIHOPFIELD or raises the existing
%      singleton*.
%
%      H = GUIHOPFIELD returns the handle to a new GUIHOPFIELD or the handle to
%      the existing singleton*.
%
%      GUIHOPFIELD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIHOPFIELD.M with the given input arguments.
%
%      GUIHOPFIELD('Property','Value',...) creates a new GUIHOPFIELD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GuiHopfield_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GuiHopfield_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GuiHopfield

% Last Modified by GUIDE v2.5 22-May-2021 19:34:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GuiHopfield_OpeningFcn, ...
                   'gui_OutputFcn',  @GuiHopfield_OutputFcn, ...
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


% --- Executes just before GuiHopfield is made visible.
function GuiHopfield_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GuiHopfield (see VARARGIN)

% Choose default command line output for GuiHopfield
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GuiHopfield wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GuiHopfield_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
global X Xp NumPa

for i=1:NumPa
    if isequal(X(:,i),Xp) || isequal((X(:,i).*-1),(Xp))
    set(handles.edit3, 'String', num2str(i));
    end
end
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global X W Xp NumPix

Car=str2double(get(handles.edit2,'String'));

Xp=X(:,Car);

Ruido = get(handles.slider1,'Value');

Indices=randperm(NumPix,round(Ruido*NumPix));

for j=1:length(Indices)
  Xp(Indices(j))=Xp(Indices(j))*-1;
end

C1=reshape(Xp, [sqrt(NumPix),sqrt(NumPix)])';
axes(handles.axes1); 
cla reset; 
imshow(C1, 'Parent', handles.axes1);
hold(handles.axes1, 'on' );





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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global  Xp NumPix
 % define maximum number of allowable mouse clicks to avoid infinite loop
        % and also to preallocate array to hold click data
        maxPoints = NumPix;

        % define plot limits so it doesn't keep rescaling which might be confusing
        xLimits = [1 sqrt(NumPix)-1];
        yLimits = [1 sqrt(NumPix)-1];

        % open new blank figure with defined limits
        figure('Name','Marque su primera clase');
        xlim(xLimits)
        ylim(yLimits)
        hold on

        %

        % instruct user on how to enter points and how to terminate
        disp('Click the mouse wherever in the figure; press ENTER when finished.');

        % preallocate array to hold mouse click coordinates
        mousePointCoords = zeros(maxPoints,2);

        % set up loop to collect and display mouse click points
        count = 0;
        for k = 1:maxPoints
            % get the mouse click point, or terminate if user presses enter
            %  in which case the coordinates will be returned empty
            coords = ginput(1);
            if isempty(coords)
                break
            end

            count = count + 1;
            mousePointCoords(count,:) = coords;
            plot(coords(:,1),coords(:,2),'o','MarkerSize',8);


        end
        % clean up
        hold off
        mousePointCoords = round(mousePointCoords(1:count,:)); % trim off unused array

        X1=mousePointCoords(:,1);

        % define maximum number of allowable mouse clicks to avoid infinite loop
        % and also to preallocate array to hold click data
        close 

        mousePointCoords = mousePointCoords(1:count,:); % trim off unused array

        % display results
        disp(round(mousePointCoords));
        
        mousePointCoords(:,2)=50-mousePointCoords(:,2);
        Filas= mousePointCoords(:,2);
        Columnas= mousePointCoords(:,1);
       
        Xp=zeros(sqrt(NumPix));
        for i=1:count
              Xp(Filas(i),Columnas(i))=1;
        end
        Xp;
        axes(handles.axes1); 
        cla reset; 
        imshow(Xp, 'Parent', handles.axes1);
        hold(handles.axes1, 'on' );
        
        Xp=reshape(Xp',[1,NumPix])'

        


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton5, 'Value', 0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton4, 'Value', 0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
global X W Xp NumPix
K=0;
if get(handles.togglebutton1, 'value')==0
    set(handles.togglebutton1,'string','Reconstruir','enable','on','BackgroundColor','white');
end

if get(handles.togglebutton1, 'value')
set(handles.togglebutton1,'string','Reconstruir','enable','on','BackgroundColor','green');
end
S2=0;
while get(handles.togglebutton1, 'value')

if get(handles.radiobutton4,'Value')  
Xp
K=K+1;
S=W*Xp;
Y=sign(S);

for j=1:length(Xp)
     if Y==0
           Y(i,j)=Xp(i,j);
     end
end
Xp=Y;
C=reshape(Xp, [sqrt(NumPix),sqrt(NumPix)])';

set(handles.edit4, 'String', num2str(K));
axes(handles.axes1); 
cla reset; 
imshow(C, 'Parent', handles.axes1);
hold(handles.axes1, 'on' );
drawnow limitrate
end

if get(handles.radiobutton5,'Value')   
 %S=zeros(NumPix,1);
 
 K=K+1;
        for i=1:NumPix
             for j=1:NumPix       
                  S2=W(i,j)*Xp(j)+S2; 
             end
         Y=sign(S2);
         S2=0;
         if Y==0
           Y=Xp(i);
         end
         Xp(i)=Y;
        end
     

        
C=reshape(Xp, [sqrt(NumPix),sqrt(NumPix)])';
set(handles.edit4, 'String', num2str(K));
axes(handles.axes1); 
cla reset; 
imshow(C, 'Parent', handles.axes1);
hold(handles.axes1, 'on' );
drawnow limitrate
end
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global X W Xp NumPix NumPa

NumPa=str2double(get(handles.edit1,'String'));
I1 = imread(['Flecha.png']);

NumPix = size(I1, 1) * size(I1, 2);

BW = im2bw(I1,0.9);
Flecha=reshape(BW',[1,NumPix])';

I2 = imread(['Cinco.png']);
BW = im2bw(I2,0.9);
Cinco=reshape(BW',[1,NumPix])';

I3 = imread(['Mas.png']);1
BW = im2bw(I3,0.9);
Mas=reshape(BW',[1,NumPix])';

I4 = imread(['Carita.png']);
BW = im2bw(I4,0.9);
Nueve=reshape(BW',[1,NumPix])';

I5 = imread(['Cero.png']);
BW = im2bw(I5,0.9);
Cero=reshape(BW',[1,NumPix])';

I6 = imread(['Ele.png']);
BW = im2bw(I6,0.9);
Ele=reshape(BW',[1,NumPix])';

I7 = imread(['Erre.png']);
BW = im2bw(I7,0.9);
Erre=reshape(BW',[1,NumPix])';

I8 = imread(['Uno.png']);
BW = im2bw(I8,0.9);
Uno=reshape(BW',[1,NumPix])';

I9 = imread(['Mayor.png']);
BW = im2bw(I9,0.9);
Mayor=reshape(BW',[1,NumPix])';

I10 = imread(['X.png']);
BW = im2bw(I10,0.9);
Equis=reshape(BW',[1,NumPix])';

X=[Uno,Erre,Ele,Cero,Mayor,Flecha,Mas,Cinco,Nueve,Equis];
X=(X.*-2)+1

X=X(:,1:NumPa);

if get(handles.radiobutton3, 'Value')==1
    W=X*pinv(X);
end

if get(handles.radiobutton2, 'Value')==1
for i=1:NumPix
    for j=1:NumPix
        if i==j
           W(i,j)=0; 
        else
        for k=1:NumPa
            W(i,j)=X(i,k)*X(j,k)+W(i,j);
        end
        end
    end
end
assignin('base','W',W);
NumPix
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton3, 'Value', 0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton2, 'Value', 0);

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
Ruido = get(handles.slider1,'Value');
set(handles.text5, 'String',num2str(Ruido*100));



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
