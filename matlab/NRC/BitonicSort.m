function [D,index]=BitonicSort(D,v,n)
% function [D,index]=BitonicSort(D,v,n)
% Reorder a matrix D based on the n=2^s elements in its first column using a bitonic sort.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 7.2.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap07">Chapter 7</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also InsertionSort, BlockInsertionSort, MergeSort, QuickSort, HeapSort, CocktailSort,
% OddEvenMergeSort.  Verify with BitonicSortTest.

s=log2(n); if nargout==2, D=[D, [1:n]']; end
for stage=1:s, N=2^stage; Nsets=n/N;
  for level=stage:-1:1, Nl=2^level; Ngroups=N/Nl;
    for set=0:Nsets-1, t=(-1)^set; for group=0:Ngroups-1, for i=1:Nl/2
      % Determine each pair of elements to be compared, and compare them.
      a=i+N*set+Nl*group; b=a+Nl/2; if t*D(a,1)>t*D(b,1), D([a b],:)=D([b a],:); end
    end, end, end
    if v, plot(D(:,1),'kx'), axis([1 n -1 1]), pause(0.5), end
  end
  if v, plot(D(:,1),'bx'), axis([1 n -1 1]), pause(2), end
end
if nargout==2, index=round(D(:,end)); D=D(:,1:end-1); end
end % function BitonicSort