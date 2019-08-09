function [D,index]=BlockInsertionSort(D,v,n)
% function [D,index]=BlockInsertionSort(D,v,n)
% Reorder a matrix D based on the elements in its first column using a block insertion sort.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 7.1.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap07">Chapter 7</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also InsertionSort, MergeSort, QuickSort, HeapSort, CocktailSort,
% BitonicSort, OddEvenMergeSort.  Verify with BlockInsertionSortTest.

n=size(D,1); if nargout==2, D=[D, [1:n]']; end
k=n; while k>1 & D(k,1)>=0, k=k-1; end, j=k-1; i=j;
if k>1, while i>0                     % Determine a<0 block [j+1:k] and a>=0 block [i+1:j]
  while j>0
    if v, Draw(j,j,k,D,n); end
    if D(j,1)<0, j=j-1; else, break, end, end
  if j==1, i=j; else, i=j-1; end
  while i>0
    if v, Draw(i,j,k,D,n); end                           
    if D(i,1)>=0, i=i-1; else, break, end, end 
  if i<0, break, end, D(i+1:k,:)=[D(j+1:k,:); D(i+1:j,:)];
  if v, Draw(k,i+k-j,i,D,n), end, pause(0.3);
k=i+k-j; j=i-1; end, end                                                 
if nargout==2, index=round(D(:,end)); D=D(:,1:end-1); end
end % function BlockInsertionSort
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Draw(a,b,c,D,n)
a=a+.5; b=b+.5; c=c+.5; fill([a b b a],[0 0 3 3],'y'); hold on
if c~=a; fill([b c c b],[-3 -3 0 0],'g'); end
plot([0.5 n+.5],[0 0],'r-',[a a],[-1 1],'b-'); hold on
plot(D(:,1),'x'); axis([0 n+1 -1 1]); hold off, pause(0.1)
end % function Draw
