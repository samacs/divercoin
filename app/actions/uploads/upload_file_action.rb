module Uploads
  class UploadFileAction < BaseAction
    expects :file

    promises :filename, :directory, :filepath

    executed do |ctx|
      ctx.filename = ctx.file.original_filename
      ctx.filepath = Rails.root.join('storage/uploads', ctx.filename)
      ctx.directory = File.dirname(ctx.filepath)

      FileUtils.mkdir_p(ctx.directory) unless File.directory?(ctx.directory)
    end
  end
end
