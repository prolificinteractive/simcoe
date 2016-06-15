
Pod::Spec.new do |s|

  s.name         = "Simcoe"
  s.version      = "0.4.0"
  s.summary      = "An analytics framework that provides a base layer of simple APIs for managing analytics frameworks."
  s.description  = <<-DESC
                    Simcoe is an analytics framework that aims to provide a simple, extensible API for managing and handling various analytics frameworks. It makes very few assumptions about your analytics implementations, allowing the implementer to customize it to their needs.

                    Out of the box, Simcoe comes with base analytics framework. Further, the base framework includes several implementations of popular analytics frameworks that the user can simply drop into their project and start using.

                    Simcoe also provides a wealth of debugging options, including the ability to track errors as well as log and debug analytics calls right from Xcode.
                DESC
  s.license      = "MIT"
  s.author       = { "Christopher Jones" => "c.jones@prolificinteractive.com" }
  s.homepage     = "https://github.com/prolificinteractive/simcoe"

  #  When using multiple platforms
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/prolificinteractive/simcoe.git", :tag => s.version }
  s.requires_arc = true
  
  
  # Default subspec that contains all shared code files for the library
  # All subspecs must declare this as a dependency.
  s.subspec "Core" do |ss|
	 ss.source_files = "Simcoe/*.swift "
  end
  
  s.default_subspec = "Core"
  
  # Subspecs
  # Each subspec represents an analytics library implemented using Simcoe.

  adobe		=   { :name => "Adobe",           :dependency => "AdobeMobileSDK", :version => '~> 4.8' }
  mParticle =   { :name => "mParticle",       :dependency => "mParticle-Apple-SDK/mParticle", :version => '~> 6' }

  all_specs = [adobe, mParticle]

  all_specs.each do |spec| 
  
  	# Define a Cocoapods subspec
  	s.subspec spec[:name] do |sp|
		sp.source_files = "Simcoe/#{spec[:name]}/*"
		sp.dependency "Simcoe/Core"
		
        if spec[:dependency] && spec[:version]
            sp.dependency *spec[:dependency], spec[:version]
		end
		
        end #Subspec definition

    end # all subspecs loop


end #Pod definition
