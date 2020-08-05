require 'spec_helper'

describe 'storm::backend::service' do

  on_supported_os.each do |os, facts|

    context "on #{os}" do

      let(:pre_condition) {
      <<-EOF
        class { 'storm::backend':
          hostname => 'storm.example.org',
        }
      EOF
      }

      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_service('storm-backend-server').with({
        :ensure => 'running',
        :enable => 'true',
      }) }

    end
  end

end