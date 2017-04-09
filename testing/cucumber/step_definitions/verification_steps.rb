Then(/^the following values are returned:$/) do |values|
  expected_keys = values.raw.first
  expected_values = values.rows

  expected_values.each { |result| result.collect! { |value| value =~ /^\d+$/ ? value.to_i : value } }

  @query_results.each_with_index do |result, index|
    # Key order doesn't matter and Ruby 1.8.7 does not retain hash key ordering, so sorting them for consistency
    expect(result.keys.sort).to eq(expected_keys.sort)
    expect(result.values).to eq(expected_values[index])
  end

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

Then(/^all of them can be queried$/) do |code_text|
  original_text = code_text

  @available_model_classes.each do |clazz|
    code_text = original_text.gsub('<model_class>', clazz.to_s)

    expect(clazz.new).to respond_to(:query)

    # Make sure that the example code is valid
    expect { eval(code_text) }.to_not raise_error
  end
end

Then(/^all models are queried from$/) do
  # Just making sure that multiple model results are returned
  expect(@query_results.count).to be > 1

  @query_results.each do |result|
    class_name = result[:model].class.name.split('::').last

    expect(CukeModeler.const_defined?(class_name)).to be true
  end
end

And(/^equivalent results are returned for the following query:$/) do |query_text|
  command = "@repository.query do
               #{query_text}
             end"

  alternate_results = eval(command)

  # Only checking the values of the results because they will have different :model/:self keys
  expect(alternate_results.collect { |result| result.values }).to eq(@query_results.collect { |result| result.values })
end
