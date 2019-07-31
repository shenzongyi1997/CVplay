function varargout = interactiveSegTool(varargin)
% INTERACTIVESEGTOOL MATLAB code for interactiveSegTool.fig
%      INTERACTIVESEGTOOL, by itself, creates a new INTERACTIVESEGTOOL or raises the existing
%      singleton*.
%
%      H = INTERACTIVESEGTOOL returns the handle to a new INTERACTIVESEGTOOL or the handle to
%      the existing singleton*.
%
%      INTERACTIVESEGTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERACTIVESEGTOOL.M with the given input arguments.
%
%      INTERACTIVESEGTOOL('Property','Value',...) creates a new INTERACTIVESEGTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interactiveSegTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interactiveSegTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interactiveSegTool

% Last Modified by GUIDE v2.5 16-May-2018 11:30:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interactiveSegTool_OpeningFcn, ...
                   'gui_OutputFcn',  @interactiveSegTool_OutputFcn, ...
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


% --- Executes just before interactiveSegTool is made visible.
function interactiveSegTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interactiveSegTool (see VARARGIN)
handles.im = im2double(imread('4.jpg')); 
set(handles.edit_numClusters, 'String', '2'); 
handles.k = str2double(get(handles.edit_numClusters, 'String')); 
label = cell((handles.k)+1, 1); 
label{1} = '请选择标签';
global counter;
counter = cell(handles.k, 1); 
for id = 1 : handles.k
    label{id+1} = num2str(id); 
    counter{id} = 0; 
end 
set(handles.popupmenu_label,'string',label);
handles.pixs = cell(handles.k, 1); 
axes(handles.axes_input); imshow(handles.im); 
global color;
color = {'r', 'g', 'b', 'y', 'k', 'w', 'm'}; 
% handles.ButtonDown = []; 
% handles.pos = [];
% Choose default command line output for interactiveSegTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interactiveSegTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interactiveSegTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_numClusters_Callback(hObject, eventdata, handles)
% hObject    handle to edit_numClusters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.k = str2double(get(hObject,'String')); 
% Hints: get(hObject,'String') returns contents of edit_numClusters as text
%        str2double(get(hObject,'String')) returns contents of edit_numClusters as a double
label = cell(handles.k+1, 1); 
label{1} = '请选择标签';
global counter;
counter = cell(handles.k, 1); 
for i = 1 : handles.k
    label{i+1} = num2str(i); 
    counter{i} = 0; 
end 
set(handles.popupmenu_label,'string',label);
handles.pixs = cell(handles.k, 1); 
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function edit_numClusters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_numClusters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_seg.
function pushbutton_seg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
k=str2num(get(handles.edit_numClusters,'String'));
label = get(handles.popupmenu_label,'Value');
img = handles.im;
img = rgb2gray(img);
[rows, cols] = size(img);
% F = zeros(rows*cols,5);
% for i=1:rows
%     for j=1:cols
%       F((i-1)*cols+j,:)=[img(i,j,1) img(i,j,2) img(i,j,3) i j];
%     end
% end
% seeds = handles.pixs;
% idx = knnsearch(F,[50 50 15 15 15]);
% axes(handles.axes_output);
% out_img = zeros(rows,cols);
% out_img(F(idx,4),F(idx,5)) = F(idx,1:3)/k;
% colormap(jet);
dist = zeros(rows,cols,k);
center = 1:k;
 center = center/k;
 center = center';
for i=1:5
    for j = 1:k
    dist(:,:,j) = (img-center(j,1)).^2;
    end
    [D, idx] = min(dist, [], 3); 
    for j = 1 : k
        center(j, 1) = mean(img(idx == j)); 
    end 
end

if label==1
    axes(handles.axes_output);
    imshow(idx/k); colormap(jet);
end
if label ==2
    aa = jet';
    aa = fliplr(aa);
    aa = aa';
    axes(handles.axes_output);
        imshow(idx/k); colormap(aa);        
end





% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ButtonDown pos; 
global counter; 
if counter{handles.action} == 0
    handles.pixs{handles.action} = []; 
end 
if strcmp(get(gcf,'SelectionType'),'normal')
    counter{handles.action} = counter{handles.action} + 1; 
    ButtonDown = 1;
    pos = get(handles.axes_input,'CurrentPoint'); 
    handles.pixs{handles.action} = [handles.pixs{handles.action}; pos(1, 1:2)]; 
%     set(handles.text2,'String',num2str(pos(1,1)));
end
guidata(hObject, handles);


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ButtonDown pos; 
global color; 
if ButtonDown==1
    pos0 = get(handles.axes_input,'CurrentPoint');
    line([pos(1,1) pos0(1,1)],[pos(1,2) pos0(1,2)],'LineWidth', 2, 'Color', color{handles.action});
    pos = pos0;
    handles.pixs{handles.action} = [handles.pixs{handles.action}; pos(1, 1:2)]; 
end
guidata(hObject, handles);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ButtonDown pos;
ButtonDown=[];
pos=[]; 
guidata(hObject, handles); 


% --- Executes on selection change in popupmenu_label.
function popupmenu_label_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String')); 
handles.action = str2double(contents{get(hObject,'Value')}); 
global ButtonDown pos; 
ButtonDown = []; 
pos = []; 
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_label contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_label
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


