require_relative '../../../environments/rspec_env'


RSpec.describe 'the gem' do

  let(:root_dir) { "#{__dir__}/../../.." }
  let(:lib_folder) { "#{root_dir}/lib" }
  let(:features_folder) { "#{root_dir}/testing/cucumber/features" }

  before(:all) do
    # Doing this as a one time hook instead of using `let` in order to reduce I/O time during testing.
    @gemspec = eval(File.read("#{File.dirname(__FILE__)}/../../../cql.gemspec"))
  end

  it 'validates cleanly' do
    mock_ui = Gem::MockGemUi.new
    Gem::DefaultUserInteraction.use_ui(mock_ui) { @gemspec.validate }

    expect(mock_ui.error).to_not match(/warn/i)
  end

  it 'is named correctly' do
    expect(@gemspec.name).to eq('cql')
  end

  it 'runs on Ruby' do
    expect(@gemspec.platform).to eq(Gem::Platform::RUBY)
  end

  it 'exposes its "lib" folder' do
    expect(@gemspec.require_paths).to match_array(['lib'])
  end

  it 'has a contact email' do
    expect(@gemspec.email).to eq('morrow748@gmail.com')
  end

  it 'has a homepage' do
    expect(@gemspec.homepage).to eq('https://github.com/enkessler/cql')
  end

  describe 'license' do

    it 'has a current license' do
      license_text = File.read("#{File.dirname(__FILE__)}/../../../LICENSE.txt")

      expect(license_text).to match(/Copyright.*2014-#{Time.now.year}/)
    end

    it 'uses the MIT license' do
      license_text = File.read("#{File.dirname(__FILE__)}/../../../LICENSE.txt")

      expect(license_text).to include('MIT License')
      expect(@gemspec.licenses).to match_array(['MIT'])
    end

  end


  describe 'metadata' do

    it 'links to the changelog' do
      expect(@gemspec.metadata['changelog_uri']).to eq('https://github.com/enkessler/cql/blob/master/CHANGELOG.md')
    end

    it 'links to the known issues/bugs' do
      expect(@gemspec.metadata['bug_tracker_uri']).to eq('https://github.com/enkessler/cql/issues')
    end

    it 'links to the source code' do
      expect(@gemspec.metadata['source_code_uri']).to eq('https://github.com/enkessler/cql')
    end

    it 'links to the home page of the project' do
      expect(@gemspec.metadata['homepage_uri']).to eq(@gemspec.homepage)
    end

    it 'links to the gem documentation' do
      expect(@gemspec.metadata['documentation_uri']).to eq('https://www.rubydoc.info/gems/cql')
    end

  end


  describe 'included files' do

    it 'does not include files that are not source controlled' do
      bad_file_1 = File.absolute_path("#{lib_folder}/foo.txt")
      bad_file_2 = File.absolute_path("#{features_folder}/foo.txt")

      begin
        FileUtils.touch(bad_file_1)
        FileUtils.touch(bad_file_2)

        gem_files = @gemspec.files.map { |file| File.absolute_path(file) }

        expect(gem_files).to_not include(bad_file_1, bad_file_2)
      ensure
        FileUtils.rm([bad_file_1, bad_file_2])
      end
    end

    it 'does not include just any source controlled file' do
      some_files_not_to_include = ['.travis.yml', 'Gemfile', 'Rakefile']

      some_files_not_to_include.each do |file|
        expect(@gemspec.files).to_not include(file)
      end
    end

    it 'includes all of the library files' do
      lib_files = Dir.chdir(root_dir) do
        Dir.glob('lib/**/*').reject { |file| File.directory?(file) }
      end

      expect(@gemspec.files).to include(*lib_files)
    end

    it 'includes all of the documentation files' do
      feature_files = Dir.chdir(root_dir) do
        Dir.glob('testing/cucumber/features/**/*').reject { |file| File.directory?(file) }
      end

      expect(@gemspec.files).to include(*feature_files)
    end

    it 'includes the README file' do
      readme_file = 'README.md'

      expect(@gemspec.files).to include(readme_file)
    end

    it 'includes the license file' do
      license_file = 'LICENSE.txt'

      expect(@gemspec.files).to include(license_file)
    end

    it 'includes the CHANGELOG file' do
      changelog_file = 'CHANGELOG.md'

      expect(@gemspec.files).to include(changelog_file)
    end

    it 'includes the gemspec file' do
      gemspec_file = 'cql.gemspec'

      expect(@gemspec.files).to include(gemspec_file)
    end

  end


  describe 'dependencies' do

    it 'works with Ruby 2 and 3' do
      ruby_version_limits = @gemspec.required_ruby_version.requirements.map(&:join)

      expect(ruby_version_limits).to match_array(['>=2.0', '<4.0'])
    end

    it 'works with CukeModeler 1-3' do
      cuke_modeler_version_limits = @gemspec.dependencies
                                            .find do |dependency|
                                              (dependency.type == :runtime) &&
                                                (dependency.name == 'cuke_modeler')
                                            end
                                            .requirement.requirements.map(&:join)

      expect(cuke_modeler_version_limits).to match_array(['>=1.0', '<4.0'])
    end

  end

end


RSpec.describe CQL do

  it "has a version number" do
    expect(CQL::VERSION).not_to be nil
  end

end
