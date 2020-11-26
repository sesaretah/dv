class CarrierWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
    
    def perform(id)
       Carrier.carry(id)
    end
  end