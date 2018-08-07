# Ruby version:: 2.5.1

# require 'active_support/duration'
# require 'active_support/core_ext/numeric/time'

require_relative 'car'

def normalize_data(input)
  # input[:year] = normalize_year(input[:year])
  # input[:make] = normalize_make(input[:make])
  # input[:model] = normalize_model(input[:model])
  # input[:trim] = normalize_trim(input[:trim])

  # input[:year] = if input[:year].to_i.between?(1900, Time.now.year + 2)
  #                  input[:year]
  #                else
  #                  'INVALID'
  #                end

  # year = input[:year]
  # year.to_i.between?(1900, Time.now.year + 2) ? year : 'INVALID'

  car = Car.new(input)
  car.normalize

  car.instance_variables.each_with_object({}) do |var, hash|
    hash[var.to_s.delete('@').to_sym] =
      car.instance_variable_get(var)
  end
  # car.attributes
  # car.inspect
  # Hash.new car
  # car.print_values
end

examples = [
  [{ :year => '2018', :make => 'fo', :model => 'focus', :trim => 'blank' },
   { :year => 2018, :make => 'Ford', :model => 'Focus', :trim => nil }],
  [{ :year => '200', :make => 'blah', :model => 'foo', :trim => 'bar' },
   { :year => '200', :make => 'blah', :model => 'foo', :trim => 'bar' }],
  [{ :year => '1999', :make => 'Chev', :model => 'IMPALA', :trim => 'st' },
   { :year => 1999, :make => 'Chevrolet', :model => 'Impala', :trim => 'ST' }],
  [{ :year => '2000', :make => 'ford', :model => 'focus se', :trim => '' },
   { :year => 2000, :make => 'Ford', :model => 'Focus', :trim => 'SE' }]
]

examples.each_with_index do |(input, expected_output), index|
  if (output = normalize_data(input)) == expected_output
    puts "Example #{index + 1} passed!"
  else
    puts "Example #{index + 1} failed,
          Expected: #{expected_output.inspect}
          Got:      #{output.inspect}"
  end
end
