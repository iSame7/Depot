Pod::Spec.new do |s|
s.name = 'Depot'
s.version = '0.0.1'
s.license = 'MIT'
s.summary = 'Struct persistance framework for Swift'
s.homepage = 'https://github.com/iSame7/Depot'
s.social_media_url = 'https://twitter.com/same7mabrouk'
s.authors = { "Sameh Mabrouk" => 'mabrouksameh@gmail.com' }
s.source = { :git => 'https://github.com/iSame7/Depot.git', :tag => s.version }

s.ios.deployment_target = '8.0'

s.source_files = 'Depot/*.swift'

s.requires_arc = true
end
