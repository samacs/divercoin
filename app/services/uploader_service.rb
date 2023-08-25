class UploaderService < BaseService
  class << self
    def actions
      [
        Uploads::UploadFileAction
      ]
    end
  end
end
