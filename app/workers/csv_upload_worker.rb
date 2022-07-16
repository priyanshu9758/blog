class CsvUploadWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1
  def perform(row)
    Account.import(row)
  end
end
