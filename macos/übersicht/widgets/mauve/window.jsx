import { getWidgetStyles } from './lib/widgets';
import Box from './lib/Box';
import palette from './lib/palette';

export const command = `
ps cax | grep yabai > /dev/null
if [ $? -eq 0 ]; then
  /usr/local/bin/yabai -m query --windows --window
fi
`;

export const refreshFrequency = false;

export const render = ({ output }) => {
  let currentWindow;
  try {
    currentWindow = JSON.parse(output);
  } catch (e) {}
  if (currentWindow) {
    return (
      <Box style={{ maxWidth: '17vw' }}>
        {currentWindow.app !== currentWindow.title
          ? `${currentWindow.app} – ${currentWindow.title}`
          : currentWindow.app}
      </Box>
    );
  } else {
    return null;
  }
};

export const className = `
  ${getWidgetStyles('window')};
`;
