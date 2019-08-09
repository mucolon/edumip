function [D,index]=HeapSort(D,v,n)
% function [D,index]=HeapSort(D,v,n)
% Reorder a matrix D based on the elements in its first column using a heap sort.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 7.1.6.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap07">Chapter 7</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also InsertionSort, BlockInsertionSort, MergeSort, QuickSort, CocktailSort,
% BitonicSort, OddEvenMergeSort.  Verify with HeapSortTest.

if nargout==2, D=[D, [1:n]']; end, for a=floor(n/2):-1:1, D=Sift(D,a,n,v); end   % Heapify
for b=n:-1:2, D([1 b],:)=D([b 1],:);        % Peel off max record & put grandchild at root
  if v, plot(D(:,1),'x'), pause(0.1), end
  D=Sift(D,1,b-1,v);                        % Sift (re-heapify) & repeat
end, if nargout==2, index=round(D(:,end)); D=D(:,1:end-1); end
end % function HeapSort                                   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function D=Sift(D,a,b,v)
while a*2<=b                                       % Working on one generation at a time
  c=a*2; if c<b & D(c,1) < D(c+1,1); c=c+1; end    % Find the child with largest marker            
  if D(a,1) < D(c,1); D([a c],:)=D([c a],:); a=c;  % Swap positions if necessary.
    if v, plot(D(:,1),'x'), pause(0.1), end
  else, return, end                       
end
end % function Sift
