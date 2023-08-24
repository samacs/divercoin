module FlashMessagesHelper
  FLASH_MESSAGE_COLOR = {
    info: {
      background: 'text-blue-800 bg-blue-50 dark:text-blue-400'
    },
    success: {
      background: 'text-green-800 bg-green-50 dark:text-green-400'
    },
    warning: {
      background: 'text-amber-800 bg-amber-50 dark:text-amber-400'
    },
    error: {
      background: 'text-red-800 bg-red-50 dark:text-red-400'
    }
  }.freeze

  def flash_message_color(type, color)
    FLASH_MESSAGE_COLOR[type.to_sym][color.to_sym]
  end
end
