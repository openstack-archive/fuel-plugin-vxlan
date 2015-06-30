require 'spec_helper'
describe 'vxlan' do

  context 'with defaults for all parameters' do
    it { should contain_class('vxlan') }
  end
end
