module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def bootstrap_class_for(flash_type)
    {
        success: 'alert-success',
        error: 'alert-error',
        alert: 'alert-danger',
        notice: 'alert-info',
        danger: 'alert-danger',
        warning: 'alert-warning',
        info: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def bootstrap_glyphs_icon(flash_type)
    {
        success: 'glyphicon-ok',
        error: 'glyphicon-exclamation-sign',
        alert: 'glyphicon-warning-sign',
        notice: 'glyphicon-info-sign',
        danger: 'glyphicon-exclamation-sign',
        warning: 'glyphicon-warning-sign',
        info: 'glyphicon-info-sign'
    }[flash_type.to_sym] || 'glyphicon-screenshot'
  end

  def card_event_date(event)
    return "#{t('today')} #{event.start_date.strftime('%H:%S')}" if event.start_date.today?
    return "#{t('tomorrow')} #{event.start_date.strftime('%H:%S')}" if event.start_date.to_date == Date.tomorrow
    event.start_date.strftime('%Y/%m/%d %H:%M')
  end

  def card_event_price(event)
    return t('free') unless event.paid
    "#{t('paid')}: #{format('%.2f', event.price)}€"
  end

  def event_index_header(type, group)
    if type.present? && group.present? && group.eql?('place')
      t('places.plural.' + type)
    elsif type.present? && group.present? && group.eql?('category')
      t('categories.plural.' + type)
    else
      t('all_events')
    end
  end

  def event_start_date(event)
    return event.start_date.strftime('%Y/%m/%d %H:%M') if event.start_date.present?
    Time.zone.now.strftime('%Y/%m/%d %H:%M')
  end

  def event_end_date(event)
    return event.end_date.strftime('%Y/%m/%d %H:%M') if event.end_date.present?
    (Time.zone.now + 2.hours).strftime('%Y/%m/%d %H:%M')
  end
end
