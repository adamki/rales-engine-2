namespace :data do
  desc "importing all CSV data"
  task :import => :environment do
    ImportCsvService.import_data
  end
end
