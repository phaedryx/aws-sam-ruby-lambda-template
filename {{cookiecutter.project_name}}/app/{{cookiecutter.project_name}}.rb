# frozen_string_literal: true

require 'logger'

def lambda_handler(event:, context:)
  available_gems = system("gem list --local")
  {
    event: event,
    context: context,
    available_gems: available_gems,
    environment: ENV.to_h
  }
rescue => err
  logger = Logger.new($stdout)
  logger.error(
    error: err.message,
    backtrace: err.backtrace,
    event: event,
    context: context,
  )
end
