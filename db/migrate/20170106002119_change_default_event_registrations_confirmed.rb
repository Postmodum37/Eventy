class ChangeDefaultEventRegistrationsConfirmed < ActiveRecord::Migration[5.0]
  def change
    change_column_default :event_registrations, :confirmed, nil
  end
end
