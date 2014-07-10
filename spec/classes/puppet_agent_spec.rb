require 'spec_helper'

describe 'puppet::agent', :type => 'class' do
  [ 'CentOS', 'Fedora', 'RedHat' ].each do |os|
    context "#{os}" do
      let :facts do {
        :osfamily        => 'RedHat',
        :operatingsystem => os
      }
      end
      it { is_expected.to compile }
      it { is_expected.to contain_class('puppet') }
      it { is_expected.to contain_class('puppet::params') }
      it { is_expected.to contain_class('puppet::agent') }
      it { is_expected.to contain_class('puppet::private::agent') }
    end 

    context 'Ubuntu' do
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
end
