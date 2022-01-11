import React, { Fragment } from 'react';

import Typography from './Typography';

export default {
  title: 'Components/Core/Typography',
  component: Typography,
  args: {
    children: 'Almost before we knew it, we had left the ground.',
    props: [
      { type: 'title', title: 'Title(21px, bold)' },
      { type: 'subtitle', title: 'SubTitle(18px, bold)' },
      { type: 'tab', title: 'Tab(16px, bold)' },
      { type: 'lightTitle', title: 'Light Title(18px, regular)' },
      { type: 'component', title: 'Component(16px, regular)' },
      { type: 'content', title: 'Content(14px, regular)' },
      { type: 'highlightCaption', title: 'HighlightCaption(12px, bold)' },
      { type: 'caption', title: 'Caption(12px, regular)' },
      { type: 'bottomTab', title: 'Bottom Tab(9px, regular)' },
    ],
  },
};

const Template = args => {
  return args.props.map(({ type, title }) => (
    <Fragment key={type}>
      <div
        style={{
          fontSize: '16px',
          marginBottom: '1em',
          textTransform: 'uppercase',
          color: 'rgba(0, 0, 0, 0.3)',
        }}
      >
        {title}
      </div>
      <Typography type={type}>{args.children}</Typography>
      <br />
    </Fragment>
  ));
};

export const SGTubeFonts = Template.bind({});

SGTubeFonts.parameters = {
  controls: { hideNoControlsWarning: true, exclude: ['type', 'children', 'props'] },
};