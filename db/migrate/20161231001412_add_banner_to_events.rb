class AddBannerToEvents < ActiveRecord::Migration[5.0]
  def change
    add_attachment :events, :banner
  end
end
