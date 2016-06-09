module DevicesHelper
  def devices_permitted_actors_for(device)
    device.developers + device.permitted_users
  end

  def devices_last_checkin(device)
    if device.checkins.exists?
      last_checkin = device.checkins.first
      postcode = last_checkin.postal_code
      last_checkin.address = last_checkin.address.gsub(' ' + postcode, '') if postcode
      "<p>Last reported in #{last_checkin.address} on #{humanize_date_and_time(last_checkin.created_at)}</p>".html_safe
    else
      '<p>No Checkins found</p>'.html_safe
    end
  end

  def devices_delay_icon(value)
    if value
      '<i class="material-icons">timer</i>'.html_safe
    else
      '<i class="material-icons disabled-icon">timer</i>'.html_safe
    end
  end

  def devices_shared_icon(device)
    if device.published?
      '<i class="material-icons">visibility</i>'.html_safe
    else
      '<i class="material-icons disabled-icon">visibility</i>'.html_safe
    end
  end

  def devices_access_icon
    '<i class="material-icons">not_interested</i>'.html_safe
  end

  def devices_shared_link(device)
    return nil unless device.published?
    link = shared_user_device_url(id: device.id, user_id: device.user_id)
    output = text_field_tag(nil, link, class: 'linkbox', id: "linkbox#{device.id}")
    output << content_tag(:i, 'assignment',
                          class: 'material-icons tooltipped clip_button hide',
                          data: {
                            'clipboard-target': "linkbox#{device.id}",
                            tooltip: 'Click to copy', position: 'right'
                          })
    output
  end
end
