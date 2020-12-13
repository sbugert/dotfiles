import { styled, run } from 'uebersicht';
import Box from './lib/Box';
import palette from './lib/palette';

export const command = `
ps cax | grep yabai > /dev/null
if [ $? -eq 0 ]; then
  /usr/local/bin/yabai -m query --spaces --space
fi
`;

const spaces = ['term', 'web', 'mail', 'tunes', '✎ ♬'];
const SPACE_WIDTH = 34;

const Container = styled('div')`
  display: flex;
`;

export const refreshFrequency = false;

export const render = ({ output }) => {
  let spaceIndex;
  try {
    spaceIndex = JSON.parse(output).index;
  } catch (e) {}
  if (spaceIndex) {
    return (
      <Container>
        {spaces.map((label, i) => (
          <Box
            key={i}
            width={SPACE_WIDTH}
            onClick={() =>
              run(`/usr/local/bin/yabai -m space --focus ${i + 1}`)
            }
            backgroundColor={i === spaceIndex - 1 ? palette.color0E : undefined}
            style={{
              borderRadius: 0,
              borderTopLeftRadius: i === 0 ? 3 : 0,
              borderBottomLeftRadius: i === 0 ? 3 : 0,
            }}
          >
            {label}
          </Box>
        ))}
        <Box
          width={12}
          backgroundColor={
            spaceIndex > spaces.length ? palette.color0E : palette.color04
          }
          style={{
            borderRadius: 0,
            borderTopRightRadius: 3,
            borderBottomRightRadius: 3,
          }}
        >
          {spaceIndex}
        </Box>
      </Container>
    );
  } else {
    return null;
  }
};

export const className = `
  position: absolute;
  left: 50%;
  transform: translate(-50%, 0);
`;
