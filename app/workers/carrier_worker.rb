class CarrierWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
    
    def perform()
       Carrier.carry
    end
  end