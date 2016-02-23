
Pod::Spec.new do |s|

  s.name         = "Simcoe"
  s.version      = "0.2.0"
  s.summary      = "A short description of Simcoe."
  s.description  = <<-DESC
                   DESC
  s.license      = "MIT (example)"
  s.author       = { "Christopher Jones" => "c.jones@prolificinteractive.com" }

  #  When using multiple platforms
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://bitbucket.org/prolificinteractive/simcoe", :tag => s.version }
  s.requires_arc = true
  
  
  # Default subspec that contains all shared code files for the library
  # All subspecs must declare this as a dependency.
  s.subspec "Core" do |ss|
	 ss.source_files = "Simcoe/* "
  end
  
  s.default_subspec = "Core"
  
  # Subspecs
  # Each subspec represents an analytics library implemented using Simcoe.

  adobe		=   { :name => "Adobe",           :dependency => "AdobeMobileSDK", :version => '4.8.5' }
  mParticle =   { :name => "mParticle",       :dependency => "mParticle-iOS-SDK/mParticle", :version => '5.3.2' }

  all_specs = [adobe, mParticle]

  all_specs.each do |spec| 
  
  	# Define a Cocoapods subspec
  	s.subspec spec[:name] do |sp|
		sp.source_files = "Simcoe/#{spec[:name]}/*"
		sp.dependency "Simcoe/Core"
		
        if spec[:dependency] && spec[:version]
            sp.dependency *spec[:dependency], spec[:version]
		end
		
	end
	
  end
  

end
