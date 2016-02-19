platform :ios, '8.0'
use_frameworks!
inhibit_all_warnings!

target 'mParticleTests', :exclusive => true do
    pod 'Simcoe', :path => './', :subspecs => ['mParticle']
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name == "Debug"
                # Enables unit testing of pods frameworks
                config.build_settings['ENABLE_TESTABILITY'] = "YES"
            end
        end
    end
end