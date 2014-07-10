require 'spec_helper'

describe 'puppet' do

  [ 'CentOS', 'RedHat', 'Fedora' ].each do |os|

    describe "#{os}" do
      let :facts do {
        :osfamily        => 'RedHat',
        :operatingsystem => os
      }
      end
      it { is_expected.to compile }
      it { is_expected.to have_resource_count(1) }
      it { is_expected.to contain_class('puppet::params') }
    end
  end

  describe 'Ubuntu' do
    let :facts do {
      :osfamily        => 'Debian',
      :operatingsystem => 'Ubuntu'
    }
    end
    it 'should expect to fail' do
      expect { is_expected.to raise_error(Puppet:Error) }
    end
  end
end
