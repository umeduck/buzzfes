class AppLogger
  class << self
    # Rails.loggerをベースにする
    def logger
      @logger ||= Rails.logger
    end

    def info(message)
      logger.info(format_message(message))
    end

    def warn(message)
      logger.warn(format_message(message))
    end

    def error(message)
      logger.error(format_message(message))
    end

    def debug(message)
      logger.debug(format_message(message))
    end

    private

    # ログフォーマットを共通化したい場合
    def format_message(message)
      "[#{Time.current.strftime('%Y-%m-%d %H:%M:%S')}] #{message}"
    end
  end
end