Gem::Specification.new do |s|
  s.name          = 'concord-ruby'
  s.version       = '0.3.2'
  s.date          = '2015-10-07'
  s.summary       = "concord computation interface for ruby"
  s.description   = "ruby client library for concord operators"
  s.authors       = ["Cole Brown", "Alex Gallego"]
  s.email         = 'hello@concord.io'

  s.require_paths = ['./lib', './lib/gen-rb']
  s.files         = ['lib/concord.rb'] + Dir['lib/gen-rb/*.rb'] + Dir['lib/concord/*.rb']
  s.homepage      = 'https://github.com/concord/concord-ruby'
  s.license       = 'MIT'
  s.has_rdoc      = 'yard'

  # dependencies
  s.add_runtime_dependency 'thrift', '0.9.2.0'
  s.add_development_dependency 'yard'
end
