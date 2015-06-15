#!/bin/bash --login

apt-get -y install ruby2.0-dev
gem2.0 install concord-ruby
exec ruby2.0 sink.rb

