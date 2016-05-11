# concord-rb

**Ruby client libraries for Concord**

## Building

This repository is organized to work with the rubygems package manager.
In order to create the package you will need the necessary generated code.
Run the build_thrift script from the root of the concord project:
```
~/../concord/ $ ./configure.py --thrift
```

The generated code this package depends on is now located in ``lib/gen-rb``.
To install the package and its dependencies use gem2.0:
```
gem2.0 install concord-ruby
```
