require "#{File.dirname(__FILE__)}/spec_helper"


describe 'the gem' do

  let(:root_dir) { "#{__dir__}/../../.." }
  let(:gemspec) { eval(File.read "#{File.dirname(__FILE__)}/../../../cql.gemspec") }
  let(:lib_folder) { "#{root_dir}/lib" }
  let(:features_folder) { "#{root_dir}/testing/cucumber/features" }


  it 'validates cleanly' do
    mock_ui = Gem::MockGemUi.new
    Gem::DefaultUserInteraction.use_ui(mock_ui) { gemspec.validate }

    expect(mock_ui.error).to_not match(/warn/i)
  end

  it 'has a current license' do
    license_text = File.read("#{File.dirname(__FILE__)}/../../../LICENSE.txt")

    expect(license_text).to match(/Copyright.*2014-#{Time.now.year}/)
  end


  describe 'metadata' do

    it 'links to the changelog' do
      expect(gemspec.metadata['changelog_uri']).to eq('https://github.com/enkessler/cql/blob/master/CHANGELOG.md')
    end

    it 'links to the known issues/bugs' do
      expect(gemspec.metadata['bug_tracker_uri']).to eq('https://github.com/enkessler/cql/issues')
    end

    it 'links to the source code' do
      expect(gemspec.metadata['source_code_uri']).to eq('https://github.com/enkessler/cql')
    end

    it 'links to the home page of the project' do
      expect(gemspec.metadata['homepage_uri']).to eq('https://github.com/enkessler/cql')
    end

    it 'links to the gem documentation' do
      expect(gemspec.metadata['documentation_uri']).to eq('https://www.rubydoc.info/gems/cql')
    end

  end


  describe 'included files' do

    it 'does not include files that are not source controlled' do
      bad_file_1 = File.absolute_path("#{lib_folder}/foo.txt")
      bad_file_2 = File.absolute_path("#{features_folder}/foo.txt")

      begin
        FileUtils.touch(bad_file_1)
        FileUtils.touch(bad_file_2)

        gem_files = gemspec.files.map { |file| File.absolute_path(file) }

        expect(gem_files).to_not include(bad_file_1, bad_file_2)
      ensure
        FileUtils.rm([bad_file_1, bad_file_2])
      end
    end

    it 'does not include just any source controlled file' do
      some_files_not_to_include = ['.travis.yml', 'Gemfile','Rakefile']

      some_files_not_to_include.each do |file|
        expect(gemspec.files).to_not include(file)
      end
    end

    it 'includes all of the library files' do
      lib_files = Dir.chdir(root_dir) do
        Dir.glob('lib/**/*').reject { |file| File.directory?(file) }
      end

      expect(gemspec.files).to include(*lib_files)
    end

    it 'includes all of the documentation files' do
      feature_files = Dir.chdir(root_dir) do
        Dir.glob('testing/cucumber/features/**/*').reject { |file| File.directory?(file) }
      end

      expect(gemspec.files).to include(*feature_files)
    end

    it 'includes the README file' do
      readme_file = 'README.md'

      expect(gemspec.files).to include(readme_file)
    end

    it 'includes the license file' do
      license_file = 'LICENSE.txt'

      expect(gemspec.files).to include(license_file)
    end

    it 'includes the CHANGELOG file' do
      changelog_file = 'CHANGELOG.md'

      expect(gemspec.files).to include(changelog_file)
    end

    it 'includes the gemspec file' do
      gemspec_file = 'cql.gemspec'

      expect(gemspec.files).to include(gemspec_file)
    end

  end

end


describe CQL do

  it "has a version number" do
    expect(CQL::VERSION).not_to be nil
  end

end
