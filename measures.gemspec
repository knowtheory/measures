# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{measures}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ted Han"]
  s.autorequire = %q{measures}
  s.date = %q{2009-03-27}
  s.description = %q{A minimally invasive measurement library}
  s.email = %q{measures@knowtheory.net}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/common_measures.rb", "lib/definition", "lib/definition/definition.rb", "lib/definition/definition.treetop", "lib/measures.rb", "lib/metric", "lib/metric/base.rb", "lib/metric/derived.rb", "lib/metric/metric.rb", "lib/ministry_of_weights_and_measures.rb", "lib/modifiers", "lib/modifiers/named_quantities.rb", "lib/us_customary_system", "lib/us_customary_system/base.rb", "lib/us_customary_system/us_customary_system.rb", "test/measures", "test/measures/definition_test.rb", "test/measures/measure_test.rb", "test/measures/metric_test.rb", "test/measures/ministry_of_weights_and_measures_test.rb", "test/measures/modifier_test.rb", "test/measures/use_case_test.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://measures.knowtheory.net}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A minimally invasive measurement library}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
