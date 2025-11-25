class CallLogsController < ApplicationController
  def index
    @call_logs = CallLog.order(created_at: :desc).limit(200)
  end
end
