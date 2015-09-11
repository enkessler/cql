When(/^the following query is executed:$/) do |query_text|
  command = "@repository.query do
               #{query_text}
             end"

  @query_results = eval(command)
end
