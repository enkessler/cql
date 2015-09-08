Then(/^the following values are returned:$/) do |values|
  expected_results = values.hashes
  expected_results.each { |result| result['source_line'] = result['source_line'].to_i if result['source_line'] }
  expected_results.each { |result| result['tags'] = eval(result['tags']) if result['tags'] }
  expected_results.each { |result| result['scenario_tags'] = eval(result['scenario_tags']) if result['scenario_tags'] }

  expected_results.each do |result|
    result.each_pair { |key, value| result[key] = value.sub('path/to', @default_file_directory) if value =~ /path\/to/ }
  end

  expect(@query_results).to eq(expected_results)
end

# Then(/^all of them can be queried for additional information$/) do
#
#   expect(@cm_models).to_not be_empty
#
#   @cm_models.each do |model|
#     raise("Expected #{model} to define :query") unless model.method_defined?(:query)
#   end
#
# end

Then(/^the models for the following items are returned:$/) do |item_names|
  expected_results = item_names.raw.flatten

  expect(@query_results.all? { |result| result.is_a?(CukeModeler::FeatureElement) }).to eq(true)
  expect(@query_results.collect { |result| result.name }).to match_array(expected_results)
end

Then(/^the result is the same as the result of the following query:$/) do |query_text|
  command = "@repository.query do
               #{query_text}
             end"

  baseline_results = eval(command)

  expect(@query_results).to eq(baseline_results)
end
