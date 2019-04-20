require "#{File.dirname(__FILE__)}/spec_helper"


describe 'the gem' do

  let(:gemspec) { eval(File.read "#{File.dirname(__FILE__)}/../../../cql.gemspec") }


  it 'validates cleanly' do
    mock_ui = Gem::MockGemUi.new
    Gem::DefaultUserInteraction.use_ui(mock_ui) { gemspec.validate }

    expect(mock_ui.error).to_not match(/warn/i)
  end

end


describe CQL do

  it "has a version number" do
    expect(CQL::VERSION).not_to be nil
  end

end
