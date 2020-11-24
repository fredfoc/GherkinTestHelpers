#
#  Be sure to run `pod s lint GherkinTestHelpers.pods' to ensure this is a
#  valid s and to remove all comments including this before submitting the s.
#
#  To learn more about Pods attributes see https://docs.cocoapods.org/sification.html
#  To see working Podss in the CocoaPods repo see https://github.com/CocoaPods/ss/
#

Pod::Spec.new do |s|
  s.name         = "GherkinTestHelpers"
  s.version      = "0.2.0"
  s.summary      = "Some Helpers on Top of SwiftGherkin library"
  s.description  = <<-DESC
                    Some Helpers that facilitate BDD and the use of Gherkin and .feature files
                   DESC

  s.homepage     = "https://github.com/fredfoc/GherkinTestHelpers"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "fredfoc" => "fredfocmac@gmail.com" }
  s.platform     = :ios, "13.0"
  s.source       = { :git => "https://github.com/fredfoc/GherkinTestHelpers.git", :tag => "#{s.version}" }
  s.source_files  = "Sources", "Sources/**/*.{h,m,swift}"
  s.dependency 'Gherkin'

  s.subspec 'Gherkin' do |ss|
    ss.source_files  = "SwiftGherkin/Sources/Gherkin", "SwiftGherkin/Sources/Gherkin/**/*.{h,m,swift}"
    ss.dependency 'Consumer', '~> 0.3'
  end
end
