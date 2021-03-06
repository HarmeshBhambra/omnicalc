class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @spaces_count = @text.count(' ')

    @character_count_without_spaces = @text.gsub(/\s+/, "").length

    @word_count = @text.split(/\s+/).length

    text_withoutextras = @text.gsub(/[^a-z0-9\s]/i, '')

    downcase_text = text_withoutextras.downcase

    @occurrences = downcase_text.split(' ').count(@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    payments = @years * 12

    effective_r = @apr / 1200

    denominator = 1 - ((1 + effective_r) ** (payments * -1))

    @monthly_payment = @principal * effective_r / denominator
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count - 1]

    @range = @maximum - @minimum

    @median = ( @sorted_numbers [((@sorted_numbers.length-1) / 2)]  + @sorted_numbers[(@sorted_numbers.length / 2 )]  ) / 2

    @sum = @numbers.inject 0, :+

    @mean = @sum / @count

    @variance = @numbers.inject(0.0) {|s,x| s + (x - @mean)**2} / @count

    # squared_differences = []

    # @numbers.each do |num|
    #   difference = num - @mean
    #   squared_difference = difference ** 2
    #   squared_differences.push(squared_difference)
    # end

    # @variance = squared_differences.sum / @count


    # @standard_deviation = Math.sqrt(@variance)

    @standard_deviation = @variance ** 0.5

    count = Hash.new(0)

    @numbers.each {|number| count[number] +=1}

    @mode = count.invert.keys.sort.last

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
