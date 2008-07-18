require 'sprout'
# Optionally load gems from a server other than rubyforge:
# set_sources 'http://gems.projectsprouts.org'
sprout 'as3'

############################################
# Configure your Project Model
project_model :model do |m|
  m.project_name            = 'DelorumSite'
  m.language                = 'as3'
  m.background_color        = '#565D64'
  m.width                   = 970
  m.height                  = 650
  m.lib_dir                 = 'lib/'
  m.bin_dir                 = '..'
  m.library_path            << "#{m.bin_dir}/DelorumSite.swc"
  m.library_path            << "#{m.lib_dir}ProgressSwcSrc.swc"
  # m.src_dir               = 'src'
  # m.lib_dir               = 'lib'
  # m.swc_dir               = 'lib'
  # m.bin_dir               = 'bin'
  # m.test_dir              = 'test'
  # m.doc_dir               = 'doc'
  # m.asset_dir             = 'assets'
  # m.compiler_gem_name     = 'sprout-flex4sdk-tool'
  # m.compiler_gem_version  = '>= 4.0.0'
  # m.source_path           << "#{m.lib_dir}/somelib"
  m.libraries             << :corelib
end

desc 'Compile and run the application for debugging'
debug :debug

desc 'Compile and run the test harness'
unit :test

desc 'Compile for deployment'
deploy :deploy

desc 'Generate documentation'
document :doc

# set up the default rake task
task :default => :debug

# Coming Soon....
#desc "Generate Flex Builder projects"
#flex_builder :project
