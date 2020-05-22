# frozen_string_literal: true

require 'logger'

def lambda_handler(event:, context:)
  available_gems = `gem list --local`
  {
    event: event,
    context: {
      function_name: context.function_name,
      function_version: context.function_version,
      invoked_function_arn: context.invoked_function_arn,
      memory_limit_in_mb: context.memory_limit_in_mb,
      aws_request_id: context.aws_request_id,
      log_group_name: context.log_group_name,
      log_stream_name: context.log_stream_name,
      deadline_ms: context.deadline_ms,
      identity: context.identity,
      client_context: context.client_context,
    },
    environment: ENV.to_h,
    available_gems: available_gems.split("\n"),
  }
rescue => err
  logger = Logger.new($stdout)
  logger.error(
    error: err.message,
    backtrace: err.backtrace,
    event: event,
  )
end
