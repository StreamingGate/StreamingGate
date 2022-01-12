import React from 'react';

import Input from './Input';

export default {
  title: 'Components/Forms/Input',
  component: Input,
  args: {
    type: 'text',
    placeholder: '아이디를 입력해 주세요.',
    fontSize: 'content',
    fullWidth: false,
  },
};

const VariantTemplate = args => (
  <>
    <Input variant='outlined' {...args} />
    <Input variant='standard' {...args} />
  </>
);
export const Variant = VariantTemplate.bind({});
Variant.args = {
  size: 'small',
};

const SizeTemplate = args => (
  <>
    <Input size='small' variant='contained' {...args} />
    <Input size='large' variant='contained' {...args} />
    <Input size='small' variant='standard' {...args} />
    <Input size='large' variant='standard' {...args} />
  </>
);
export const Size = SizeTemplate.bind({});

const FullWidthTemplate = args => (
  <>
    <Input variant='contained' {...args} />
    <Input variant='standard' {...args} />
  </>
);
export const FullWidth = FullWidthTemplate.bind({});
FullWidth.args = {
  fullWidth: true,
  size: 'small',
};