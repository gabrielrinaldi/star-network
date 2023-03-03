# frozen_string_literal: true

module QrCodeHelper
  def qr_code_as_svg(uri)
    # rubocop:disable Rails/OutputSafety
    RQRCode::QRCode.new(uri).as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 4,
      standalone: true
    ).html_safe
    # rubocop:enable Rails/OutputSafety
  end
end
