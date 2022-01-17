import React from 'react';

import HomePage from './HomePage';

export default {
  title: 'Page/Home',
  component: HomePage,
  parameters: {
    layout: 'fullscreen',
    controls: { hideNoControlsWarning: true },
  },
};

const Template = args => <HomePage {...args} />;

export const HomePageStory = Template.bind({});
HomePageStory.storyName = 'Home';