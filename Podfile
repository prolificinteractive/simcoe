source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!
inhibit_all_warnings!

install! 'cocoapods', :deterministic_uuids => false

workspace 'Simcoe'

target 'Simcoe' do
    pod 'Simcoe', :path => './', :subspecs => ['Adobe', 'mParticle', 'Mixpanel']

    target 'SimcoeTests' do
        podspec :path => 'Simcoe.podspec'
    end

end

target 'mParticleExample' do
    project 'mParticleExample/mParticleExample'
    pod 'Simcoe', :path => './', :subspecs => ['Adobe', 'mParticle', 'Mixpanel']
    podspec :path => 'Simcoe.podspec'

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
