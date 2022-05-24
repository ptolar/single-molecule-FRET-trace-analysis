function spots = colocalize_spots(spots1, spots2 , maxdist)
% take x y (intensity) coordinates of spots and find the ones that are within maxdist pixels,
% return the id of the colocalizing spot in the last column
% spotscolocalized is x1 y1 intensity1  x2 y2 intensity2

% where to put results
columnId = size(spots1,2)+1;

if ~isempty(spots1) && ~isempty(spots2)
    
    spotscolocalized = zeros(size(spots1,1), (columnId-1)*2);
    % fill third column with zeros
    spots1(size(spots1,1), columnId) = 0;
    spots2(size(spots2,1), columnId) = 0;
    
    % find the colocalized
    for m = 1:size(spots1,1)
        xy = spots1(m, 1:2);
        xy = repmat(xy, [size(spots2,1), 1]);
        distance = sum((spots2(:, 1:2) - xy).^2, 2);
        colocalized = find(distance<maxdist);
        
        if ~isempty(colocalized)
            if numel(colocalized)>1
                % take the closest
                ind = distance(colocalized) == min(distance(colocalized));
                colocalized = colocalized(ind);
            end
            
            spots1(m, columnId) = colocalized;
            spots2(colocalized, columnId) = m;
            spotscolocalized(m,:) = [spots1(m, 1:columnId-1), spots2(colocalized, 1:columnId-1)];
            
        end
        
    end
    
    spotscolocalized(spotscolocalized(:,1)==0, :)  = [];
    
    spots.spots1 = spots1;
    spots.spots2 = spots2;
    spots.colocalized = spotscolocalized;
    
else
    spots.spots1 = spots1;
    spots.spots2 = spots2;
    spots.colocalized = [];
end



