% Classical (average) algorithm
figure('NumberTitle', 'off', 'Name', 'Image');

uicontrol('String', 'Blur strength:', 'Units', 'normalized', 'Style', 'text', 'Position', [0 0.024 0.18 0.07]);
uicontrol('String', "Image name:", 'Units', 'normalized', 'Style', 'text', 'Position', [0.17 0.024 0.18 0.07]);

uicontrol('String', "10", 'Style', 'edit', 'Units', 'normalized', 'Position', [0.04 0 0.1 0.06], 'Tag', 'strengthField');
uicontrol('String', "photo.jpg", 'Style', 'edit', 'Units', 'normalized', 'Position', [0.18 0 0.16 0.06], 'Tag', 'imageField');

uicontrol('String', 'Execute', 'Callback', @process, 'Units', 'normalized', 'Position', [0.36 0 0.15 0.06]);

function process(~, ~)
    strengthField = findobj(gcf, 'Tag', 'strengthField');
    imageField = findobj(gcf, 'Tag', 'imageField');

    strengthField = strengthField.String;
    imageField = imageField.String;

    if isempty(strengthField) || isempty(imageField)
        fprintf('Error: fill all fields!\n')
        return;
    end
    
    strength = floor(str2num(['double(', strengthField, ')']));

    rgbImage = imread(imageField); % Read image from file
    subplot(1, 2, 1), imshow(rgbImage); % Display original image
    title('Оригінальне зображення');
    
    mask = ones(strength) / strength ^ 2; % Create average mask
    blurredImage = imfilter(rgbImage, mask, 'replicate'); % Blur the image.
    subplot(1, 2, 2), imshow(blurredImage); % Display blured image
    title('Розмите зображення (Average)');
end