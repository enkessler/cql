Then(/^the following values are returned":$/) do |values|
  expected_results = values.hashes
  expected_results.each { |result| result['source_line'] = result['source_line'].to_i if result['source_line'] }

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
