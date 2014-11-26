function b = cellfunempty(fun, varargin)
%CELLFUNEMPTY Apply function to non-empty cells in cell array
%
% b = cellfunempty(fun, a)

% Check input

if nargin > 2
    sz = cellfun(@size, varargin, 'uni', 0);
    if ~isequal(sz{:})
        error('All cell arrays must be same size');
    end

    isemp = cell(nargin-1,1);
    for ii = 1:nargin-1
        isemp{ii} = cellfun('isempty', varargin{ii});
    end

    if ~isequal(isemp{:})
        error('All cell arrays must have same sparsity pattern');
    end

    % Calculations

    a = cellfun(@(x) x(:), varargin, 'uni', 0);
    a = cat(2, a{:});

    b = cell(size(varargin{1}));

    idx = find(~isemp{1});
    for ii = idx'
        b{ii} = fun(a{ii,:});
    end

else
    a = varargin{1};
    
    b = cell(size(a));
    for ii = 1:numel(a)
        if ~isempty(a{ii})
            b{ii} = fun(a{ii});
        end
    end

end
