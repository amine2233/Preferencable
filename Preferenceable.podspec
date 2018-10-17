Pod::Spec.new do |s|
	s.name = 'Preferenceable'
	s.version = '0.3.0'
	s.summary = 'Add a preferences window to your macOS app in minutes'
	s.license = 'MIT'
	s.homepage = 'https://github.com/amine2233/Preferencable'
	s.social_media_url = 'https://twitter.com/amine2233'
	s.authors = { 'Amine Bensalah' => 'amine.bensalah@outlook.com' }
	s.source = { :git => 'https://github.com/amine2233/Preferencable.git', :tag => "v#{s.version}" }
	s.source_files = 'Sources/**/*.swift'
	s.swift_version = '4.2'
	s.platform = :macos, '10.12'
end
