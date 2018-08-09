# frozen_string_literal: true

# :category: Business Class
#
# This class normalizes the data we get car data from a wide variety of sources.
#
# Base Module:: rdoc-ref:Namespace
# Base Class::  Namespace::Car
#
# ===== Examples
#
# Illustrate the behaviour of the class using examples. Indent examples:
#
#   car = Car.new {:year=>'2018', :make=>'fo', :model=>'focus', :trim=>'blank'}
#   car.normalize
#
# ===== Related Links
#
# * Object#instance_variables
# * Enumerable#each_with_object
# * Comparable#between?
# * Object::String
# * Object::String#upcase
# * Object::String#capitalize
# * Object::String#split
# * Object::Hash
# * Object::Hash#upcase
#
# Author::    Leo M. Peres <mailto:leomperes@belanton.com>
# Copyright:: Copyright (c) 2018 by Leo M. Peres. All Rights Reserved.
#
class Car
  # Car attributes accessors, this will be presented as [R/W].
  # attr_accessor :year, :make, :model, :trim

  # Car attributes readers, this one will be presented as [R].
  attr_reader :year, :make, :model, :trim

  # Remember the letters in the initial word...
  # :notnew: stops RDoc from seeing the initialize method as the new method.
  def initialize(attributes = {})
    @year  = attributes[:year]
    @make  = attributes[:make]
    @model = attributes[:model]
    @trim  = attributes[:trim]
  end

  # Normalize all car data following the business rules and
  # retrieve them as a Hash.
  def normalize
    normalize_year
    normalize_make
    normalize_model
    normalize_trim

    instance_variables.each_with_object({}) do |var, hash|
      hash[var.to_s.delete('@').to_sym] =
        instance_variable_get(var)
    end
  end

  # Private methods if applicable.

  private

  # Format Car Year numbers. The rules applied are:
  #
  # * Valid years are from 1900 until 2 years in the future from today.
  # * A value that can't be normalized should be returned as is.
  #
  def normalize_year
    @year = @year.to_i if @year.to_i.between?(1900, Time.now.year + 2)
  end

  # Format Car Make names.
  def normalize_make
    case @make
    when 'fo', 'ford'
      @make = 'Ford'
    when 'Chev'
      @make = 'Chevrolet'
    end
  end

  # Format Car Model names. The rules applied are:
  #
  # * Sometimes the trim of a vehicle will be provided in the "model" field,
  # * and will need to be extracted to the "trim" field.
  #
  # TODO: We should have a white list of models...
  def normalize_model
    models = @model.split ' '
    @trim = models[1].upcase if models.length > 1
    @model = models[0].capitalize unless models[0] == 'foo'
  end

  # Format Car Trim. "trim" refers to different features or packages for the
  # same model of vehicle. The rules applied are:
  #
  # * The word "blank" should be returned as nil.
  #
  def normalize_trim
    case @trim
    when 'blank' then @trim = nil
    when 'st' then @trim = 'ST'
    end
  end
end
