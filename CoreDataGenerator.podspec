Pod::Spec.new do |s|

  s.name            = "CoreDataGenerator"
  s.version         = '1.0.0'
  s.license         = 'MIT'
  s.homepage        = 'https://github.com/lotusflare/lfos-cdg'
  s.authors         = { 'LotusFlare' => 'ios@lotusflare.com' }
  s.summary         = "LotusFlare Core Data Generator"
  s.source          = { :git => "https://github.com/lotusflare/lfos-cdg.git", :tag => s.version.to_s }
  s.swift_versions  = ["5.0"]

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'

  base_dir = 'CoreDataGenerator/CoreDataGenerator'
  s.source_files = base_dir + '/**/*.{h,m,swift}'
  s.public_header_files = base_dir + '/*.h'
  s.resource = [base_dir + '/Templates/*.{stencil}']

end

