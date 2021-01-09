require "#{File.dirname(__FILE__)}/spec_helper"


describe 'the gem' do

  let(:gemspec) { eval(File.read "#{File.dirname(__FILE__)}/../../../cql.gemspec") }


  it 'validates cleanly' do
    mock_ui = Gem::MockGemUi.new
    Gem::DefaultUserInteraction.use_ui(mock_ui) { gemspec.validate }

    expect(mock_ui.error).to_not match(/warn/i)
  end

  it 'has a current license' do
    license_text = File.read("#{File.dirname(__FILE__)}/../../../LICENSE.txt")

    expect(license_text).to match(/Copyright.*2014-#{Time.now.year}/)
  end

end


describe CQL do

  it "has a version number" do
    expect(CQL::VERSION).not_to be nil
  end

end
