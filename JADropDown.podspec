

Pod::Spec.new do |s|



  s.name         = "JADropDown"
  s.version      = "0.1.0"
  s.summary      = "This is simple drop down."
  s.description  = "This is JA DropDwon with singleSelection And Multiplection"
  s.homepage     = "https://github.com/JitendraAgarwal-IOS/JADropDown.git"
  s.license      = "MIT"
s.author         = { "jitendra" => "agarwal.jitendra9@gmail.com" }
s.platform       = :ios, "8.0"
s.source         = { :git => "https://github.com/JitendraAgarwal-IOS/JADropDown.git", :tag => "#{s.version}" }

s.source_files = "JADropDown", "JADropDown/**/*.{h,m}"
s.resources = "JADropDown/JADropDown/resource/*.{xib}"
s.requires_arc = true

end
