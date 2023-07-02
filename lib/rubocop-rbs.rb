# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/rbs'
require_relative 'rubocop/rbs/version'
require_relative 'rubocop/rbs/inject'

RuboCop::Rbs::Inject.defaults!

RuboCop::Runner.prepend(Module.new do
  def file_offense_cache(_file)
    # NOTE: skip cache because we need to monitor .rbs and their related .rb
    yield
  end
end)

# RuboCop::Config.prepend(Module.new do
#   def file_to_include?(file)
#     super || File.extname(file) == '.rbs'
#   end
# end)

require_relative 'rubocop/cop/rbs_cops'
