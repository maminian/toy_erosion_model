function S = dieflow(Sold,diffrate,outflow,randomness)

% Takes array S, does the erosion flow to it.

%diffrate is the fraction of fluid passed from one cell to its daughters.
%outflow is how much we want to take out at each step.
%randomness affects how random the diffusion is from a cell to its
%daughters.

S = Sold;

n = size(S,2);
m = size(S,1);



for j = 1:m-1
    for k = 1:n
        
        %boundaries.
        if k==1 || k==n
            
            if k==1
                tar = 1:2;
            else
                tar = (n-1):n;
            end
        else
            tar = (k-1):(k+1);
        end
        
        arr = Sold(j+1,tar);
        if norm(arr,1) ==0
            arr = 1/length(arr)*ones(size(arr));
        else
        arr = arr/norm(arr,1);
        end
        
        blah = rand(1,length(tar));
        if norm(blah,1) ==0
            blah = 1/length(blah)*ones(size(blah));
        else
            blah = blah/norm(blah,1);
        end
            
        %derp.
        
        arr = (1-randomness)*arr + randomness*blah;
        
        amt = diffrate*Sold(j,k);
        S(j,k) = S(j,k) - diffrate*Sold(j,k);
        S(j+1,tar) = S(j+1,tar) + amt*arr;
        
    end
end

%final row
S(m,:) = (1-outflow)*S(m,:);


end