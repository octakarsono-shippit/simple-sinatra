class MyApp < Sinatra::Base
  post '/v2/shipments' do
    content_type :json
    random_id = SecureRandom.uuid
    {
      id: "shpp_#{random_id}",
      reference: 'ref-1234567890',
      tracking_code: '1234567890',
      postage_label: {
        id: 'label_1234567890',
        label_date: '2021-01-01',
        label_resolution: 300,
        label_size: '4x6',
        label_type: 'PDF',
        label_url: '',
        label_pdf_url: 'http://localhost:4567/pdfs/label_01.pdf',
      }
    }.to_json
  end

  post '/v2/shipments/:id/refund' do
    shipment_id = params[:id]

    submitted = 'submitted'
    refunded = 'refunded'
    rejected = 'rejected'
    not_applicable = 'not_applicable'

    chosen_status = [submitted, refunded, rejected, not_applicable].sample
    chosen_status = rejected
    # chosen_status = 'rogue_agent'

    fatal = false
    raise 'unknown fatal error' if fatal

    # content_type :json
    if chosen_status == refunded || chosen_status == submitted
      status 202
      {
        id: shipment_id,
        reference: 'ref-1234567890',
        refund_status: chosen_status
      }.to_json
    else
      status 422
      {
        message: 'Fatal error during refund',
        cause: 'Shipment has been delivered',
        error_code: 'PAY_AS_YOU_GO_DISABLED',
        refund_status: chosen_status
      }.to_json

      "Hello bad world"
    end

  rescue => e
    status 500
    {
      error: e.message
    }.to_json
  end
end
