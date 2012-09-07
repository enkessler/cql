module CQL
  class SsoHandlerChain
    def has_tags given_tags, search
      return false if given_tags == nil
      search.count { |tag_for_search| given_tags.map { |given_tag| given_tag["name"] }.include?(tag_for_search) }==search.size
    end

    def comparison_operator(fn)
      operator = fn.split("_")[1]
      {"lt"=>'<', 'lte'=>'<=', 'gt'=>'>', 'gte'=>'>='}[operator]
    end

    def line_handler(line_to_match, input)
      input.each_with_index do |feature, index|
        filtered_elements= feature['elements'].find_all do |sso|
          raw_step_lines = sso['steps'].map { |sl| sl['name'] }
          result = nil
          if line_to_match.class == String
            result = raw_step_lines.include? line_to_match
          elsif line_to_match.class == Regexp
            result = raw_step_lines.find { |line| line =~ line_to_match }
            if result.class == String
              result = result.size > 0
            else
              result = false
            end
          end
          result
        end
        input[index]['elements'] = filtered_elements
      end
    end

    def tag_search_handler(args, input)
      input.each_with_index do |feature, index|
        features_with_contents_filtered = feature['elements'].find_all do |sso|
          has_tags(sso['tags'], args['tags'])
        end
        input[index]['elements'] = features_with_contents_filtered
      end
    end

    def handle(args, input)
      line_handler(args['line'].first, input) if args.has_key?('line')
      tag_search_handler(args, input) if args.has_key?('tags')
      input
    end

  end
end