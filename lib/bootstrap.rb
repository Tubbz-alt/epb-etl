# frozen_string_literal: true

require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}")
loader.setup

def handler(event:, context:)
  Handler.process event: event, context: context
end
