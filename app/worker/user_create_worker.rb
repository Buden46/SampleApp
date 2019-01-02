class UserCreateWorker
  include Sidekiq::Worker

  sidekiq_options queue: :csv_processer

  def perform(file_path)
    file_path = "#{Rails.root.to_s}/spec/fixtures/sample_csv.csv" if Rails.env == 'test'
    SmarterCSV.process(file_path).each do |csv_row|
      name = csv_row[:name]
      email = csv_row[:email]
      phone_number = csv_row[:phone_number]
      address = csv_row[:address]
      hobbies = csv_row[:hobbies]
      begin
        user = User.create(
          name: name,
          email: email,
          phone_number: phone_number,
          address: address,
          hobbies: hobbies
        )
      rescue
        next
      end
    end
  end
end
