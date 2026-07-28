% INFO: function to find all specific files in folder
% 
% folder_name - folder to search
% 
% sort_function - handle to function or function name:
%  accepts one argument: struct {full_path, filename}
%  returns logical flag
% 
% extension - extension of files to search
% 
% disp - logical flag, truning on printing of found files
% 

% TODO:
% - add case of multiple folder_name and extension
% - add search of variables in *.mat files
% 

function names_out = find_files(folder_name, options)
arguments
    folder_name
    options.extension = ''
    options.sort_function = []
    options.disp = false
end

extension = string(options.extension);
sort_function = options.sort_function;
disp_flag = options.disp;

% find all *.mat files in folder
content = {dir(folder_name).name};
if isempty(content)
    error(['Wrong path: "' folder_name '"'])
end
content(1:2) = [];
names = string(content);

if extension ~= "" && extension ~= '*'
    is_mat = strfind(names, ['.' char(extension)]);
    if class(is_mat) ~= "cell" % NOTE: case of single file in folder
        is_mat = {is_mat};
    end
    is_mat = ~cellfun(@isempty, is_mat);
    names = names(is_mat);
end

numel(names)

range = false(size(names));
names_out = struct('full_path', [], 'filename', []);
for i = 1:numel(names)
    full_path = [char(folder_name) '/' char(names(i))];
    filename = names(i);
    names_out(i).full_path = fullfile(full_path);
    names_out(i).filename = filename;
    if ~isempty(sort_function) % NOTE: properties check
        range(i) = sort_function(names_out(i));
    else
        range(i) = true;
    end
    if range(i)
        if disp_flag
            disp([num2str(i) '/' num2str(numel(names)) ' : ' char(names(i))]);
        end
    end

end
names_out = names_out(range);


end