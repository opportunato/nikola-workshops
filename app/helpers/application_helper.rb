module ApplicationHelper
  def angular_form_tag(title, model, tag='input', clear_classes=false, options={})
    content_tag('div', class: 'form-group') do
      content_tag('label', title, for: model, class: 'form-element') +
      content_tag(tag, "", options.merge({"ng-model" => model, :id => model, :class => ('form-control' if !clear_classes)}))
    end
  end

  def intro_image_url
    images = ['bg1.jpg', 'bg2.jpg', 'bg3.jpg', 'bg4.jpg', 'bg5.jpg']

    image_path(images.sample)
  end

  def startpage_action?
    controller.controller_name == 'startpage' && controller.action_name == 'index'
  end

  def workshop_action?
    controller.controller_name == 'workshops' && controller.action_name == 'show'
  end
end
