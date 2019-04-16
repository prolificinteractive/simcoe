
Pod::Spec.new do |s|

  s.name         = "Simcoe"
  s.version      = "2.0.3"
  s.summary      = "An analytics framework that provides a base layer of simple APIs for managing analytics frameworks."
  s.description  = <<-DESC
                    Simcoe is an analytics framework that aims to provide a simple, extensible API for managing and handling various analytics frameworks. It makes very few assumptions about your analytics implementations, allowing the implementer to customize it to their needs.

                    Out of the box, Simcoe comes with base analytics framework. Further, the base framework includes several implementations of popular analytics frameworks that the user can simply drop into their project and start using.

                    Simcoe also provides a wealth of debugging options, including the ability to track errors as well as log and debug analytics calls right from Xcode.
                DESC
  s.license      = "MIT"
  s.author       = { "Prolific Interactive" => "info@prolificinteractive.com" }
  s.homepage     = "https://github.com/prolificinteractive/simcoe"

  #  When using multiple platforms
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/prolificinteractive/simcoe.git", :tag => s.version }
  s.requires_arc = true


  # Default subspec that contains all shared code files for the library
  # All subspecs must declare this as a dependency.
  s.subspec "Core" do |ss|
	 ss.source_files = "Simcoe/*.swift", "Simcoe/Analytics\ Tracking\ Protocols/**/*.swift"
  end

  s.default_subspec = "Core"

  # Subspecs
  # Each subspec represents an analytics library implemented using Simcoe.

  adobe		  =   { :name => "Adobe",           :dependency => "AdobeMobileSDK", :version => '~> 4.13' }
  mParticle =   { :name => "mParticle",       :dependency => "mParticle-Apple-SDK", :version => '7.9.0' }
  mixpanel  =   { :name => "Mixpanel",        :dependency => "Mixpanel-swift", :version => '~> 2.4.4' }

  all_specs = [adobe, mParticle, mixpanel]

  all_specs.each do |spec|

  	# Define a Cocoapods subspec
  	s.subspec spec[:name] do |sp|
		sp.source_files = "Simcoe/#{spec[:name]}/*.swift"
		sp.dependency "Simcoe/Core"

        if spec[:dependency] && spec[:version]
            sp.dependency *spec[:dependency], spec[:version]
		end

        end #Subspec definition

    end # all subspecs loop

end #Pod definition
