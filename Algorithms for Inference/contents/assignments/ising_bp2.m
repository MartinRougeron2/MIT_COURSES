function marginals = ising_bp2(A,gamma,EPS)
% returns marginals
maxiter=1000;
% This function uses the q parameterization, i.e. it only tracks the ratio
% of the message values q = m(-1)/m(+1). Furthermore, it works in the log
% domain to utilize sparse matrices. This way, our operation that
% corresponds to taking the product of incoming messages over all but one
% edge will be taking the sum of a column of a matrix and then subtracting
% one element. Even for the 5x5 case, this seems a bit faster. Plus, it
% won't max out your memory for larger graphs!
    
    n = size(A,1);
    Mold = spalloc(n,n,4*n);
    Mnew = spalloc(n,n,4*n);
    
    % Initialize messages
    init = ones(n,n,2) + (rand(n,n,2)-0.5)./50;
    init = log(init(:,:,1) ./ init(:,:,2));
    
    Mold(A==1) = init(A==1);
    
    % get edge indices to iterate over
    [i,j] = find(A);
     
    change = 1;
    iters=0;
    while (change > EPS) && iters < maxiter
        % for each edge
        for ii=1:length(i)
            % we'll compute the message from "from" to "to"
            from=i(ii);
            to  =j(ii);
            % take the product of all messages TO this sending node
            % but exclude the message from the node we're going to send to
            messages_in = sum(Mold(:,from)) - Mold(to,from);
            % compute message function
            num = exp(messages_in+gamma) + exp(-gamma);
            den = exp(messages_in-gamma) + exp(gamma);
            % update message
            Mnew(from,to) = log(num/den);
        end
        
        % now that we've updated all messages, we compare Mnew to Mold
        change = sum(sum((Mnew - Mold).^2));
        
        % swap in the new for the old
        Mold = Mnew;
        
        iters = iters+1;
    end
    
    fprintf('iters: %d\n',iters)
    
    marginals = [squeeze(prod(exp(Mnew),1)); ones(1,n)];
    marginals = marginals ./ repmat(sum(marginals,1),[2,1]);
    
end