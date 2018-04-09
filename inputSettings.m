function answer=inputSettings()
    prompt = {'Enter image source file:','Enter the type of staircase (signal/noise)','Enter the signal block-size:','Enter the noise block-size:','Enter staircase output folder:'};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'airplane3.jpg','signal','50','50','C:/Users/gabriel/Documents/MATLAB/TopDown/'};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

end
