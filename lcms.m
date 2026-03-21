% Updated version of lcms
% Origin:
% https://www.mathworks.com/matlabcentral/fileexchange/24670-least-common-multiple-set/files/license.txt
%
% Copyright (c) 2009, Joshua
% All rights reserved.
%  
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%  
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution
%  
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.


function output = lcms(num_arr)

% factorization
for i = 1:numel(num_arr)
    temp = factor(num_arr(i));
   
    for j = 1:numel(temp)
        output(i, j) = temp(1, j);
    end
end

prime_list = primes(max(output, [], 'all'));

% prepare list of occurences of each prime number
q = zeros(size(prime_list));

% generate the list of the maximum occurences of each prime number
for i = 1:size(prime_list, 2)
    for j = 1:size(output, 1)
        temp = numel(find(output(j, :) == prime_list(i)));
        if temp > q(i)
            q(i) = temp;
        end
    end
end

output = prod(prime_list.^q);

end

