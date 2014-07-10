require 'spec_helper'

describe 'puppet::private::agent' do

  describe 'with defaults (Masterless)' do
    [ 'CentOS', 'RedHat' ].each do |os|
	
      context "#{os}" do
        let :facts do {
          :osfamily        => 'RedHat',
          :operatingsystem => os
        }
        end

        it { is_expected.to contain_stage('puppet') }
        it { is_expected.to contain_class('puppet') }
        it { is_expected.to contain_class('puppet::params') }
        it { is_expected.to contain_stage('puppet') }
        it { is_expected.to contain_package('puppet').with_ensure('latest') }
        it { is_expected.to contain_file('/etc/puppet/puppet.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/sysconfig/puppet').with_ensure('absent') }
        it { is_expected.to contain_file('/var/lib/puppet/lib').with_ensure('directory') }
        it { is_expected.to contain_file('/etc/puppet/puppet.conf').with_ensure('file').without_content %r{^\s+server\s+ = \w+|\s+runinterval\s+ = .*$} }
        it { is_expected.to contain_service('puppet').with_ensure('stopped').with_enable('false') }

      end
    end

    context 'Fedora' do
      let :facts do {
        :osfamily        => 'RedHat',
        :operatingsystem => 'Fedora'
      }
      end

      it { is_expected.to contain_stage('puppet') }
      it { is_expected.to contain_class('puppet') }
      it { is_expected.to contain_class('puppet::params') }
      it { is_expected.to contain_stage('puppet') }
      it { is_expected.to contain_package('puppet').with_ensure('latest') }
      it { is_expected.to contain_file('/etc/puppet/puppet.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/sysconfig/puppetagent').with_ensure('absent') }
      it { is_expected.to contain_file('/var/lib/puppet/lib').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/puppet/puppet.conf').with_ensure('file').without_content %r{^\s+server\s+ = \w+|\s+runinterval\s+ = .*$} }
      it { is_expected.to contain_service('puppetagent').with_ensure('stopped').with_enable('false') }

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

  describe 'with Master' do
    let :params do {
      :master => 'puppetmaster',
      :ensure => 'running',
      :enable => 'true'
    }
    end
    [ 'CentOS', 'RedHat' ].each do |os|

      context "#{os}" do
        let :facts do {
          :osfamily        => 'RedHat',
          :operatingsystem => os
        }
        end

        it { is_expected.to contain_stage('puppet') }
        it { is_expected.to contain_class('puppet') }
        it { is_expected.to contain_class('puppet::params') }
        it { is_expected.to contain_stage('puppet') }
        it { is_expected.to contain_package('puppet').with_ensure('latest') }
        it { is_expected.to contain_file('/etc/puppet/puppet.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/sysconfig/puppet').with_ensure('file') }
        it { is_expected.to contain_file('/etc/puppet/puppet.conf').with_ensure('file').with_content %r{^\s+server\s+ = \w+|\s+runinterval\s+ = .*$} }
        it { is_expected.to contain_service('puppet').with_ensure('running').with_enable('true') }

      end 
    end

    context 'Fedora' do
      let :facts do {
        :osfamily        => 'RedHat',
        :operatingsystem => 'Fedora'
      }
      end

      it { is_expected.to contain_stage('puppet') }
      it { is_expected.to contain_class('puppet') }
      it { is_expected.to contain_class('puppet::params') }
      it { is_expected.to contain_stage('puppet') }
      it { is_expected.to contain_package('puppet').with_ensure('latest') }
      it { is_expected.to contain_file('/etc/puppet/puppet.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/sysconfig/puppetagent').with_ensure('file') }
      it { is_expected.to contain_file('/etc/puppet/puppet.conf').with_ensure('file').with_content %r{^\s+server\s+ = \w+|\s+runinterval\s+ = .*$} }
      it { is_expected.to contain_service('puppetagent').with_ensure('running').with_enable('true') }

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
