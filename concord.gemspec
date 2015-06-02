Gem::Specification.new do |s|
  s.name          = 'concord'
  s.version       = '0.0.4'
  s.date          = '2015-01-28'
  s.summary       = "concord computation interface for ruby"
  s.description   = "concord computation interface for ruby"
  s.authors       = ["Cole Brown"]
  s.email         = 'hello@concord.io'

  s.require_paths = ['./lib', './lib/gen-rb']
  s.files         = ['lib/concord.rb'] + Dir['lib/gen-rb/*.rb'] + Dir['lib/concord/*.rb']
  s.homepage      = 'http://concord.io'
  s.license       = 'MIT'

  # dependencies
  s.add_runtime_dependency 'thrift', '~> 0.9.2.0'
  s.add_development_dependency 'yard'
end

