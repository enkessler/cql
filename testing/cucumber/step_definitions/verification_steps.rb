Then(/^the following values are returned:$/) do |values|
  expected_results = values.hashes
  expected_results.each { |result| result['source_line'] = result['source_line'].to_i if result['source_line'] }
  expected_results.each { |result| result['scenario_line'] = result['scenario_line'].to_i if result['scenario_line'] }
  expected_results.each { |result| result['tags'] = eval(result['tags']) if result['tags'] }
  expected_results.each { |result| result['scenario_tags'] = eval(result['scenario_tags']) if result['scenario_tags'] }

  expected_results.each do |result|
    result.each_pair { |key, value| result[key] = value.sub('path/to', @default_file_directory) if value =~ /path\/to/ }
  end

  expect(@query_results).to match_array(expected_results)
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

  expect(@query_results.collect { |result| result[:self].name }).to match_array(expected_results)
end

Then(/^the result is the same as the result of the following query:$/) do |query_text|
  command = "@repository.query do
               #{query_text}
             end"

  baseline_results = eval(command)

  expect(@query_results).to eq(baseline_results)
end

Then(/^the following code executes without error:$/) do |code_text|
  code_text = process_path(code_text)

  expect { eval(code_text) }.to_not raise_error
end

And(/^equivalent results are returned for the following query:$/) do |query_text|
  command = "@repository.query do
               #{query_text}
             end"

  alternate_results = eval(command)

  # Only checking the values of the results because they will have different :model/:self keys
  expect(alternate_results.collect { |result| result.values }).to eq(@query_results.collect { |result| result.values })
end
