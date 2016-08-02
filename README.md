# concord-rb

**Ruby client libraries for Concord**

## Building

This repository is organized to work with the pip python package manager.
In order to create the package you will need to generate thrift definitions 
located in the main concord repo. Run the build_thrift script from the
root of the concord project:
```
$ cd ~/workspace/concord/ && ./configure.py --thrift
```

## Installing 

To install the package and its dependencies use gem2.0:
```
gem2.0 install concord-ruby
```

Once installed you can now run Concord computations written in Ruby! For detailed
documentation check out our
[Ruby docs](http://concord.io/docs/reference/ruby_client.html).

