# :category: Business Class
#
# Document the responsibility of the class...
#
# Base Module:: rdoc-ref:Namespace
# Base Class::  Namespace::Class
#
# ===== Examples
#
# Illustrate the behaviour of the class using examples. Indent examples:
#
#   base = Base.new("Example String")
#   base.method_name("Example", "more")
#
# ===== Related Links
#
# * Namespace::Class
# * Namespace::Class#single_word_instance_method
# * Namespace::Class::single_word_class_method
# * Namespace::Class@Heading1
# * Namespace::Class#single_word_instance_method@Heading1
# * Namespace::Class::single_word_class_method@Heading+With+Multiple+Words
#
# Author::    Leo M. Peres <mailto:leomperes@belanton.com>
# Copyright:: Copyright (c) %y by %o. All Rights Reserved.
# License::   Licensed under the MIT license [www.opensource.org/licenses/mit-license.php]
#
class Car

  # RDOC documents constants as well
  # MAX_NUMBER_OF_BOOKINGS = 3.freeze

  # Write comments above for accessors, this will be presented as [R/W]
  attr_accessor :year, :make, :model, :trim

  # However this one will be presented as [R].
  # attr_reader :year, :make, :model, :trim

  # Read only attributes. Generally used for counter cache.
  # attr_readonly :associations_count, ...

  # Model associations.
  # belongs_to :association_name, class_name: 'Namespace::Class',
  #            counter_cache: :classes_count
  #
  # has_many :association_name, -> { order :field_name }, dependent: :destroy,
  #          through: :othoer_association_name, class_name: 'Namespace::Class'
  # accepts_nested_attributes_for :association_name, allow_destroy: true,
  #                               reject_if: lambda { |i| i[:field1_name].blank? && i[:field2_name].blank? }

  # Related gems and API's settings.
  # has_paper_trail

  # Model validations.
  # validates :user_id, presence: true

  # Model callbacks.
  # before_initialize :method_name
  # before_save :method_name
  # after_initialize :method_name
  # after_save :method_name

  # Model concerns inclusions.
  # include ModelConcernable

  # Remember the letters in the initial word...
  def initialize(attributes = {}) # :notnew: stops RDoc from seeing the initialize method as the new method.
    @year  = attributes[:year]
    @make  = attributes[:make]
    @model = attributes[:model]
    @trim  = attributes[:trim]
  end

  def normalize
    normalize_year
    normalize_make
    normalize_model
    normalize_trim
  end

  # Private methods if applicable.

  private

  # Valid years are from 1900 until 2 years in the future from today.
  def normalize_year
    @year = @year.to_i.between?(1900, Time.now.year + 2) ? @year.to_i : '200'
  end

  def normalize_make
    # # Valid years are from 1900 until 2 years in the future from today.
    # if input[:make].includes?('Ford')
    #   1900..2.years.from_now
    # end
  end

  # Sometimes the trim of a vehicle will be provided in the "model" field,
  # and will need to be extracted to the "trim" field.
  def normalize_model
  end

  # The word "blank" should be returned as nil.
  def normalize_trim
  end

end