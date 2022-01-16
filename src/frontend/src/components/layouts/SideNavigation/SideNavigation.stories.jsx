import React from 'react';

import { MainLayoutContext } from '@utils/context';

import SideNavigation from './SideNavigation';

export default {
  title: 'Layouts/SideNavigation',
  component: SideNavigation,
  decorators: [
    (Story, rest) => {
      const { args } = rest;
      return (
        <MainLayoutContext.Provider value={{ ...args.ctx }}>
          <div style={{ flex: '1' }}>
            <div style={{ height: '60px' }} />
            <Story />
          </div>
        </MainLayoutContext.Provider>
      );
    },
  ],
  parameters: {
    layout: 'fullscreen',
    controls: { hideNoControlsWarning: true, exclude: ['ctx'] },
    previewTabs: {
      'storybook/docs/panel': { hidden: true },
    },
  },
};

const Template = args => <SideNavigation {...args} />;

export const SideNavigationStory = Template.bind({});
SideNavigationStory.args = {
  ctx: { sideNavState: { open: true, backdrop: false }, onToggleSideNav: undefined },
};
SideNavigationStory.storyName = 'SideNavigation';
