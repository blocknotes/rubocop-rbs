# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/rbs'
require_relative 'rubocop/rbs/version'
require_relative 'rubocop/rbs/inject'

RuboCop::Rbs::Inject.defaults!

require_relative 'rubocop/cop/rbs_cops'
